/// Defines base endpoints for connection to server.
class ServerAddress {
  ///  Base address for connection.

  /// Product server
  final String _address = "https://metal.tez.kg/seitek/hs/clientMobile";

  /// Api version.
  final String _apiVer = "";

  /// Base url for connection.
  //String get baseUrl => "$_address/$_apiVer";
  String get baseUrl => "$_address";
  String get imageUrl => "https://metal.tez.kg/Photos/";

}
