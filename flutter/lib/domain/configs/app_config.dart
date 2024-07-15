import 'dart:convert';
import 'dart:html';

class AppConfig {
  static late String apiUrl;

  static Future<void> forEnvironment() async {
    final response = await HttpRequest.getString('config.json');
    final config = json.decode(response);
    apiUrl = config['apiUrl'];
  }
}
