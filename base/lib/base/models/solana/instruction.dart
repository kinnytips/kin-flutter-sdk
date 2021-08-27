import 'dart:typed_data';


import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/tools/extensions.dart';

/// AccountMeta represents the account information required
/// for building transactions.
class AccountMeta implements Comparable<AccountMeta> {
  final PublicKey publicKey;
  final bool isSigner;
  final bool isWritable;
  final bool isPayer;
  final bool isProgram;

  AccountMeta({
    required this.publicKey,
    this.isSigner = false,
    this.isWritable = false,
    this.isPayer = false,
    this.isProgram = false,
  });

  AccountMeta copyWith({
    isSigner,
    isWritable,
    isPayer,
    isProgram,
  }) =>
      AccountMeta(
        publicKey: this.publicKey,
        isSigner: isSigner ?? this.isSigner,
        isWritable: isWritable ?? this.isWritable,
        isPayer: isPayer ?? this.isPayer,
        isProgram: isProgram ?? this.isProgram,
      );

  factory AccountMeta.newAccountMeta(
    PublicKey publicKey,
    bool isSigner, {
    bool isPayer = false,
    bool isProgram = false,
  }) {
    return AccountMeta(
      publicKey: publicKey,
      isSigner: isSigner,
      isWritable: true,
      isPayer: isPayer,
      isProgram: isProgram,
    );
  }

  static AccountMeta newReadonlyAccountMeta(
    PublicKey publicKey,
    bool isSigner, {
    bool isPayer = false,
    bool isProgram = false,
  }) {
    return AccountMeta(
      publicKey: publicKey,
      isSigner: isSigner,
      isWritable: false,
      isPayer: isPayer,
      isProgram: isProgram,
    );
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

  @override
  String toString() {
    return 'AccountMeta{publicKey: $publicKey, isSigner: $isSigner, isWritable: $isWritable, isPayer: $isPayer, isProgram: $isProgram}';
  }
}

/// Instruction represents a transaction instruction.
class Instruction {
  final PublicKey program;
  final List<AccountMeta>? accounts;
  final Uint8List? data;

  Instruction(
    this.program,
    this.accounts,
    this.data,
  );

  static Instruction newInstruction(PublicKey program, Uint8List? data,
      [List<AccountMeta>? accounts]) {
    return Instruction(program, accounts, data);
  }

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
//    if (other is! Instruction) return false;
    if (other is Instruction) {
      if (program != other.program) return false;
      if (!accounts!.equalsContent(other.accounts)) return false;
      if (!data!.equalsContent(other.data)) return false;
    } else {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var result = program.hashCode;
    result = 31 * result + accounts.hashCode;
    result = 31 * result + data!.computeHashCode();
    return result;
  }
}

class CompiledInstruction {
  final int programIndex;
  final Uint8List accounts;
  final Uint8List? data;

  CompiledInstruction({
    required this.programIndex,
    required this.accounts,
    required this.data,
  });

  @override
  bool operator ==(Object other) {
    if (this == other) return true;
//    if (other is! CompiledInstruction) return false;
    if (other is CompiledInstruction) {
      if (programIndex.toInt() != other.programIndex.toInt()) return false;
      if (!accounts.equalsContent(other.accounts)) return false;
      if (!data!.equalsContent(other.data)) return false;
    } else {
      return false;
    }

    return true;
  }

  @override
  int get hashCode {
    var result = programIndex.toInt();
    result = 31 * result + accounts.computeHashCode();
    result = 31 * result + data!.computeHashCode();
    return result;
  }
}
