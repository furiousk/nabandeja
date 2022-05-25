import 'package:flutter/material.dart';
import '../company/index.dart';
import 'methods.dart';

class ContentStatefulWidget extends StatefulWidget {
  const ContentStatefulWidget({Key? key}) : super(key: key);
  @override
  State<ContentStatefulWidget> createState() => _ContentStatefulWidgetState();
}

class _ContentStatefulWidgetState extends State<ContentStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Methods _methods = Methods();

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
                    var result = await _methods.auth(
                        nameController.text, passwordController.text);
                    if (result) {
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompanyApp()),
                      );
                    }
                  },
                )),
          ],
        ));
  }
}
