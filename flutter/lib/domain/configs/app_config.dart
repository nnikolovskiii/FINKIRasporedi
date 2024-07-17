import 'dart:convert';
import 'package:universal_html/html.dart' as html;



class AppConfig {
  static late String apiUrl;

  static Future<void> forEnvironment() async {
    final response = await html.HttpRequest.getString('config.json');
    final config = json.decode(response);
    apiUrl = config['apiUrl'];
  }
}
