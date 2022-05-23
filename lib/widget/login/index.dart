import 'package:flutter/material.dart';

import 'form.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);
  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const ContentStatefulWidget(),
      ),
    );
  }
}
