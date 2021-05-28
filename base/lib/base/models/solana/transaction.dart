import 'dart:typed_data';
import 'package:kin_base/base/models/solana/byte_utils.dart';
import 'package:kin_base/base/models/solana/short_vec.dart';
import 'package:kin_base/base/tools/byte_in_out_buffer.dart';
import 'package:meta/meta.dart';

import 'package:kin_base/base/models/key.dart';
// import 'package:kin_sdk/base/tools/byte_utils.dart';
// import 'package:kin_sdk/base/tools/sort.dart';
import 'package:kin_base/base/models/solana/fixed_byte_array.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/tools/extensions.dart';

import 'encoding.dart';

class Signature {
  final FixedByteArray64 value;

  Signature({this.value});

  static const SIZE_OF = 64;
}

class Hash {
  final FixedByteArray32 value;

  Hash(this.value);

  static const SIZE_OF = 32;
}

class Header {
  final int numSignatures;
  final int numReadOnlySigned;
  final int numReadOnly;

  Header({this.numSignatures, this.numReadOnlySigned, this.numReadOnly});
}

class Message {
  final Header header;
  final List<PublicKey> accounts;
  final List<CompiledInstruction> instructions;
  final Hash recentBlockhash;

  Message({
    @required this.header,
    @required this.accounts,
    @required this.instructions,
    @required this.recentBlockhash,
  });

  factory Message.unmarshal(Uint8List bytesValue){
    final input = ByteInputBuffer(bytesValue);

    // Header
    final numSignatures = wrapError("failed to read num signatures", () => input.read());
    final numReadOnlySigned = wrapError("failed to read num readonly signatures", () => input.read());
    final numReadOnly = wrapError("failed to read num readonly", () => input.read());
    final Header header = Header(
        numSignatures: numSignatures,
        numReadOnlySigned: numReadOnlySigned,
        numReadOnly: numReadOnly,
    );

    // Accounts
    final accounts = ShortVec.decodeShortVecOf<PublicKey>(input, 32);

    // Recent Block Hash
    final recentBlockHash =
      wrapError("failed to read block hash", () {
        input.readBytes(Hash.SIZE_OF).toModel<Hash>((bytes) => Hash(FixedByteArray32(bytes)));
      });

    // Instructions
    final instructions = <CompiledInstruction>[];
    final instructionsLength = ShortVec.decodeLen(input);
    for (int i = 0; i < instructionsLength; i++) {
      // Program Index
      final programIndex = wrapError<int>("failed to read instruction[$i] program index", () => input.read());
      if (programIndex < 0 || programIndex >= accounts.length) {
        throw Exception("RuntimeException: program index out of range: $i:$programIndex");
      }

      // Account Indexes
      final accountIndexesLength = ShortVec.decodeLen(input);
      final accountIndexesBytes = wrapError("failed to read instruction[$i] accounts", () => input.readBytes(accountIndexesLength));


      accountIndexesBytes.forEach((element) {
        if (element.toInt() >= accounts.length) {
          throw Exception("RuntimeException: account index out of range: $i:$element");
        }
      });

      // Data
      final dataLength = wrapError("failed to read instruction[$i] data", () => ShortVec.decodeLen(input));
      final dataBytes = input.readBytes(dataLength);

      final instruction = CompiledInstruction(
        programIndex: programIndex,
        accounts: accountIndexesBytes,
        data: dataBytes,
      );
      instructions.add(instruction);
    }

    return Message(
      header:header,
      accounts: accounts,
      instructions: instructions,
      recentBlockhash: recentBlockHash,
    );
  }

  Message copyWith({
    header,
    accounts,
    instructions,
    recentBlockhash,
  }) =>
      Message(
        header: header ?? this.header,
        accounts: accounts ?? this.accounts,
        instructions: instructions ?? this.instructions,
        recentBlockhash: recentBlockhash ?? this.recentBlockhash,
      );
}

class Transaction {
  final Message message;
  final List<Signature> signatures;
  final int numRequiredSignatures;

  Transaction({@required this.message, this.signatures = const []})
      : numRequiredSignatures = message.header.numSignatures;

