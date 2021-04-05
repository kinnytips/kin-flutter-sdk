import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

// import 'package:kin_sdk/base/models/as_public_key.dart'; // can't find this file
// import 'package:kin_sdk/base/models/key.dart';
// import 'package:kin_sdk/base/tools/byte_utils.dart';
// import 'package:kin_sdk/base/tools/sort.dart';
import 'package:kinny/base/models/solana/fixed_byte_array.dart';
import 'package:kinny/base/models/solana/instruction.dart';
import 'package:kinny/base/tools/extensions.dart';


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
  final List<Key.PublicKey> accounts;
  final List<CompiledInstruction> instructions;
  final Hash recentBlockhash;

  Message({
    @required this.header,
    @required this.accounts,
    @required this.instructions,
    @required this.recentBlockhash,
  });

  Message copyWith({
    header,
    accounts,
    instructions,
    recentBlockhash,
  }) =>
      Message(header: header ?? this.header,
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

  Transaction copyWith({
    message,
    signatures,
  }) =>
      Transaction(
        message: message ?? this.message,
        signatures: signatures ?? this.signatures,
      );

  static Transaction newTransaction(Key.PublicKey payer,
      List<Instruction> instructions) {
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
    final List<AccountMeta> uniqueAccounts =
    accounts.filterUnique().toList().quickSort();

    final header = Header(
      numSignatures: uniqueAccounts
          .where((element) => element.isSigner)
          .length,
      numReadOnlySigned: uniqueAccounts
          .where((element) => !element.isWritable && element.isSigner)
          .length,
      numReadOnly: uniqueAccounts
          .where((element) => !element.isWritable && !element.isSigner)
          .length,
    );
    final List<AccountMeta> accountPublicKeys = uniqueAccounts.map((e) =>
    e.publicKey).toList();
    final messageInstructions = instructions.map((e) =>
        CompiledInstruction(
            programIndex: _indexOf(accountPublicKeys, e.program).toByte(),
            data: e.data,
            accounts: Uint8List.fromList(e.accounts
                .map((e2) =>
                _indexOf(accountPublicKeys, e2.publicKey).toByte()))));

    final Message message = Message(
        header: header,
        accounts: accountPublicKeys,
        instructions: messageInstructions,
        recentBlockhash: Hash(FixedByteArray32());
      /** Empty unless set with [copyAndSetRecentBlockhash] **/
    );

    return Transaction(message: message);
  }

  static int _indexOf(List<Key.PublicKey> slice, Key.PublicKey item) {
    slice.asMap().forEach((i, publicKey) {
      if (ListEquality().equals(publicKey.value, item.value)) {
        return i;
      }
    });

    return -1;
  }

  Transaction copyAndSetRecentBlockhash(Hash recentBlockhash) {
    return copyWith(
        message: message.copyWith(recentBlockhash: recentBlockhash));
  }

  Transaction copyAndSign(List<Key.PrivateKey> signers) {
    if (signers.length > numRequiredSignatures) {
      throw Exception("IllegalArgumentException: too many signers");
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
      newSignatures[index] =
          Signature(
              value: FixedByteArray64(byteArray: element.sign(messageBytes)));
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
        if (ListEquality().equals(
            element.publicKey.value, accountMeta.publicKey.value)) {
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