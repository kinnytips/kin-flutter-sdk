import 'network_environment.dart';

class ApiConfig {
  static final ApiConfig testNetAgora = ApiConfig(
    'api.agorainfra.dev',
    KinStellarTestNetKin3.instance,
    443,
  );

  static final ApiConfig mainNetAgora = ApiConfig(
    'api.agorainfra.net',
    KinStellarMainNetKin3.instance,
    443,
  );

  final String networkEndpoint;

  final NetworkEnvironment networkEnv;

  final int tlsPort;

  ApiConfig(this.networkEndpoint, this.networkEnv, this.tlsPort);
}
