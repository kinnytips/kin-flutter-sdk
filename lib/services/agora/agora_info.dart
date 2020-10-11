class AgoraInfo {
  static String _testEndpoint = "api.agorainfra.dev";
  static String _productionEndpoint = "api.agorainfra.net";

  static String getEndpoint(bool isProduction) =>
      isProduction ? _productionEndpoint : _testEndpoint;
}
