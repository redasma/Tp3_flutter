import 'package:flutter/cupertino.dart';
import 'package:tp1/models/constants.dart';

class NextButton extends StatelessWidget {
const NextButton({Key? key, required this.nextQuestion}) : super(key: key);

final VoidCallback nextQuestion;
// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return  GestureDetector(
    onTap: nextQuestion,
    child:Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color:neutre,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      'Next',
          textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 23.0,
      ),
    ),

  ),
  );

}
}