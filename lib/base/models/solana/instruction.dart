import 'org.kin.sdk.base.models.Key';
import 'package:kin-flutter-sdk/base/models/key.dart';

/// AccountMeta represents the account information required
/// for building transactions.
class AccountMeta implements Comparable<AccountMeta> {
  final Key.PublicKey publicKey;
  final bool isSigner;
  final bool isWritable;
  final bool isPayer;
  final bool isProgram;

  AccountMeta(
    this.publicKey, [
    this.isSigner = false,
    this.isWritable = false,
    this.isPayer = false,
    this.isProgram = false,
  ]);

  static AccountMeta newAccountMeta(
    Key.PublicKey publicKey,
    bool isSigner, [
    bool isPayer = false,
    bool isProgram = false,
  ]) {
    return AccountMeta(
      publicKey,
      isSigner,
      true,
      isPayer,
      isProgram,
    );
  }

  AccountMeta newReadonlyAccountMeta(
    Key.PublicKey publicKey,
    bool isSigner, [
    bool isPayer = false,
    bool isProgram = false,
  ]) {
    return AccountMeta(publicKey, isSigner, false, isPayer, isProgram);
  }

  @override
  int compareTo(AccountMeta other) {
    bool less(AccountMeta other) {
      if (isPayer != other.isPayer) return isPayer;
      if (isProgram != other.isProgram) return !isProgram;
      if (isSigner != other.isSigner) return isSigner;
      if (isWritable != other.isWritable) return isWritable;

      return false;
    }

    return less(other) ? -1 : 1;
  }
}

/// Instruction represents a transaction instruction.
class Instruction {
  final Key.PublicKey program;
  final List<AccountMeta> accounts;
  final List<int> data;

  Instruction(
    this.program,
    this.accounts,
    this.data,
  );

  static Instruction newInstruction(
      Key.PublicKey program, List<int> data, List<AccountMeta> accounts) {
    return Instruction(program, accounts, data);
  }

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
//    if (other is! Instruction) return false;
    if (other is Instruction) {
      if (program != other.program) return false;
      if (accounts != other.accounts) return false;
      if (!data.every((item) => other.data.contains(item))) return false;
    } else {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var result = program.hashCode();
    result = 31 * result + accounts.hashCode;
    result = 31 * result + data.contentHashCode();
    return result;
  }
}

class CompiledInstruction {
  final int programIndex;
  final List<int> accounts;
  final List<int> data;

  CompiledInstruction(this.programIndex, this.accounts, this.data);

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
//    if (other is! CompiledInstruction) return false;
    if (other is CompiledInstruction) {
      if (programIndex != other.programIndex) return false;
      if (!accounts.every((item) => other.accounts.contains(item)))
        return false;
      if (!data.every((item) => other.data.contains(item))) return false;

      return true;
    }
    return false;
  }

  @override
  int get hashCode {
    var result = programIndex.toInt();
    result = 31 * result + accounts.contentHashCode();
    result = 31 * result + data.contentHashCode();
    return result;
  }
}
