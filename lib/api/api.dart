import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String url = "https://faheem.pythonanywhere.com/api/";
  final String _username = 'faheem';
  final String _password = '123456';
  static String token;
  Future<bool> getApiToken() async {
    String tokenKey = "";
    var data = jsonEncode(
        <String, String>{'username': _username, 'password': _password});
    String tokenUrl = "${url}api-token-auth/".trim();

    var response = await http.post(tokenUrl,
        headers: {"Content-Type": "application/json"}, body: data);

    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body) as Map;
      tokenKey = map.values.first.toString();
      token = tokenKey;
      return true;
    } else {
      return false;
    }
  }
}
