import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/auth.dart';
import '../model/token.dart';

class ApiClient {
  static const baseUrl = "https://stg.thexpos.net/";
  static const socketUrl = "${ApiClient.baseUrl}signalrserver/poskds";
  final http.Client _inner = http.Client();

  Future<Token> login(Auth userLogin) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("${ApiClient.baseUrl}user/login");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final request = http.Request('POST', url);
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(userLogin.toJson());
    final response = await _inner.send(request);
    if (response.statusCode == 201) {
      Token data = Token.fromJson(jsonDecode(response.stream.toString()));
      //prefs.setString("token", data.newPasswordToken.toString());
      return data;
    } else {
      throw Exception('Failed to create post');
    }
  }
}
