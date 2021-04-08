import 'dart:async';
import 'dart:typed_data';

import 'package:kinny/base/models/key.dart';
import 'package:kinny/base/models/solana/instruction.dart';
import 'package:kinny/base/models/solana/transaction.dart';
import 'package:kinny/base/models/solana/fixed_byte_array.dart';

extension TransactionMarshal on Transaction {
  Uint8List marshal() {
    final StreamController<int> streamController = StreamController();

    // Signatures
    ShortVec.encodeShortVecOf(streamController, signatures, SignatureMarshal(Signature()).marshal);

    // Message
    streamController.sink.add(message.marshal());
    Uint8List list;
    streamController.stream.toList().then((value) => list = Uint8List.fromList(value));

    streamController.sink.close();
    return list;
  }

  Transaction unmarshal(Uint8List bytes) {
    // todo incomplete
    // val input = ByteArrayInputStream(bytes)

    final signatures = ShortVec.decodeShortVecOf(input, Signature.SIZE_OF, SignatureMarshal().unmarshal);

    return Transaction(
      message: Message.unmarshal(),
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
    // todo incomplete
    // val output = ByteArrayOutputStream()

    // output.write(byteArrayOf(programIndex))

    // Accounts
    ShortVec.encodeLen(output, accounts.size);
    // output.write(accounts)

    // Data
    ShortVec.encodeLen(output, data.size);
    // output.write(data)

    // return output.toByteArray()

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
    // todo incomplete
    // val output = ByteArrayOutputStream()

    // Header
    // output.write(header.numSignatures)
    // output.write(header.numReadOnlySigned)
    // output.write(header.numReadOnly)

    // Accounts (panic?)
    ShortVec.encodeShortVecOf(output, accounts, PublicKey().marshal);

    // Recent Blockhash
    // output.write(recentBlockhash.marshal())

    // Instructions
    ShortVec.encodeShortVecOf(output, instructions, CompiledInstructionMarshal().marshal)

    // return output.toByteArray()
  }

  Message unmarshal(Uint8List bytes) {
    // todo incomplete
    // val input = ByteArrayInputStream(bytes)

    // Header
    final numSignatures = wrapError("failed to read num signatures", input::read);
    final numReadOnlySigned = wrapError("failed to read num readonly signatures", input::read);
    final numReadOnly = wrapError("failed to read num readonly", input::read);
    final Header header = Header(
        numSignatures: numSignatures,
        numReadOnlySigned: numReadOnlySigned,
        numReadOnly: numReadOnly,
    )

    // Accounts
    final accounts = ShortVec.decodeShortVecOf<PublicKey>(input, 32);

    // Recent Block Hash
    final recentBlockHash =
      wrapError("failed to read block hash") {
        input.read(Hash.SIZE_OF).toModel<Hash> {
          Hash(FixedByteArray32(it));
        }
      }

    // Instructions
    final instructions = List<CompiledInstruction>();
    final instructionsLength = ShortVec.decodeLen(input).forEach((element) {
      // Program Index
      final programIndex = wrapError("failed to read instruction[$i] program index") { input.read().toByte(); }
      if (programIndex < 0 || programIndex >= accounts.size) {
        throw Exception("RuntimeException: program index out of range: $element:$programIndex");
      }

      // Account Indexes
      final accountIndexesLength = ShortVec.decodeLen(input);
      final accountIndexesBytes = wrapError("failed to read instruction[$i] accounts") {
        input.read(accountIndexesLength);
      }
      accountIndexesBytes.forEach ((element) {
        if (element.toInt() >= accounts.size) {
          throw RuntimeException("account index out of range: $i:$element")
        }
      });

      // Data
      final dataLength = wrapError("failed to read instruction[$i] data") { ShortVec.decodeLen(input); }
      final dataBytes = input.read(dataLength);

      final instruction = CompiledInstruction(
        programIndex: programIndex,
        accounts: accountIndexesBytes,
        data: dataBytes,
      );
      instructions.add(instruction);
    });

    return Message(
      header:header,
      accounts: accounts,
      instructions: instructions,
      recentBlockhash: recentBlockHash,
    );
  }
}
