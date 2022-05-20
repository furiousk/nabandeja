import 'package:flutter/material.dart';

import 'model/auth.dart';
import 'service/api_client.dart';

void main() => runApp(const LoginApp());

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

class ContentStatefulWidget extends StatefulWidget {
  const ContentStatefulWidget({Key? key}) : super(key: key);

  @override
  State<ContentStatefulWidget> createState() => _ContentStatefulWidgetState();
}

class _ContentStatefulWidgetState extends State<ContentStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiClient _api = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'NaBandeja',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    Auth userLogin = Auth(
                      login: nameController.text,
                      password: passwordController.text,
                      keepAlive: false,
                    );
                    print(userLogin.login);
                    print(userLogin.password);
                    final data = await _api.login(userLogin);
                    print(data.newPasswordToken);
                  },
                )),
          ],
        ));
  }
}
