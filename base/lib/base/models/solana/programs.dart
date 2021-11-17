import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/tools/base58.dart';
import 'package:kin_base/base/tools/byte_in_out_buffer.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/stellarfork/xdr/xdr_type.dart';
import 'package:pointycastle/digests/sha256.dart';

import 'instruction.dart';

class SystemProgram {
  static final SystemProgram _instance = SystemProgram._();

  factory SystemProgram() => _instance;

  static final PublicKey PROGRAM_KEY = PublicKey.fromBytes(Uint8List(32));

  SystemProgram._();
}

class SystemProgramCommand {
  final int value;

  const SystemProgramCommand(this.value);
}

class SystemProgramCommandCreateAccount extends SystemProgramCommand {
  static final SystemProgramCommandCreateAccount _instance =
      SystemProgramCommandCreateAccount._();

  factory SystemProgramCommandCreateAccount() => _instance;

  SystemProgramCommandCreateAccount._() : super(0);
}

class SystemProgramCommandAssign extends SystemProgramCommand {
  static final SystemProgramCommandAssign _instance =
      SystemProgramCommandAssign._();

  factory SystemProgramCommandAssign() => _instance;

  SystemProgramCommandAssign._() : super(1);
}

class SystemProgramCommandTransfer extends SystemProgramCommand {
  static final SystemProgramCommandTransfer _instance =
      SystemProgramCommandTransfer._();

  factory SystemProgramCommandTransfer() => _instance;

  SystemProgramCommandTransfer._() : super(2);
}

class SystemProgramCommandCreateAccountWithSeed extends SystemProgramCommand {
  static final SystemProgramCommandCreateAccountWithSeed _instance =
      SystemProgramCommandCreateAccountWithSeed._();

  factory SystemProgramCommandCreateAccountWithSeed() => _instance;

  SystemProgramCommandCreateAccountWithSeed._() : super(3);
}

class SystemProgramCommandAdvanceNonceAccount extends SystemProgramCommand {
  static final SystemProgramCommandAdvanceNonceAccount _instance =
      SystemProgramCommandAdvanceNonceAccount._();

  factory SystemProgramCommandAdvanceNonceAccount() => _instance;

  SystemProgramCommandAdvanceNonceAccount._() : super(4);
}

class SystemProgramCommandWithdrawNonceAccount extends SystemProgramCommand {
  static final SystemProgramCommandWithdrawNonceAccount _instance =
      SystemProgramCommandWithdrawNonceAccount._();

  factory SystemProgramCommandWithdrawNonceAccount() => _instance;

  SystemProgramCommandWithdrawNonceAccount._() : super(5);
}

class SystemProgramCommandInitializeNonceAccount extends SystemProgramCommand {
  static final SystemProgramCommandInitializeNonceAccount _instance =
      SystemProgramCommandInitializeNonceAccount._();

  factory SystemProgramCommandInitializeNonceAccount() => _instance;

  SystemProgramCommandInitializeNonceAccount._() : super(6);
}

class SystemProgramCommandAuthorizeNonceAccount extends SystemProgramCommand {
  static final SystemProgramCommandAuthorizeNonceAccount _instance =
      SystemProgramCommandAuthorizeNonceAccount._();

  factory SystemProgramCommandAuthorizeNonceAccount() => _instance;

  SystemProgramCommandAuthorizeNonceAccount._() : super(7);
}

class SystemProgramCommandAllocate extends SystemProgramCommand {
  static final SystemProgramCommandAllocate _instance =
      SystemProgramCommandAllocate._();

  factory SystemProgramCommandAllocate() => _instance;

  SystemProgramCommandAllocate._() : super(8);
}

class SystemProgramCommandAllocateWithSeed extends SystemProgramCommand {
  static final SystemProgramCommandAllocateWithSeed _instance =
      SystemProgramCommandAllocateWithSeed._();

  factory SystemProgramCommandAllocateWithSeed() => _instance;

  SystemProgramCommandAllocateWithSeed._() : super(9);
}

class SystemProgramCommandAssignWithSeed extends SystemProgramCommand {
  static final SystemProgramCommandAssignWithSeed _instance =
      SystemProgramCommandAssignWithSeed._();

