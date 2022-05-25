import 'package:nabandeja/model/company.dart';

import '../../service/api_client.dart';

class Methods {
  final ApiClient _api = ApiClient();

  Future<List<Company>> loadCompany() async {
    List<Company> data = await _api.listCompany();
    return data;
  }
}
