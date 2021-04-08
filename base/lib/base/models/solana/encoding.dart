import 'dart:typed_data';

import 'package:kinny/base/models/key.dart';
import 'package:kinny/base/models/solana/instruction.dart';
import 'package:kinny/base/models/solana/short_vec.dart';
import 'package:kinny/base/models/solana/transaction.dart';
import 'package:kinny/base/models/solana/fixed_byte_array.dart';
import 'package:kinny/base/models/solana/byte_utils.dart';

extension TransactionMarshal on Transaction {
  Uint8List marshal() {
    final output = Uint8List(0);

    // Signatures
    ShortVec.encodeShortVecOf(output, signatures, SignatureMarshal().marshal);

    // Message
    output.addAll(message.marshal());

    return output;
  }

  Transaction unmarshal(Uint8List bytes) {
    final input = Uint8List.fromList(bytes);

    final signatures = ShortVec.decodeShortVecOf(
        input, Signature.SIZE_OF, SignatureMarshal().unmarshal);

    return Transaction(
      message: message.unmarshal(input.readRemainingBytes()),
      signatures: signatures,
    );
  }
}

extension SignatureMarshal on Signature {
  Uint8List marshal() => value.byteArray;

  Signature unmarshal(Uint8List bytes) => Signature(value: FixedByteArray64(byteArray: bytes));
}

extension CompiledInstructionMarshal on CompiledInstruction {
  Uint8List marshal() {
    final output = Uint8List(0);

    output.addAll(programIndex.buffer.asUint8List());

    // Accounts
    ShortVec.encodeLen(output, accounts.length);
    output.addAll(accounts);

    // Data
    ShortVec.encodeLen(output, data.length);
    output.addAll(data);

    return output;
  }
}

extension KeyMarshal on Key {
  Uint8List marshal() => value;
}

extension HashMarshal on Hash {
  Uint8List marshal() => value.byteArray;
}

extension MessageMarshal on Message {
  Uint8List marshal() {
    final output = Uint8List(0);

    // Header
    output.add(header.numSignatures);
    output.add(header.numReadOnlySigned);
    output.add(header.numReadOnly);

    // Accounts (panic?)
    ShortVec.encodeShortVecOf(output, accounts, KeyMarshal().marshal);

    // Recent Blockhash
    output.addAll(recentBlockhash.marshal());

    // Instructions
    ShortVec.encodeShortVecOf(output, instructions, CompiledInstructionMarshal().marshal);

    return output;
  }

  Message unmarshal(Uint8List bytes) {
    final input = Uint8List.fromList(bytes);
    var readInput = () {
      input.iterator.moveNext();
      return input.iterator.current;
    };

    // Header
    final numSignatures = wrapError("failed to read num signatures", readInput);
    final numReadOnlySigned = wrapError("failed to read num readonly signatures", readInput);
    final numReadOnly = wrapError("failed to read num readonly", readInput);
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
        input.read(Hash.SIZE_OF).toModel<Hash>(() {
          Hash(FixedByteArray32(byteArray: input));
        });
      });

    // Instructions
    final instructions = List<CompiledInstruction>();
    final instructionsLength = ShortVec.decodeLen(input);
    for (int i = 0; i < instructionsLength; i++) {
      // Program Index
      final programIndex = wrapError("failed to read instruction[$i] program index", () => input.read().toByte());
      if (programIndex < 0 || programIndex >= accounts.length) {
        throw Exception("RuntimeException: program index out of range: $i:$programIndex");
      }

      // Account Indexes
      final accountIndexesLength = ShortVec.decodeLen(input);
      final accountIndexesBytes = wrapError("failed to read instruction[$i] accounts", () => input.read(accountIndexesLength));


      accountIndexesBytes.forEach((element) {
        if (element.toInt() >= accounts.length) {
          throw Exception("RuntimeException: account index out of range: $i:$element");
        }
      });

      // Data
      final dataLength = wrapError("failed to read instruction[$i] data", () => ShortVec.decodeLen(input));
      final dataBytes = input.read(dataLength);

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
}
