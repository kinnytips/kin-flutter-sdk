import 'dart:html';
import 'dart:io';

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/api/horizon/kin_json_api.dart';
import 'package:kin_base/base/network/api/kin_transaction_api.dart';
import 'package:kin_base/base/tools/managed_server_sent_event_stream.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/stellarfork/responses/account_response.dart';
import 'package:kin_base/stellarfork/responses/transaction_response.dart';

class HorizonKinApi implements KinJsonApi {
  HorizonKinApi(ApiConfig environment, HttpClient httpClient) : super(environment, httpClient);

  static const CURSOR_FUTURE_ONLY = "now";

  _accountStreams = new Map<KinAccountId, ManagedServerSentEventStream<AccountResponse>>();
  
  _transactionStreams = new Map<KinAccountId, ManagedServerSentEventStream<TransactionResponse>>();

  Observer<KinAccount> streamAccount(KinAccountId kinAccountId) {
    var accountStream = _accountStreams[kinAccountId] ?? ManagedServerSentEventStream<AccountResponse>(server.accounts().forAccount(kinAccountId.toKeyPair()));

    _accountStreams[kinAccountId] = accountStream;

    EventListener<AccountResponse> listener = null;

    var subject = ValueSubject<KinAccount>();

    listener = EventListener<AccountResponse>() {
      onEvent(AccountResponse data) {
        subject.onNext(data.kinAccount());
      }
    };

    _accountStreams.addListener(listener);

    subject.doOnDisposed(() { 
      _accountStreams.removeListener(listener);
      _accountStreams[kinAccountId] = null;
    });
      
    return subject;
  }

  Observer<KinTransaction> streamTransactions(KinAccountId kinAccountId) {


    EventListener<TransactionResponse> listener = null;
    
    var subject = ValueSubject<KinTransaction>();
    listener = EventListener<TransactionResponse>() {
      onEvent(TransactionResponse data) {
        subject.onNext(data.asKinTransaction(environment.networkEnv));
      }
    };

    _transactionStreams.addListener(listener);

    subject.doOnDisposed(() { 
      _transactionStreams.removeListener(listener);
      _accountStreams[kinAccountId] = null;
    });
      
    return subject;
  }

  getAccount(GetAccountRequest request, GetAccountResponse onCompleted) {
    KinAccount account = null;
    var result = try {
      server.accounts()
        .account(request.accountId.toKeyPair());
    }
  }
}