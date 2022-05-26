import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import './card_build.dart';

class CompanyApp extends StatelessWidget {
  const CompanyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('Estabelecimentos'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [CardWidget(context)],
              )),
        ));
  }
}
