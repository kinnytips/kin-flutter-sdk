import 'dart:typed_data';

import 'package:kin_base/stellarfork/xdr/xdr_data_io.dart';
import 'package:kin_base/stellarfork/xdr/xdr_transaction.dart';

enum ResultCode {
  success, // ResultCode(0)
  failed, // ResultCode(-1)
  tooEarly, // ResultCode(-2)
  tooLate, //ResultCode(-3)
  missingOperation, // ResultCode(-4)
  badSequenceNumber, // ResultCode(-5)
  badAuth, // ResultCode(-6)
  insufficientBalance, // ResultCode(-7)
  noAccount, // ResultCode(-8)
  insufficientFee, // ResultCode(-9)
  badAuthExtra, // ResultCode(-10)
  internalError, // ResultCode(-11)

}

ResultCode parseResultCode(Uint8List resultXdrBytes) {
  var transactionResultCode =
      XdrTransactionResult.decode(XdrDataInputStream(resultXdrBytes)).result!.discriminant;

  if (transactionResultCode == XdrTransactionResultCode.txSUCCESS) {
    return ResultCode.success;
  } else if (transactionResultCode == XdrTransactionResultCode.txFAILED) {
    return ResultCode.failed;
  } else if (transactionResultCode == XdrTransactionResultCode.txTOO_EARLY) {
    return ResultCode.tooEarly;
  } else if (transactionResultCode == XdrTransactionResultCode.txTOO_LATE) {
    return ResultCode.tooLate;
  } else if (transactionResultCode ==
      XdrTransactionResultCode.txMISSING_OPERATION) {
    return ResultCode.missingOperation;
  } else if (transactionResultCode == XdrTransactionResultCode.txBAD_SEQ) {
    return ResultCode.badSequenceNumber;
  } else if (transactionResultCode == XdrTransactionResultCode.txBAD_AUTH) {
    return ResultCode.badAuth;
  } else if (transactionResultCode ==
      XdrTransactionResultCode.txINSUFFICIENT_BALANCE) {
    return ResultCode.insufficientBalance;
  } else if (transactionResultCode == XdrTransactionResultCode.txNO_ACCOUNT) {
    return ResultCode.noAccount;
  } else if (transactionResultCode == XdrTransactionResultCode.txINSUFFICIENT_FEE) {
    return ResultCode.insufficientFee;
  } else if (transactionResultCode == XdrTransactionResultCode.txBAD_AUTH_EXTRA) {
    return ResultCode.badAuthExtra;
  } else if (transactionResultCode == XdrTransactionResultCode.txINTERNAL_ERROR) {
    return ResultCode.internalError;
  } else {
    return ResultCode.internalError;
  }
}
