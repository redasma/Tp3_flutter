import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1/models/constants.dart';
import 'package:tp1/models/question.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, required this.question, required this.index, required this.nbQuestions}) : super(key: key);

  final String question;
  final int index;
  final int nbQuestions;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,

      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20.0, right:20.0, left: 20.0 ),
      decoration:  BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            backgroud,
            Colors.blueAccent,
          ],
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
      ),
      child: Text('Question ${index + 1}/ $nbQuestions : $question',
        style: TextStyle(
          fontSize: 22.0,
          color: neutre,

        ),
      ),
    );

}
}