import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth.dart';
import '../model/token.dart';

class ApiClient {
  static const baseUrl = "https://stg.thexpos.net/ordercontrol/";
  static const socketUrl = "${ApiClient.baseUrl}signalrserver/poskds";
  final http.Client _inner = http.Client();

  Future<Token> login(Auth userLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("${ApiClient.baseUrl}user/login");
    final request = http.Request('POST', url);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.body = jsonEncode(userLogin.toJson());
    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      Token data = Token.fromJson(jsonDecode(response.body));
      prefs.setString("token", data.newPasswordToken.toString());
      return data;
    } else {
      throw Exception('Failed to create post');
    }
  }
}
