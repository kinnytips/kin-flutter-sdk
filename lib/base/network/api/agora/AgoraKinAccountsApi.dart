import 'package:kin_sdk/base-compat/main/network.dart';
import 'package:kin_sdk/base/network/models/KinAccount.dart';
import 'package:kin_sdk/base/network/models/KinAccount.dart';
import 'package:meta/meta.dart';

abstract class AgoraKinAccountsApi {
  AgoraKinAccountsApi(ManagedChannel managedChannel, Network networkEnvironment)

  // ignore: empty_constructor_bodies
  GrpcApi(managedChannel)

  ,

  KinAccountApi

  ,

  KinStreamingApi

  ,

  KinAccountCreationApi

  ;

  var accountApi = AccountGrpc.newStub(managedChannel);

  createAccount(KinAccountCreationApi.CreateAccountRequest request,
      KinAccountCreationApi.CreateAccountResponse onCompleted) {
    createAccount
        .callAsPromisedCallback(
        request.toGrpcRequest(),
        onCompleted.createAccountResponse()
    )
  }

  getAccount(GetAccountRequest request, GetAccountResponse onCompleted) {
    getAccountInfo
        .callAsPromisedCallback(
        request.toGrpcRequest(),
        onCompleted.getAccountResponse()
    )
  }


}

@sealed
class AgoraEvent {

  abstract AccountService.Event event;

  UnknownEvent(event);

  AccountUpdate(event);

  TransactionUpdate(event);
}

class UnknownEvent(

AccountService.Event event
) {
return AgoraEvent();
}

class AccountUpdate(

KinAccount kinAccount, AccountService
.
Eventevent:) {
return AgoraEvent();
}

class TransactionUpdate(

KinTransaction kinTransaction, AccountService
.

Event event
) {
return AgoraEvent();
}

streamAccount
(

KinAccount.Id kinAccountId
)
Observer<KinAccount>{
return openEventStream(kinAccountId)
    .filter { (it as? AgoraEvent.AccountUpdate) != null }
    .map { (it as AgoraEvent.AccountUpdate).kinAccount }

}




