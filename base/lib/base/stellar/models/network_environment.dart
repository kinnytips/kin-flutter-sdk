import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:kin_base/stellarfork/network.dart';

abstract class  NetworkEnvironment {

  static const _kin3TestNetPassphrase = "Kin Testnet ; December 2018";
  static const _kin3MainNetPassphrase = "Kin Mainnet ; December 2018";

  static const _kin2MainNetPassphrase = "Public Global Kin Ecosystem Network ; June 2018";
  static const _kin2TestNetPassphrase = "Kin Playground Network ; June 2018";
  static final _kin2IssuerProd = KeyPair.fromAccountId("GDF42M3IPERQCBLWFEZKQRK77JQ65SCKTU3CW36HZVCX7XX5A5QXZIVK");
  static final _kin2IssuerTest = KeyPair.fromAccountId("GBC3SG6NGTSZ2OMH3FFGB7UVRQWILW367U4GSOOF4TFSZONV42UJXUH7");

  final String networkPassphrase;
  final KeyPair issuer;

  const NetworkEnvironment(this.networkPassphrase, [this.issuer]) ;

  Network get network => Network(networkPassphrase);

  String toString() {
      return "NetworkEnvironment(networkPassphrase='$networkPassphrase')";
  }
}

class KinStellarTestNetKin3 extends NetworkEnvironment {
  static final KinStellarTestNetKin3 instance = KinStellarTestNetKin3._();

  const KinStellarTestNetKin3._() : super(NetworkEnvironment._kin3TestNetPassphrase);
}

class KinStellarMainNetKin3 extends NetworkEnvironment {
  static final KinStellarMainNetKin3 instance = KinStellarMainNetKin3._();

  const KinStellarMainNetKin3._() : super(NetworkEnvironment._kin3MainNetPassphrase);
}


class KinStellarTestNetKin2 extends NetworkEnvironment {
  static final KinStellarTestNetKin2 instance = KinStellarTestNetKin2._();

  KinStellarTestNetKin2._() : super(NetworkEnvironment._kin2TestNetPassphrase, NetworkEnvironment._kin2IssuerTest);
}

class KinStellarMainNetKin2 extends NetworkEnvironment {
  static final KinStellarMainNetKin2 instance = KinStellarMainNetKin2._();

  KinStellarMainNetKin2._() : super(NetworkEnvironment._kin2MainNetPassphrase, NetworkEnvironment._kin2IssuerProd);
}