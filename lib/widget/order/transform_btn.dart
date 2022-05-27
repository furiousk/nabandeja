import 'package:flutter/material.dart';

class TransformBtnWidget extends StatelessWidget {
  final double translateButton;
  final Color colorBtn;
  final Icon iconBtn;
  final void Function() callback;

  const TransformBtnWidget(
    BuildContext context, {
    required this.translateButton,
    required this.colorBtn,
    required this.iconBtn,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        translateButton,
        0.0,
      ),
      child: FloatingActionButton(
        backgroundColor: colorBtn,
        onPressed: () {
          callback();
        },
        child: iconBtn,
      ),
    );
  }
}
