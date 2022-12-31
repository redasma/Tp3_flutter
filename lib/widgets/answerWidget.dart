import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1/models/constants.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key,required this.option, required this.color, required this.onTap}) : super(key: key);

  final String option;
  final Color color;
  final VoidCallback onTap;
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap,
      child:Card(
        color: color,
      child: ListTile(
      title: Text(
        option,
        textAlign: TextAlign.center,
        style:TextStyle(
          fontSize: 22.0,
          color: color.red != color.green ? neutre : Colors.black,

        )
      ),
    )
    )
    );

  }
}