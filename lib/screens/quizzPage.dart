import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/question.dart';
import 'package:tp1/services/databaseServices.dart';
import '../models/constants.dart';
import 'package:tp1/widgets/questionWidget.dart';
import 'package:tp1/widgets/nextButton.dart';
import '../widgets/answerWidget.dart';
import '../widgets/resultBox.dart';
import '../widgets/ImageWidget.dart';
import 'questionDialog.dart';
class QuizzPage extends StatefulWidget{

   QuizzPage ({Key? key,}) : super(key:key);

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage>{
  _QuizzPageState ({Key? key}) ;
  int index = 0;
  bool isPressed = false;
  int score = 0;
  bool alreadySelected = false;
  List<Question>  questions = [];
  var questionsSnapshot;
  void nextQuestion(){

    if(index == questionsSnapshot.length - 1){
      showDialog(context: context,
          barrierDismissible:false,
          builder: (ctx) => ResultBox(result: score,questionLength: questionsSnapshot.length,restart: restart,));
    }else if(isPressed){
      setState(() {
        index++;
        isPressed = false;
        alreadySelected = false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text('please select an answer'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(vertical:20.0),
          ),
      );
    }

  }

  void changeCardState(bool value){
    if(alreadySelected){
      return;
    }else{

    if(value == questionsSnapshot[index].get('isCorrect')){
      ++score;
    }
    setState(() {
      isPressed = true;
      alreadySelected = true;
    });
  }
  }

  void restart(){
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      alreadySelected = false;
    });
    Navigator.pop(context);
  }
  
  void showQuestionDialog(BuildContext context){
    QuestionDialog.showQuestionDialog(context,ImageSource.gallery);
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().Questions.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.none){
          return Container(
            child: Text('connexion inexistante'),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }

         questionsSnapshot= snapshot.data?.docs;
        if(questionsSnapshot == null || questionsSnapshot.isEmpty){
         return Container(
           child: Text("votre collection est vide l'application ne peux pas demarrer "),
         );
        }
        return Scaffold(
          backgroundColor: backgroud,
          appBar: AppBar(
            title: const Text('Quizz App'),
            backgroundColor: backgroud,
            shadowColor: Colors.transparent,
            actions: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    height: 40,
                 width: 40,
                 margin: EdgeInsets.only(right: 15.0),
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle, color: Theme.of(context).primaryColor.withOpacity(0.5),
                 ),
                 child: IconButton(
                   alignment: Alignment.center,
                      onPressed: ()=> showQuestionDialog(context),
                      icon: Icon(Icons.add),
                  ),),
              Text('score : $score',
              style: TextStyle(
                fontSize: 18.0,
              ),),
        ]),
              ),
          ],
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: Column(
              children: [
                ImageWidget(url: questionsSnapshot[index].get('urlImage')),
                QuestionWidget(question: questionsSnapshot[index].get('questionText'), index: index, nbQuestions: questionsSnapshot.length),
                const Divider(color: neutre,),
                const SizedBox(height: 20.0,),
                AnswerWidget(option: 'Vrai', color: isPressed ? questionsSnapshot[index].get('isCorrect') ? correct: incorrect : neutre, onTap:() => changeCardState(true), ),
                AnswerWidget(option: 'Faux', color: isPressed ? questionsSnapshot[index].get('isCorrect') ? incorrect : correct: neutre, onTap: () => changeCardState(false),),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: NextButton(nextQuestion: nextQuestion,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      }
    );
  }
}