  factory SystemProgramCommandAssignWithSeed() => _instance;

  SystemProgramCommandAssignWithSeed._() : super(0);
}

class SystemProgramCommandTransferWithSeed extends SystemProgramCommand {
  static final SystemProgramCommandTransferWithSeed _instance =
      SystemProgramCommandTransferWithSeed._();

  factory SystemProgramCommandTransferWithSeed() => _instance;

  SystemProgramCommandTransferWithSeed._() : super(0);
}

class CreateAccount {
  final PublicKey subsidizer;

  final PublicKey address;
  final PublicKey owner;
  final int? lamports;
  final int size;

  CreateAccount(
      this.subsidizer, this.address, this.owner, this.lamports, this.size);

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      var bout = ByteOutputBuffer(32)
      ..writeBytes(SystemProgramCommandCreateAccount().value.toInt32Bytes())
      ..writeBytes(lamports!.toInt64Bytes())
      ..writeBytes(size.toInt64Bytes())
      ..writeAll(owner.value!);

      var data = bout.toBytes();

      _instruction = Instruction.newInstruction(
        SystemProgram.PROGRAM_KEY,
        data,
        [
          AccountMeta.newAccountMeta(subsidizer, true),
          AccountMeta.newAccountMeta(address, true)
        ],
      );
    }

    return _instruction;
  }
}

final Uint8List SYS_VAR_RENT_KEY = Base58().decode("SysvarRent111111111111111111111111111111111");

class Address {
  final int maxSeeds = 16;
  final int maxSeedLength = 32;

  PublicKey? createProgramAddress(PublicKey program, Uint8List seeds) {
    if(seeds.length > maxSeeds) {
      throw Exception("too many seeds");
    }

    var h = SHA256Digest();

    for (var s in seeds) {
      if(s.bitLength > maxSeedLength) {
        throw Exception("max seed length exceeded");
      }
      try {
        h.update(Uint8List.fromList([s]), 0, s.bitLength);
      } catch (e) {
        throw Exception("failed to hash seed " + e.toString());
      }
    }

    for(var v in [program.value, "ProgramDerivedAddress".toBytesUTF8()]) {
      try {
        h.update(v ?? Uint8List.fromList(List.empty()), 0, v!.length);
      } catch (e) {
        throw Exception("failed to hash seed " + e.toString());
      }
    }

    var pub;
    h.doFinal(pub, 0);

    try {
      // TEST the key curve
      var a = XdrCurve25519Public(pub);
    } catch (e) {
      return PublicKey(pub);
    }
    throw Exception("invalid public key");
  }

  PublicKey? findProgramAddress(PublicKey program, Uint8List seeds) {
    var maxUint8 = (1 << 8) - 1;
    var bumpSeed = Uint8List(maxUint8);

    for(var i = 0; i < maxUint8; i++) {
      try {
        seeds.add(bumpSeed.single);
        return createProgramAddress(program, seeds);
      } catch (e) {
        bumpSeed[0]--;
      }
    }
    return null;
  }
}

class AssociatedTokenProgram {
    static final PublicKey PROGRAM_KEY = PublicKey.fromBytes(Uint8List.fromList([
    140, 151, 37, 143, 78, 36, 137, 241, 187, 61, 16, 41, 20, 142,
    13, 131, 11, 90, 19, 153, 218, 255, 16, 132, 4, 142, 123, 216,
    219, 233, 248, 89
  ]));

  PublicKey? getAssociatedAccount(PublicKey wallet, PublicKey mint) {
    return Address().findProgramAddress(
      PROGRAM_KEY, 
      Uint8List.fromList([
        ...(wallet.value as Uint8List), 
        ...(TokenProgram.PROGRAM_KEY.value as Uint8List), 
        ...(mint.value as Uint8List)
      ])
    );
  }
}

class AssociatedTokenProgramCreateAssociatedTokenAccount {
  final PublicKey subsidizer;
  final PublicKey wallet;
  final PublicKey mint;

  AssociatedTokenProgramCreateAssociatedTokenAccount(
    this.subsidizer, this.wallet, this.mint);

  late final addr = (AssociatedTokenProgram().getAssociatedAccount(wallet, mint) as PublicKey);

  Instruction? _instruction;

