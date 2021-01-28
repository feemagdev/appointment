import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String url = "https://faheem.pythonanywhere.com/api/";
  String _username = 'faheem';
  String _password = '123456';
  static String token;
  Future<bool> getApiToken() async {
    String tokenKey = "";
    var data = jsonEncode(
        <String, String>{'username': _username, 'password': _password});
    String tokenUrl = "${url}api-token-auth/".trim();
    print(tokenUrl);
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
