import 'package:nabandeja/model/kds_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/kds_groups.dart';
import '../../model/kds_sales_order.dart';
import '../../service/api_client.dart';

class Methods {
  final ApiClient _api = ApiClient();

  Future<List<KdsGroups>> loadKdsGroups() async {
    List<KdsGroups> data = await _api.listKdsGroups();
    return data;
  }

  Future<List<KdsSalesOrder>> loadKdsSalesOrder(
    int status,
    String filter,
  ) async {
    List<KdsSalesOrder> data = await _api.listOrdersByStatus(status);
    var dataFiltered =
        data.where((element) => element.displayId == filter).toList();
    return dataFiltered;
  }

  Future<String> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyName').toString();
  }

  updateOrderStatus(KdsOrder kdsOrder) async {
    _api.updateOrderStatus(kdsOrder);
  }
}
