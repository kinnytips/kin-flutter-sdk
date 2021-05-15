
import 'package:kin_base/base/network/services/kin_service.dart';

abstract class KinTransactionWhitelistingApi {

  bool get isWhitelistingAvailable ;

  // returns a base64EncodedWhitelistedTransactionEnvelopeBytes:
  Future<KinServiceResponse<String>> whitelistTransaction(String base64EncodedTransactionEnvelopeBytes);

}
