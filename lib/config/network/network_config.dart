class NetworkConfig {
  String globalBackendUrl;
  String globalBattleSocket;

  final String termsUrl;
  final String privacyUrl;

  final String iosAppId;
  final String androidAppId;

  final bool isDevelopment; // if true we will enable development featues

  NetworkConfig({
    required this.globalBackendUrl,
    required this.globalBattleSocket,
    required this.termsUrl,
    required this.privacyUrl,
    required this.iosAppId,
    required this.androidAppId,
    this.isDevelopment = false,
  });
}