  Instruction? get instruction {
    if(_instruction == null) {
      _instruction = Instruction.newInstruction(
        AssociatedTokenProgram.PROGRAM_KEY, 
        new Uint8List(0), [
        AccountMeta.newAccountMeta(subsidizer, true),
        AccountMeta.newAccountMeta(addr, false),
        AccountMeta.newReadonlyAccountMeta(wallet, false),
        AccountMeta.newReadonlyAccountMeta(mint, false),
        AccountMeta.newReadonlyAccountMeta(SystemProgram.PROGRAM_KEY, false),
        AccountMeta.newReadonlyAccountMeta(TokenProgram.PROGRAM_KEY, false),
        AccountMeta.newReadonlyAccountMeta(PublicKey.fromBytes(SYS_VAR_RENT_KEY), false)
        ]
      );
    }
    return _instruction;
  }
}

class TokenProgram {
  // Reference: https://github.com/solana-labs/solana-program-library/blob/11b1e3eefdd4e523768d63f7c70a7aa391ea0d02/token/program/src/state.rs#L125
  int accountSize = 165;

  // ProgramKey is the address of the token program that should be used.
  //
  // Current key: TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA
  //
  // todo: lock this in, or make configurable.
  // TODO: should be using ServiceConfig for now...this may not be the final one, use ServiceConfig instead - USE THIS IN TESTS ONLY UNTIL FINAL!
  static final PublicKey PROGRAM_KEY = PublicKey.fromBytes(Uint8List.fromList([
    6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225,
    70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55,
    145, 58, 140, 245, 133, 126, 255, 0, 169
  ]));
}

class TokenProgramCommand {
  final int value;

  TokenProgramCommand(this.value);
}

class TokenProgramCommandInitializeMint extends TokenProgramCommand {
  static final TokenProgramCommandInitializeMint _instance =
      TokenProgramCommandInitializeMint._();

  factory TokenProgramCommandInitializeMint() => _instance;

  TokenProgramCommandInitializeMint._() : super(0);
}

class TokenProgramCommandInitializeAccount extends TokenProgramCommand {
  static final TokenProgramCommandInitializeAccount _instance =
      TokenProgramCommandInitializeAccount._();

  factory TokenProgramCommandInitializeAccount() => _instance;

  TokenProgramCommandInitializeAccount._() : super(1);
}

class TokenProgramCommandInitializeMultisig extends TokenProgramCommand {
  static final TokenProgramCommandInitializeMultisig _instance =
      TokenProgramCommandInitializeMultisig._();

  factory TokenProgramCommandInitializeMultisig() => _instance;

  TokenProgramCommandInitializeMultisig._() : super(2);
}

class TokenProgramCommandTransfer extends TokenProgramCommand {
  static final TokenProgramCommandTransfer _instance =
      TokenProgramCommandTransfer._();

  factory TokenProgramCommandTransfer() => _instance;

  TokenProgramCommandTransfer._() : super(3);
}

class TokenProgramCommandApprove extends TokenProgramCommand {
  static final TokenProgramCommandApprove _instance =
      TokenProgramCommandApprove._();

  factory TokenProgramCommandApprove() => _instance;

  TokenProgramCommandApprove._() : super(4);
}

class TokenProgramCommandRevoke extends TokenProgramCommand {
  static final TokenProgramCommandRevoke _instance =
      TokenProgramCommandRevoke._();

  factory TokenProgramCommandRevoke() => _instance;

  TokenProgramCommandRevoke._() : super(5);
}

class TokenProgramCommandSetAuthority extends TokenProgramCommand {
  static final TokenProgramCommandSetAuthority _instance =
      TokenProgramCommandSetAuthority._();

  factory TokenProgramCommandSetAuthority() => _instance;

  TokenProgramCommandSetAuthority._() : super(6);
}

class TokenProgramCommandMintTo extends TokenProgramCommand {
  static final TokenProgramCommandMintTo _instance =
      TokenProgramCommandMintTo._();

  factory TokenProgramCommandMintTo() => _instance;

  TokenProgramCommandMintTo._() : super(7);
}

class TokenProgramCommandBurn extends TokenProgramCommand {
  static final TokenProgramCommandBurn _instance = TokenProgramCommandBurn._();

