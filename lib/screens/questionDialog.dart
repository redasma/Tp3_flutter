

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:tp1/models/constants.dart';
import 'package:tp1/models/question.dart';
import '../services/databaseServices.dart';
class QuestionDialog{

  QuestionDialog();
  static void showQuestionDialog(BuildContext context, ImageSource source) async {
    final _keyForm = GlobalKey<FormState>();
    String questionText ='';
    bool isCorrect = false ;
    String categorie ='';

    String formError = 'veuillez remplir tous les champs svp';
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    File file = File(pickedFile!.path);

    showDialog(context: context,
        builder: (BuildContext context){
      return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(file),
                fit: BoxFit.cover
              )

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 300,
                        onChanged: (value) => questionText = value,
                        validator: (value) => questionText == '' ? formError : null,
                        decoration: InputDecoration(
                          labelText: 'Entrez la question',
                          border: OutlineInputBorder(),
                        ),
                      ),
                         SelectFormField(
                           type: SelectFormFieldType.dropdown,
                           initialValue: 'Vrai',
                           items: [{'value' : 'true' , 'label' : 'Vrai'},
                           {'value' : 'false' , 'label' : 'Faux'}],
                           onChanged: (value) => isCorrect = value == 'true'? true: false,
                           onSaved: (value)=> isCorrect = value == 'false'? true: false,
                           decoration: InputDecoration(
                             labelText: 'Véracité',
                               border: OutlineInputBorder(),
                           ),
                         ),
                         TextFormField(
                          maxLength: 20,
                          onChanged: (value) => categorie = value,
                          validator: (value) => categorie == '' ? formError : null,
                          decoration: InputDecoration(
                            labelText: 'Entrez la categorie',
                            border: OutlineInputBorder(),
                          ),
                        ) ,
                    ],
                  ) ,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    children: [
                      TextButton(
                          onPressed: ()=> Navigator.of(context).pop(),
                          child: Text('Annuler'),
                      ),
                      ElevatedButton(onPressed: ()=> onSubmit(context, _keyForm, questionText,file, isCorrect, categorie),
                          child: Text('PUBLIER'))
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      );
    });
  }

  static Future<void> onSubmit(context, keyForm, questionText, file, isCorrect,categorie) async {
    print(categorie);
    if(keyForm.currentState!.validate()){
      Navigator.of(context).pop();
      DatabaseService db = DatabaseService();
      String urlImage = await db.uploadFile(file);
      db.addQuestion(Question(
          questionText: questionText,
          isCorrect: isCorrect,
          categorie: categorie,
          id: '',
          urlImage: urlImage));
    }
  }

}