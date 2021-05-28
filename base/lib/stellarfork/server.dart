import 'dart:io';

import 'package:kin_base/stellarfork/kinserver.dart';
import 'package:kin_base/stellarfork/requests/transactions_request_builder.dart';
import 'package:kin_base/stellarfork/requests/ledgers_request_builder.dart';
import 'package:kin_base/stellarfork/requests/accounts_request_builder.dart';

class Server implements KinServer {
  String uri;
  HttpClient httpClient;
  Uri _serverURI;

  Server(this.uri, this.httpClient) {
    _serverURI = createUri(uri);
   }

  Uri createUri(String uri) {
    return Uri.parse(uri);
  }

  @override
  AccountsRequestBuilder accounts() {
    // TODO: implement accounts
    throw UnimplementedError();
  }

  @override
  LedgersRequestBuilder ledgers() {
    // TODO: implement ledgers
    throw UnimplementedError();
  }

  @override
  TransactionsRequestBuilder transactions() {
    // TODO: implement transactions
    throw UnimplementedError();
  }}