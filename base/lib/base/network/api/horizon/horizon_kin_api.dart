import 'dart:io';

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/tools/managed_server_sent_event_stream.dart';
import 'package:kin_base/stellarfork/responses/account_response.dart';

class HorizonKinApi {
  HorizonKinApi(ApiConfig environment, HttpClient httpClient) {}

  static const CURSOR_FUTURE_ONLY = "now";

  _accountStreams = new Map<KinAccountId, ManagedServerSentEventStream<AccountResponse>>();
}