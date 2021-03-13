class MetaInformation {
  final String agoraApiVersion;
  final String sdkVersion;
  final int timestamp = DateTime.now().millisecondsSinceEpoch;

  MetaInformation(this.agoraApiVersion, this.sdkVersion);
}
