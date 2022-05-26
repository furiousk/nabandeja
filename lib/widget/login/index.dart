import 'package:flutter/material.dart';
import 'form.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ContentStatefulWidget()
      ),
    );
  }
}