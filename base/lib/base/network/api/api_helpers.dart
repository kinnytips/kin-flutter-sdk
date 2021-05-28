import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/base/stellar/models/result_code.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pb.dart' as transaction_v3;
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pb.dart' as transaction_v4;

extension ResultCodeExtension on ResultCode {

  transaction_v3.SubmitTransactionResponse_Result  toSubmitTransactionResult() {
    switch(this) {
      case ResultCode.success: return transaction_v3.SubmitTransactionResponse_Result.OK;
      case ResultCode.badSequenceNumber: return transaction_v3.SubmitTransactionResponse_Result.REJECTED; // BadSequenceNumber?
      case ResultCode.insufficientBalance: return transaction_v3.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      case ResultCode.insufficientFee: return transaction_v3.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      case ResultCode.noAccount: return transaction_v3.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      default: return transaction_v3.SubmitTransactionResponse_Result.FAILED;
    }
  }

  transaction_v4.SubmitTransactionResponse_Result  toSubmitTransactionResultV4() {
    switch(this) {
      case ResultCode.success: return transaction_v4.SubmitTransactionResponse_Result.OK;
      case ResultCode.badSequenceNumber: return transaction_v4.SubmitTransactionResponse_Result.REJECTED; // BadSequenceNumber?
      case ResultCode.insufficientBalance: return transaction_v4.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      case ResultCode.insufficientFee: return transaction_v4.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      case ResultCode.noAccount: return transaction_v4.SubmitTransactionResponse_Result.REJECTED; // InsufficientBalance?
      default: return transaction_v4.SubmitTransactionResponse_Result.FAILED;
    }
  }

  KinServiceResponseType toKinServiceResponseType() {
    switch(this) {
      case ResultCode.success: return KinServiceResponseType.ok;
      case ResultCode.badSequenceNumber: return KinServiceResponseType.badSequenceNumber;
      case ResultCode.insufficientBalance: return KinServiceResponseType.insufficientBalance;
      case ResultCode.insufficientFee: return KinServiceResponseType.insufficientFee;
      case ResultCode.noAccount: return KinServiceResponseType.noAccount;
      default: return KinServiceResponseType.undefinedError;
    }
  }

}

/*

fun KinTransaction.ResultCode?.toSubmitTransactionResult(): KinTransactionApi.SubmitTransactionResponse.Result {
    return when (this) {
        KinTransaction.ResultCode.Success -> KinTransactionApi.SubmitTransactionResponse.Result.Ok
        KinTransaction.ResultCode.BadSequenceNumber -> KinTransactionApi.SubmitTransactionResponse.Result.BadSequenceNumber
        KinTransaction.ResultCode.InsufficientBalance -> KinTransactionApi.SubmitTransactionResponse.Result.InsufficientBalance
        KinTransaction.ResultCode.InsufficientFee -> KinTransactionApi.SubmitTransactionResponse.Result.InsufficientFee
        KinTransaction.ResultCode.NoAccount -> KinTransactionApi.SubmitTransactionResponse.Result.NoAccount
        KinTransaction.ResultCode.Failed,
        KinTransaction.ResultCode.TooEarly,
        KinTransaction.ResultCode.TooLate,
        KinTransaction.ResultCode.MissingOperation,
        KinTransaction.ResultCode.BadAuth,
        KinTransaction.ResultCode.BadAuthExtra,
        KinTransaction.ResultCode.InternalError,
        null -> KinTransactionApi.SubmitTransactionResponse.Result.UndefinedError(Exception("Transaction ResultCode: $this"))
    }
}

fun KinTransaction.ResultCode?.toSubmitTransactionResultV4(): KinTransactionApiV4.SubmitTransactionResponse.Result {
    return when (this) {
        KinTransaction.ResultCode.Success -> KinTransactionApiV4.SubmitTransactionResponse.Result.Ok
        KinTransaction.ResultCode.BadSequenceNumber -> KinTransactionApiV4.SubmitTransactionResponse.Result.BadSequenceNumber
        KinTransaction.ResultCode.InsufficientBalance -> KinTransactionApiV4.SubmitTransactionResponse.Result.InsufficientBalance
        KinTransaction.ResultCode.InsufficientFee -> KinTransactionApiV4.SubmitTransactionResponse.Result.InsufficientFee
        KinTransaction.ResultCode.NoAccount -> KinTransactionApiV4.SubmitTransactionResponse.Result.NoAccount
        KinTransaction.ResultCode.Failed,
        KinTransaction.ResultCode.TooEarly,
        KinTransaction.ResultCode.TooLate,
        KinTransaction.ResultCode.MissingOperation,
        KinTransaction.ResultCode.BadAuth,
        KinTransaction.ResultCode.BadAuthExtra,
        KinTransaction.ResultCode.InternalError,
        null -> KinTransactionApiV4.SubmitTransactionResponse.Result.UndefinedError(Exception("Transaction ResultCode: $this"))
    }
}

 */