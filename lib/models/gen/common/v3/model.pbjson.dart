///
//  Generated code. Do not modify.
//  source: common/v3/model.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const StellarAccountId$json = const {
  '1': 'StellarAccountId',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'value'},
  ],
};

const TransactionHash$json = const {
  '1': 'TransactionHash',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

const InvoiceHash$json = const {
  '1': 'InvoiceHash',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '8': const {}, '10': 'value'},
  ],
};

const Invoice$json = const {
  '1': 'Invoice',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.kin.agora.common.v3.Invoice.LineItem', '8': const {}, '10': 'items'},
  ],
  '3': const [Invoice_LineItem$json],
};

const Invoice_LineItem$json = const {
  '1': 'LineItem',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'description'},
    const {
      '1': 'amount',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': const {'6': 1},
      '10': 'amount',
    },
    const {'1': 'sku', '3': 4, '4': 1, '5': 12, '8': const {}, '10': 'sku'},
  ],
};

const InvoiceList$json = const {
  '1': 'InvoiceList',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.kin.agora.common.v3.Invoice', '8': const {}, '10': 'invoices'},
  ],
};

