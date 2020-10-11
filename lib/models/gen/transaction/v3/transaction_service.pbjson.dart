///
//  Generated code. Do not modify.
//  source: transaction/v3/transaction_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const GetHistoryRequest$json = const {
  '1': 'GetHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
    const {'1': 'cursor', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.Cursor', '10': 'cursor'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetHistoryRequest.Direction', '10': 'direction'},
  ],
  '4': const [GetHistoryRequest_Direction$json],
};

const GetHistoryRequest_Direction$json = const {
  '1': 'Direction',
  '2': const [
    const {'1': 'ASC', '2': 0},
    const {'1': 'DESC', '2': 1},
  ],
};

const GetHistoryResponse$json = const {
  '1': 'GetHistoryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetHistoryResponse.Result', '10': 'result'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.transaction.v3.HistoryItem', '8': const {}, '10': 'items'},
  ],
  '4': const [GetHistoryResponse_Result$json],
};

const GetHistoryResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

const SubmitTransactionRequest$json = const {
  '1': 'SubmitTransactionRequest',
  '2': const [
    const {'1': 'envelope_xdr', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'invoice_list', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
  ],
};

const SubmitTransactionResponse$json = const {
  '1': 'SubmitTransactionResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.Result', '10': 'result'},
    const {'1': 'invoice_errors', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.InvoiceError', '10': 'invoiceErrors'},
    const {'1': 'hash', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '10': 'hash'},
    const {
      '1': 'ledger',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'ledger',
    },
    const {'1': 'result_xdr', '3': 5, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
  ],
  '3': const [SubmitTransactionResponse_InvoiceError$json],
  '4': const [SubmitTransactionResponse_Result$json],
};

const SubmitTransactionResponse_InvoiceError$json = const {
  '1': 'InvoiceError',
  '2': const [
    const {'1': 'op_index', '3': 1, '4': 1, '5': 13, '8': const {}, '10': 'opIndex'},
    const {'1': 'invoice', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.common.v3.Invoice', '8': const {}, '10': 'invoice'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.SubmitTransactionResponse.InvoiceError.Reason', '10': 'reason'},
  ],
  '4': const [SubmitTransactionResponse_InvoiceError_Reason$json],
};

const SubmitTransactionResponse_InvoiceError_Reason$json = const {
  '1': 'Reason',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ALREADY_PAID', '2': 1},
    const {'1': 'WRONG_DESTINATION', '2': 2},
    const {'1': 'SKU_NOT_FOUND', '2': 3},
  ],
};

const SubmitTransactionResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'FAILED', '2': 1},
    const {'1': 'REJECTED', '2': 2},
    const {'1': 'INVOICE_ERROR', '2': 3},
  ],
};

const GetTransactionRequest$json = const {
  '1': 'GetTransactionRequest',
  '2': const [
    const {'1': 'transaction_hash', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '8': const {}, '10': 'transactionHash'},
  ],
};

const GetTransactionResponse$json = const {
  '1': 'GetTransactionResponse',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.transaction.v3.GetTransactionResponse.State', '10': 'state'},
    const {
      '1': 'ledger',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'ledger',
    },
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.HistoryItem', '10': 'item'},
  ],
  '4': const [GetTransactionResponse_State$json],
};

const GetTransactionResponse_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'SUCCESS', '2': 1},
  ],
};

const HistoryItem$json = const {
  '1': 'HistoryItem',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.TransactionHash', '8': const {}, '10': 'hash'},
    const {'1': 'result_xdr', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
    const {'1': 'envelope_xdr', '3': 3, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'cursor', '3': 4, '4': 1, '5': 11, '6': '.kin.agora.transaction.v3.Cursor', '10': 'cursor'},
    const {'1': 'invoice_list', '3': 5, '4': 1, '5': 11, '6': '.kin.agora.common.v3.InvoiceList', '10': 'invoiceList'},
  ],
};

const Cursor$json = const {
  '1': 'Cursor',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

