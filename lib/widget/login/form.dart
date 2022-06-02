import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import 'package:nabandeja/assets/themes/app_images.dart';
import '../company/index.dart';
import 'methods.dart';

class ContentStatefulWidget extends StatefulWidget {
  const ContentStatefulWidget({Key? key}) : super(key: key);
  @override
  State<ContentStatefulWidget> createState() => _ContentStatefulWidgetState();
}

class _ContentStatefulWidgetState extends State<ContentStatefulWidget> {
  TextEditingController nameController = TextEditingController()
    ..text = 'timeapps';
  TextEditingController passwordController = TextEditingController()
    ..text = 'apps@totvs2022';
  final Methods _methods = Methods();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 380,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Hospitalidade Na Bandeja',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w100,
                    letterSpacing: -1.2,
                    fontSize: 30,
                  ),
                )),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: const Text(
                  'Boas-vindas',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: AppColors.secondary,
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.grey,
                    ),
                    labelText: 'Usuário',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  cursorColor: AppColors.secondary,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.grey,
                    ),
                    labelText: 'Senha',
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await _methods.auth(
                        nameController.text, passwordController.text);
                    if (result) {
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CompanyApp()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.secondary,
                  ),
                  child: const Text('Login'),
                )),
              Container(
                margin: const EdgeInsets.all(15),
                child: Image.asset(
                  AppImages.logoMini,
                  height: 20,
                ),
              ),
            ],
          ),
        ));
  }
}
