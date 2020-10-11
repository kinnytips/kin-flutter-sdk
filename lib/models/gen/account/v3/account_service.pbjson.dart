///
//  Generated code. Do not modify.
//  source: account/v3/account_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const AccountInfo$json = const {
  '1': 'AccountInfo',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
    const {
      '1': 'sequence_number',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'sequenceNumber',
    },
    const {
      '1': 'balance',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'balance',
    },
  ],
};

const CreateAccountRequest$json = const {
  '1': 'CreateAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

const CreateAccountResponse$json = const {
  '1': 'CreateAccountResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.CreateAccountResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '10': 'accountInfo'},
  ],
  '4': const [CreateAccountResponse_Result$json],
};

const CreateAccountResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'EXISTS', '2': 1},
  ],
};

const GetAccountInfoRequest$json = const {
  '1': 'GetAccountInfoRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

const GetAccountInfoResponse$json = const {
  '1': 'GetAccountInfoResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.GetAccountInfoResponse.Result', '10': 'result'},
    const {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '10': 'accountInfo'},
  ],
  '4': const [GetAccountInfoResponse_Result$json],
};

const GetAccountInfoResponse_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

const GetEventsRequest$json = const {
  '1': 'GetEventsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.common.v3.StellarAccountId', '8': const {}, '10': 'accountId'},
  ],
};

const Events$json = const {
  '1': 'Events',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.kin.agora.account.v3.Events.Result', '10': 'result'},
    const {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.kin.agora.account.v3.Event', '8': const {}, '10': 'events'},
  ],
  '4': const [Events_Result$json],
};

const Events_Result$json = const {
  '1': 'Result',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'NOT_FOUND', '2': 1},
  ],
};

const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'account_update_event', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountUpdateEvent', '9': 0, '10': 'accountUpdateEvent'},
    const {'1': 'transaction_event', '3': 2, '4': 1, '5': 11, '6': '.kin.agora.account.v3.TransactionEvent', '9': 0, '10': 'transactionEvent'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

const AccountUpdateEvent$json = const {
  '1': 'AccountUpdateEvent',
  '2': const [
    const {'1': 'account_info', '3': 1, '4': 1, '5': 11, '6': '.kin.agora.account.v3.AccountInfo', '8': const {}, '10': 'accountInfo'},
  ],
};

const TransactionEvent$json = const {
  '1': 'TransactionEvent',
  '2': const [
    const {'1': 'envelope_xdr', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'envelopeXdr'},
    const {'1': 'result_xdr', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'resultXdr'},
  ],
};

