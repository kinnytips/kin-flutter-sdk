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
      account = server.accounts().account(request.accountId.toKeyPair());
      if(account == null) {
        onCompleted = GetAccountResult.TransientFailure(MalformedBodyException);
      }
      else {
        onCompleted = GetAccountResult.Ok;
      }
    }
    catch (e) {
      if(e is HttpResponseException) {
        if(e.statusCode == 400) {
          onCompleted = GetAccountResult.NotFound;
        }
        else if (e.statusCode >= 500) {
          onCompleted = GetAccountResult.TransientFailure(e);
        }
        else {
          onCompleted = GetAccountResult.UndefinedError(e);
        }
      }
      else if (e is SocketTimeoutExcpetion || e is OperationTimeoutException) {
        onCompleted = GetAccountResult.TransientFailure(TimeoutException);
      }
      else if (e is TooManyRequestsException) {
        onCompleted = GetAccountResult.TransientFailure(e);
      }
      else if (e is ServerGoneException) {
        onCompleted = GetAccountResult.UpgradeRequiredError;
      }
      else {
        onCompleted = GetAccountResult.UndefinedError(e);
      }
    }
  }
}