  factory TokenProgramCommandBurn() => _instance;

  TokenProgramCommandBurn._() : super(8);
}

class TokenProgramCommandCloseAccount extends TokenProgramCommand {
  static final TokenProgramCommandCloseAccount _instance =
      TokenProgramCommandCloseAccount._();

  factory TokenProgramCommandCloseAccount() => _instance;

  TokenProgramCommandCloseAccount._() : super(9);
}

class TokenProgramCommandFreezeAccount extends TokenProgramCommand {
  static final TokenProgramCommandFreezeAccount _instance =
      TokenProgramCommandFreezeAccount._();

  factory TokenProgramCommandFreezeAccount() => _instance;

  TokenProgramCommandFreezeAccount._() : super(10);
}

class TokenProgramCommandThawAccount extends TokenProgramCommand {
  static final TokenProgramCommandThawAccount _instance =
      TokenProgramCommandThawAccount._();

  factory TokenProgramCommandThawAccount() => _instance;

  TokenProgramCommandThawAccount._() : super(11);
}

class TokenProgramCommandTransfer2 extends TokenProgramCommand {
  static final TokenProgramCommandTransfer2 _instance =
      TokenProgramCommandTransfer2._();

  factory TokenProgramCommandTransfer2() => _instance;

  TokenProgramCommandTransfer2._() : super(12);
}

class TokenProgramCommandApprove2 extends TokenProgramCommand {
  static final TokenProgramCommandApprove2 _instance =
      TokenProgramCommandApprove2._();

  factory TokenProgramCommandApprove2() => _instance;

  TokenProgramCommandApprove2._() : super(13);
}

class TokenProgramCommandMintTo2 extends TokenProgramCommand {
  static final TokenProgramCommandMintTo2 _instance =
      TokenProgramCommandMintTo2._();

  factory TokenProgramCommandMintTo2() => _instance;

  TokenProgramCommandMintTo2._() : super(14);
}

class TokenProgramCommandBurn2 extends TokenProgramCommand {
  static final TokenProgramCommandBurn2 _instance =
      TokenProgramCommandBurn2._();

  factory TokenProgramCommandBurn2() => _instance;

  TokenProgramCommandBurn2._() : super(15);
}

// Reference: https://github.com/solana-labs/solana-program-library/blob/b011698251981b5a12088acba18fad1d41c3719a/token/program/src/instruction.rs#L41-L55
class TokenProgramInitializeAccount {
  final PublicKey account;
  final PublicKey mint;
  final PublicKey owner;
  final PublicKey programKey;

  TokenProgramInitializeAccount(
      this.account, this.mint, this.owner, this.programKey);

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      _instruction = Instruction.newInstruction(programKey,
          TokenProgramCommandInitializeAccount().value.toUint8List(), [
        AccountMeta.newAccountMeta(account, true),
        AccountMeta.newReadonlyAccountMeta(mint, false),
        AccountMeta.newReadonlyAccountMeta(owner, false),
        AccountMeta.newReadonlyAccountMeta(
            PublicKey.fromBytes(SYS_VAR_RENT_KEY), false)
      ]);
    }
    return _instruction;
  }
}

// Reference: https: //github.com/solana-labs/solana-program-library/blob/b011698251981b5a12088acba18fad1d41c3719a/token/program/src/instruction.rs#L76-L91
class TokenProgramTransfer {
  final PublicKey source;
  final PublicKey destination;

  final PublicKey owner;

  final KinAmount? amount;

  final PublicKey programKey;

  TokenProgramTransfer(
      this.source, this.destination, this.owner, this.amount, this.programKey);

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      _instruction = Instruction.newInstruction(
          programKey,
          Uint8List.fromList([
            TokenProgramCommandTransfer().value,
            ...amount!.toQuarks().value!.toInt64Uint8List()
          ]),
          [
            AccountMeta.newAccountMeta(source, false),
            AccountMeta.newAccountMeta(destination, false),
            AccountMeta.newAccountMeta(owner, true)
          ]);
    }
    return _instruction;
  }
}

class TokenProgramAuthorityType {
  final int value;

  TokenProgramAuthorityType(this.value);
}

