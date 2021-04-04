abstract class  NetworkEnvironment {
  String _networkPassphrase;
  NetworkEnvironment(String networkPassphrase, [KeyPair? issuer]){
    _networkPassphrase = networkPassphrase;
  }

  String toString() {
      return "NetworkEnvironment(networkPassphrase='$_networkPassphrase')";
  }
}

const _kin3TestNetPassphrase = "Kin Testnet ; December 2018";
const _kin3MainNetPassphrase = "Kin Mainnet ; December 2018";

const _kin2MainNetPassphrase = "Public Global Kin Ecosystem Network ; June 2018";
const _kin2TestNetPassphrase = "Kin Playground Network ; June 2018";
var _kin2IssuerProd = KeyPair.fromAccountId("GDF42M3IPERQCBLWFEZKQRK77JQ65SCKTU3CW36HZVCX7XX5A5QXZIVK");
var _kin2IssuerTest = KeyPair.fromAccountId("GBC3SG6NGTSZ2OMH3FFGB7UVRQWILW367U4GSOOF4TFSZONV42UJXUH7");

class KinStellarTestNetKin3 extends NetworkEnvironment {
  KinStellarTestNetKin3() : super(_kin3TestNetPassphrase);
}

class KinStellarMainNetKin3 extends NetworkEnvironment {
  KinStellarMainNetKin3() : super(_kin3MainNetPassphrase);
}


class KinStellarTestNetKin2 extends NetworkEnvironment {
  KinStellarTestNetKin2() : super(_kin2TestNetPassphrase, _kin2IssuerTest);
}

class KinStellarMainNetKin2 extends NetworkEnvironment {
  KinStellarMainNetKin2() : super(_kin2MainNetPassphrase, _kin2IssuerProd);
}