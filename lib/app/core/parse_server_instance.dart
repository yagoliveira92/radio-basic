import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseServerInstance {
  static Future<void> initParse() async {
    await Parse().initialize('appId', 'serverUrl',
        debug: true,
        autoSendSessionId: true,
        clientKey: 'clienteApiKey',
        liveQueryUrl: 'liveQueryUrl');
  }
}