  factory Transaction.unmarshal(Uint8List bytes) {
    final input = ByteInputBuffer(bytes);

    final signatures = ShortVec.decodeShortVecOf(
        input, Signature.SIZE_OF, (bytes) => SignatureMarshal.unmarshal(bytes));

    var message = Message.unmarshal(input.readRemainingBytes());
    return Transaction(message: message, signatures: signatures);
  }
  Transaction copyWith({
    message,
    signatures,
  }) =>
      Transaction(
        message: message ?? this.message,
        signatures: signatures ?? this.signatures,
      );

  static Transaction newTransaction(
      PublicKey payer, List<Instruction> instructions) {
    final accounts = [
      AccountMeta(
        publicKey: payer,
        isSigner: true,
        isWritable: true,
        isPayer: true,
      )
    ];

    // Extract all of the unique accounts from the instructions.
    instructions.forEach((element) {
      accounts.add(AccountMeta(publicKey: element.program, isProgram: true));
    });

    // Sort the account meta's based on:
    //   1. Payer is always the first account / signer.
    //   1. All signers are before non-signers.
    //   2. Writable accounts before read-only accounts.
    //   3. Programs last
    final List<AccountMeta> uniqueAccounts = accounts.filterUnique().toList()
      ..sort();

    final header = Header(
      numSignatures: uniqueAccounts.where((element) => element.isSigner).length,
      numReadOnlySigned: uniqueAccounts
          .where((element) => !element.isWritable && element.isSigner)
          .length,
      numReadOnly: uniqueAccounts
          .where((element) => !element.isWritable && !element.isSigner)
          .length,
    );
    final List<PublicKey> accountPublicKeys =
        uniqueAccounts.map((e) => e.publicKey).toList();

    final messageInstructions = instructions.map((e) {
      return CompiledInstruction(
        programIndex: _indexOf(accountPublicKeys, e.program),
        data: e.data,
        accounts: Uint8List.fromList(e.accounts.map((e2) => _indexOf(accountPublicKeys, e2.publicKey)).toList()),
      );
    }).toList();

    final Message message = Message(
      header: header,
      accounts: accountPublicKeys,
      instructions: messageInstructions,
      recentBlockhash: Hash(FixedByteArray32()),
      /** Empty unless set with [copyAndSetRecentBlockhash] **/
    );

    return Transaction(message: message);
  }

  static int _indexOf(List<PublicKey> slice, PublicKey item) {
    slice.asMap().forEach((i, publicKey) {
      if (publicKey.value.equalsContent(item.value)) {
        return i;
      }
    });

    return -1;
  }

  Transaction copyAndSetRecentBlockhash(Hash recentBlockhash) {
    return copyWith(
        message: message.copyWith(recentBlockhash: recentBlockhash));
  }

  Transaction copyAndSign(List<PrivateKey> signers) {
    if (signers.length > numRequiredSignatures) {
      throw Exception("IllegalArgumentException: too many signers (${signers.length} > $numRequiredSignatures)");
    }

    final messageBytes = message.marshal();

    final List newSignatures = List.filled(numRequiredSignatures, null);
    newSignatures.asMap().forEach((index, signature) {
      newSignatures[index] = signature;
    });

    signers.forEach((element) {
      final pubKey = element.asPublicKey();
      final index = _indexOf(message.accounts, pubKey);
      if (index < 0) {
        throw Exception("IllegalArgumentException: "
            "signing account ${pubKey.value.toHexString()} "
            "is not in the account list");
      }
      newSignatures[index] = Signature(
          value: FixedByteArray64(element.sign(messageBytes)));
    });

    return copyWith(
        signatures: newSignatures.every((element) => element ?? Signature()));
  }
}

/// Provide a unique set by publicKey of AccountMeta with the highest write permission
extension on List<AccountMeta> {
  List<AccountMeta> filterUnique() {
    final filtered = <AccountMeta>[];

    outer:
    for (var element in this) {
      for (int i = 0; i < filtered.length; i++) {
        final accountMeta = filtered[i];
        if (element.publicKey.value
            .equalsContent(accountMeta.publicKey.value)) {
          // Promote the existing account to writable if applicable
          if (element.isSigner)
            filtered[i] = filtered[i].copyWith(isSigner: true);
          if (element.isWritable)
            filtered[i] = filtered[i].copyWith(isWritable: true);
          if (element.isPayer)
            filtered[i] = filtered[i].copyWith(isPayer: true);
          continue outer;
        }
      }
      filtered.add(element);
    }

    return filtered;
  }
}
