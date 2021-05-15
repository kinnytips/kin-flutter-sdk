import 'package:kin_base/stellarfork/requests/accounts_request_builder.dart';
import 'package:kin_base/stellarfork/requests/ledgers_request_builder.dart';
import 'package:kin_base/stellarfork/requests/transactions_request_builder.dart';

abstract class KinServer {
  KinServer();
  
  AccountsRequestBuilder accounts();
  
  LedgersRequestBuilder ledgers();

  TransactionsRequestBuilder transactions();
}