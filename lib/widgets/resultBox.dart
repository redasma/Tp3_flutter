import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1/models/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key, required this.result, required this.questionLength, required this.restart}) : super(key: key);

  final VoidCallback restart;
  final int result;
  final int questionLength;
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: backgroud,
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Result',
            style: TextStyle(
              color: neutre,
              fontSize: 22.0,
            ),
            ),
            const SizedBox(height: 20.0,),
            CircleAvatar(
              child: Text('$result/$questionLength',
              style: TextStyle(fontSize: 26.0),),
              radius: 70.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(result == questionLength / 2
            ? 'Presque arrivé'
                : result < questionLength / 2
            ? 'tu peux faire mieux'
            : 'bien joué',
            style: TextStyle(
              color:neutre,
            ),),
            const SizedBox(height: 25.0,),
            GestureDetector(
              onTap: restart,
              child: Text(
                'Start again',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22.0,
                  letterSpacing: 1.0,
                ),
              ),
            )
          ],
        )
      ),
    );

  }
}