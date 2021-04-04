import 'dart:typed_data';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kinny/base/models/solana/instruction.dart';
import 'package:kinny/base/models/token_command.dart' as TokenCommand;
import 'package:kinny/base/tools/base58.dart';

class SystemProgram {
  static const PROGRAM_KEY = Key.PublicKey(Uint8List(32));

  static final SystemProgram _systemProgram = SystemProgram._internal();

  factory SystemProgram() => _systemProgram;

  SystemProgram._internal();

  // Reference: https://github.com/solana-labs/solana/blob/f02a78d8fff2dd7297dc6ce6eb5a68a3002f5359/sdk/src/system_instruction.rs#L58-L72
  static Instruction createAccount(
      Key.PublicKey subsidizer,
      Key.PublicKey address,
      Key.PublicKey owner,
      int lamports,
      int size,
      ) {
    // # Account references
    //   0. [WRITE, SIGNER] Funding account
    //   1. [WRITE, SIGNER] New account
    //
    // CreateAccount {
    //   // Number of lamports to transfer to the new account
    //   lamports: u64,
    //   // Number of bytes of memory to allocate
    //   space: u64,
    //
    //   //Address of program that will own the new account
    //   owner: Pubkey,
    // }
    //

    // TODO: incomplete
    var data = Uint8List.fromList(ByteStream(stream).toList());

    return Instruction.newInstruction(
      PROGRAM_KEY,
      data,
      [
        AccountMeta.newAccountMeta(publicKey: subsidizer, isSigner: true),
        AccountMeta.newAccountMeta(publicKey: address, isSigner: true),
      ],
    );
  }
}

class TokenProgram {
  static final TokenProgram _tokenProgram = TokenProgram._internal();

  factory TokenProgram() => _tokenProgram;

  TokenProgram._internal();

  // Reference: https://github.com/solana-labs/solana-program-library/blob/11b1e3eefdd4e523768d63f7c70a7aa391ea0d02/token/program/src/state.rs#L125
  final int accountSize = 165;

  // ProgramKey is the address of the token program that should be used.
  //
  // Current key: TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA
  //
  // todo: lock this in, or make configurable.
  // TODO: should be using ServiceConfig for now...this may not be the final one, use ServiceConfig instead - USE THIS IN TESTS ONLY UNTIL FINAL!

  final Key.PublicKey PROGRAM_KEY = Key.PublicKey(Uint8List.fromList([
    6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225,
    70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55,
    145, 58, 140, 245, 133, 126, 255, 0, 169
  ].toByte()));

  static final SYS_VAR_RENT = Base58().decode(
      "SysvarRent111111111111111111111111111111111");

  // Reference: https://github.com/solana-labs/solana-program-library/blob/b011698251981b5a12088acba18fad1d41c3719a/token/program/src/instruction.rs#L41-L55
  static Instruction initializeAccount(Key.PublicKey account,
      Key.PublicKey mint,
      Key.PublicKey owner,
      Key.PublicKey programKey,) {
    return Instruction.newInstruction(
      programKey,
      Uint8List(1)..[0] = TokenCommand.InitializeAccount().value,
      [
        AccountMeta.newAccountMeta(publicKey: account, isSigner: true),
        AccountMeta.newReadonlyAccountMeta(publicKey: mint, isSigner: false),
        AccountMeta.newReadonlyAccountMeta(publicKey: owner, isSigner: false),
        AccountMeta.newReadonlyAccountMeta(
            publicKey: Key.PublicKey(SYS_VAR_RENT), isSigner: false),
      ],
    );
  }

  // todo(feature): support multi-sig
  //
  // Reference: https://github.com/solana-labs/solana-program-library/blob/b011698251981b5a12088acba18fad1d41c3719a/token/program/src/instruction.rs#L76-L91
  static Instruction transfer(Key.PublicKey source,
      Key.PublicKey destination,
      Key.PublicKey owner,
      Key.PublicKey amount,
      Key.PublicKey programKey,) {
    // Accounts expected by this instruction:
    //
    //   * Single owner/delegate
    //   0. `[writable]` The source account.
    //   1. `[writable]` The destination account.
    //   2. `[signer]` The source account's owner/delegate.
    //
    //   * Multisignature owner/delegate
    //   0. `[writable]` The source account.
    //   1. `[writable]` The destination account.
    //   2. `[]` The source account's multisignature owner/delegate.
    //   3. ..3+M `[signer]` M signer accounts.

    return Instruction.newInstruction(
      programKey,
      Uint8List.fromList([
        TokenCommand.Transfer().value,
        // TODO: convert below line
        // *amount.toQuarks().value.longToByteArray().subByteArray(0, 8),
      ]),
      [
        AccountMeta.newAccountMeta(publicKey: source, isSigner: false),
        AccountMeta.newAccountMeta(publicKey: destination, isSigner: false),
        AccountMeta.newAccountMeta(publicKey: owner, isSigner: false),
      ],
    );
  }

  static Instruction setAuthority(
      Key.PublicKey account,
      Key.PublicKey currentAuthority,
      Key.PublicKey newAuthority,
      Key.PublicKey authorityType,
      Key.PublicKey programKey,
      ) {
    var data = Uint8List.fromList([
      TokenCommand.SetAuthority().value,
      authorityType.value,
      0,
    ]);
    if (newAuthority != null) {
      data[2] = 1;
      data += newAuthority.value;
    }
    return Instruction.newInstruction(
      programKey,
      data,
      [
        AccountMeta.newAccountMeta(publicKey: account, isSigner: false),
        AccountMeta.newReadonlyAccountMeta(publicKey: currentAuthority, isSigner: true),
      ],
    );
  }
}

class MemoProgram {
  static final MemoProgram _memoProgram = MemoProgram._internal();

  factory MemoProgram() => _memoProgram;

  MemoProgram._internal();
  // ProgramKey is the address of the memo program that should be used.
  //
  // Current key: Memo1UhkJRfHyvLMcVucJwxXeuD728EqVDDwQDxFMNo
  //
  // todo: lock this in, or make configurable
  static final Key.PublicKey PROGRAM_KEY = Uint8List.fromList([
    5, 74, 83, 80, 248, 93, 200, 130, 214, 20, 165, 86, 114, 120, 138, 41, 109, 223,
    30, 171, 171, 208, 166, 6, 120, 136, 73, 50, 244, 238, 246, 160
  ]);

  static Instruction fromBytes(Uint8List bytes) {
    // TODO: need this class/function
    return base64EncodedMemo(Base64.encodeBase64String(bytes) ?? null);
  }

  static Instruction base64EncodedMemo(String base64value) {
    return Instruction.newInstruction(
        PROGRAM_KEY,
      //todo: is this base64value.toByteArray(Charsets.UTF_8) same as below?
      utf8.encode(base64value),
    );
  }

  static Instruction rawMemo(Uint8List bytes) {
    return Instruction.newInstruction(PROGRAM_KEY, bytes);
  }
}


