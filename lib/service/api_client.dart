import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth.dart';
import '../model/company.dart';
import '../model/kds_groups.dart';
import '../model/kds_sales_order.dart';
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
      throw Exception('Failed logon');
    }
  }

  Future<Token> authCompany(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        "${ApiClient.baseUrl}user/changecompany?companyId=$id&keepAlive=false");
    final request = http.Request('POST', url);

    request.headers['Content-Type'] = 'application/json';
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.headers['Authorization'] = "Bearer ${prefs.getString("token")}";

    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      Token data = Token.fromJson(jsonDecode(response.body));
      prefs.setString("tokenCompany", data.newPasswordToken.toString());
      return data;
    } else {
      throw Exception('Failed logon');
    }
  }

  Future<List<Company>> listCompany() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("${ApiClient.baseUrl}company/getsimplifiedcompanylist");
    final request = http.Request('GET', url);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = "Bearer ${prefs.getString("token")}";

    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<Company> data = List<Company>.from(
          jsonDecode(response.body).map((x) => Company.fromJson(x)));
      return data;
    } else {
      throw Exception('Failed get company');
    }
  }

  Future<List<KdsGroups>> listKdsGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("${ApiClient.baseUrl}kitchen/kdsgroups");
    final request = http.Request('GET', url);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] =
        "Bearer ${prefs.getString("tokenCompany")}";

    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<KdsGroups> data = List<KdsGroups>.from(
          jsonDecode(response.body).map((x) => KdsGroups.fromJson(x)));
      return data;
    } else {
      throw Exception('Failed get KdsGroups');
    }
  }

  Future<List<KdsSalesOrder>> listOrdersByStatus(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        "${ApiClient.baseUrl}kitchen/ordersbystatus?statusList=$status&culture=pt-BR");
    final request = http.Request('GET', url);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] =
        "Bearer ${prefs.getString("tokenCompany")}";

    final streamedResponse = await _inner.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<KdsSalesOrder> data = List<KdsSalesOrder>.from(
          jsonDecode(response.body).map((x) => KdsSalesOrder.fromJson(x)));
      return data;
    } else {
      throw Exception('Failed get KdsSalesOrder');
    }
  }
}
