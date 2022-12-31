import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1/models/constants.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  const ImageWidget({Key? key,required this.url, }) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(top: 5 ),
      alignment: Alignment.topCenter,
      width: 200,
      height: 120,

      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
            color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
        image: DecorationImage(
            image:new NetworkImage(url),
            fit: BoxFit.fill
        ),
      ),
    );

  }
}