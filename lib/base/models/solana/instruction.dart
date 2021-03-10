import 'package:collection/collection.dart';

import 'package:kin_sdk/base/models/key.dart';

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

// todo make sure this is as close to a companion object in Kotlin
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

// todo make sure this is as close to a companion object in Kotlin
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
      if (!ListEquality().equals(data, other.data)) return false;
    } else {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var result = program.hashCode();
    result = 31 * result + accounts.hashCode;
    // todo: contentHashCode vs hashcode
    result = 31 * result + data.hashCode;
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
      if (!ListEquality().equals(accounts, other.accounts)) return false;
      if (!ListEquality().equals(data, other.data)) return false;

      return true;
    }
    return false;
  }

  contentEquals(List list1, List list2) {
    if (list1.length != list2.length) return false;
  }

  @override
  int get hashCode {
    var result = programIndex.toInt();
    // todo: contentHashCode vs hashcode
    result = 31 * result + accounts.hashCode;
    result = 31 * result + data.hashCode;
    return result;
  }
}
