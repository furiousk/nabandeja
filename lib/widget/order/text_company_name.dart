import 'package:flutter/material.dart';

import 'methods.dart';

class TextCompanyNameWidget extends StatelessWidget {
  final Methods _methods = Methods();
  TextCompanyNameWidget(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: _methods.getCompanyName(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data ?? "");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
