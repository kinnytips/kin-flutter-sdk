import 'dart:typed_data';

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/solana/short_vec.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/solana/fixed_byte_array.dart';
import 'package:kin_base/base/models/solana/byte_utils.dart';
import 'package:kin_base/base/tools/byte_in_out_buffer.dart';

extension TransactionMarshal on Transaction {
  Uint8List marshal() {
    final output = ByteOutputBuffer(32);

    // Signatures
    ShortVec.encodeShortVecOf<Signature>(output, signatures, (s) => s.marshal() );

    // Message
    output.writeAll(message.marshal());

    return output.toBytes();
  }

  Transaction unmarshal(Uint8List bytes) {
    final input = ByteInputBuffer(bytes);

    final signatures = ShortVec.decodeShortVecOf(
        input, Signature.SIZE_OF, (bytes) => SignatureMarshal.unmarshal(bytes) );

    return Transaction(
      message: message.unmarshal(input.readRemainingBytes()),
      signatures: signatures,
    );
  }
}

extension SignatureMarshal on Signature {
  Uint8List marshal() => value.byteArray;

  static Signature unmarshal(Uint8List bytes) => Signature(value: FixedByteArray64(bytes));
}

extension CompiledInstructionMarshal on CompiledInstruction {
  Uint8List marshal() {
    final output = ByteOutputBuffer(32);

    output.write(programIndex);

    // Accounts
    ShortVec.encodeLen(output, accounts.length);
    output.writeAll(accounts);

    // Data
    ShortVec.encodeLen(output, data.length);
    output.writeAll(data);

    return output.toBytes();
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
    final output = ByteOutputBuffer(32);

    // Header
    output.write(header.numSignatures);
    output.write(header.numReadOnlySigned);
    output.write(header.numReadOnly);

    // Accounts (panic?)
    ShortVec.encodeShortVecOf(output, accounts, (bytes) => PublicKey(bytes).marshal());

    // Recent Blockhash
    output.writeAll(recentBlockhash.marshal());

    // Instructions
    ShortVec.encodeShortVecOf<CompiledInstruction>(output, instructions, (e) => e.marshal());

    return output.toBytes();
  }

  Message unmarshal(Uint8List bytes) {
    final input = ByteInputBuffer(bytes);

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
}
