import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/question.dart';
import 'package:firebase_core/firebase_core.dart';



class DatabaseService{
  CollectionReference Questions = FirebaseFirestore.instance.collection("questions");
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(file) async{
    Reference reference = storage.ref().child('questions/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void addQuestion(Question question){

    Questions.add({
      'questionText':question.questionText,
      'isCorrect' : question.isCorrect,
      'categorie':question.categorie,
      'urlImage' : question.urlImage
    });

  }

  Stream<List<Question>> get questions{
    Query queryQuestions = Questions.orderBy('id');
    return queryQuestions.snapshots().map((snapshot)  {
      return snapshot.docs.map((doc) {
        return Question(
          id:doc.id,
          questionText: doc.get('questionText'),
          categorie: doc.get('categorie'),
          urlImage: doc.get('urlImage'),
          isCorrect: doc.get('isCorrect'),
        );
  }).toList();
  });
}
}