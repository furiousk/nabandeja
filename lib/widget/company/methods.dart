import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/company.dart';
import '../../service/api_client.dart';
import '../order/index.dart';

class Methods {
  final ApiClient _api = ApiClient();

  Future<List<Company>> loadCompany() async {
    List<Company> data = await _api.listCompany();
    return data;
  }

  Future<void> goHome(Company company, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = company.id ?? "";
    var name = company.companyFantasyName ?? "";

    prefs.setString('company', id);
    prefs.setString('companyName', name);

    var companyAuth = await _api.authCompany(id);

    if (companyAuth.authenticated == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderApp()),
      );
    }
  }
}
