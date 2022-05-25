import 'package:flutter/material.dart';
import 'package:nabandeja/model/company.dart';
import 'package:nabandeja/widget/order/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_client.dart';

class Methods {
  final ApiClient _api = ApiClient();

  Future<List<Company>> loadCompany() async {
    List<Company> data = await _api.listCompany();
    return data;
  }

  Future<void> goHome(id, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('company', id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Order()),
    );
  }
}
