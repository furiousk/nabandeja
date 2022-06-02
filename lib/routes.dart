import 'package:flutter/material.dart';
import 'package:nabandeja/widget/company/index.dart';
import 'package:nabandeja/widget/login/index.dart';
import 'package:nabandeja/widget/order/index.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/login': (_) => const LoginApp(),
    '/company': (_) => const CompanyApp(),
    '/order': (_) => const OrderApp(),
  };

  static String initial = '/login';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