class TokenProgramAuthorityTypeMintTokens extends TokenProgramAuthorityType {
  static final TokenProgramAuthorityTypeMintTokens _instance =
      TokenProgramAuthorityTypeMintTokens._();

  factory TokenProgramAuthorityTypeMintTokens() => _instance;

  TokenProgramAuthorityTypeMintTokens._() : super(0);
}

class TokenProgramAuthorityTypeFreezeAccount extends TokenProgramAuthorityType {
  static final TokenProgramAuthorityTypeFreezeAccount _instance =
      TokenProgramAuthorityTypeFreezeAccount._();

  factory TokenProgramAuthorityTypeFreezeAccount() => _instance;

  TokenProgramAuthorityTypeFreezeAccount._() : super(1);
}

class TokenProgramAuthorityTypeAccountHolder extends TokenProgramAuthorityType {
  static final TokenProgramAuthorityTypeAccountHolder _instance =
      TokenProgramAuthorityTypeAccountHolder._();

  factory TokenProgramAuthorityTypeAccountHolder() => _instance;

  TokenProgramAuthorityTypeAccountHolder._() : super(2);
}

class TokenProgramAuthorityTypeCloseAccount extends TokenProgramAuthorityType {
  static final TokenProgramAuthorityTypeCloseAccount _instance =
      TokenProgramAuthorityTypeCloseAccount._();

  factory TokenProgramAuthorityTypeCloseAccount() => _instance;

  TokenProgramAuthorityTypeCloseAccount._() : super(3);
}

class SetAuthority {
  final PublicKey account;

  final PublicKey currentAuthority;

  final PublicKey newAuthority;

  final TokenProgramAuthorityType authorityType;

  final PublicKey programKey;

  SetAuthority(this.account, this.currentAuthority, this.newAuthority,
      this.authorityType, this.programKey);

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      var data = <int>[
        TokenProgramCommandSetAuthority().value,
        authorityType.value,
        0
      ];

      data[2] = 1;
      data.addAll(newAuthority.value!);

      _instruction = Instruction.newInstruction(programKey, data.toUint8List(), [
        AccountMeta.newAccountMeta(account, false),
        AccountMeta.newReadonlyAccountMeta(currentAuthority, true)
      ]);
    }
    return _instruction;
  }
}

class CloseAccount {
  final PublicKey account;
  final PublicKey dest;
  final PublicKey owner;

  CloseAccount(this.account, this.dest, this.owner);

  Instruction? _instruction;

  Instruction? get instruction {
    if(_instruction == null) {
      _instruction = Instruction.newInstruction(
        TokenProgram.PROGRAM_KEY,
        TokenProgramAuthorityTypeCloseAccount().value.toUint8List(), [
        AccountMeta.newAccountMeta(dest, false),
        AccountMeta.newAccountMeta(dest, false),
        AccountMeta.newReadonlyAccountMeta(owner, false)
        ]);
    }
  }
}

class MemoProgram {
  static final MemoProgram _instance = MemoProgram._();

  factory MemoProgram() => _instance;

  MemoProgram._();

  static final PublicKey PROGRAM_KEY = PublicKey.fromBytes(Uint8List.fromList([
    5, 74, 83, 80, 248, 93, 200, 130, 214, 20, 165, 86, 114, 120, 138, 41, 109, 223,
    30, 171, 171, 208, 166, 6, 120, 136, 73, 50, 244, 238, 246, 160
  ]));
}

class MemoProgramBase64EncodedMemo extends MemoProgram {
  final String base64Value;

  MemoProgramBase64EncodedMemo(this.base64Value) : super._();

  factory MemoProgramBase64EncodedMemo.fromBytes(Uint8List bytes) =>
      MemoProgramBase64EncodedMemo(base64.encode(bytes));

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      _instruction = Instruction.newInstruction(
          MemoProgram.PROGRAM_KEY, base64Value.toBytesUTF8());
    }
    return _instruction;
  }
}

class MemoProgramRawMemo {
  final Uint8List? bytes;

  MemoProgramRawMemo(this.bytes);

  Instruction? _instruction;

  Instruction? get instruction {
    if (_instruction == null) {
      _instruction = Instruction.newInstruction(MemoProgram.PROGRAM_KEY, bytes);
    }
    return _instruction;
  }
}
