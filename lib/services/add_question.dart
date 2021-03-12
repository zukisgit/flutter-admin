import 'package:cloud_firestore/cloud_firestore.dart';

class addquestion{
  FirebaseFirestore dbref=FirebaseFirestore.instance;

  Future addDoc(String name)async{
    await dbref.collection('questions_data').doc(name).set({'name':name});
  }

  // Future add() async{
  //   int i=0;
  //   i=await countquestion(doc_name: '${foldername}').count_question();
  //   Map<String,dynamic>data={
  //     'id':i,
  //     'questions':'?????',
  //   };
  //   // await dbref.collection('questions').doc('${foldername}').collection('question').add(data);
  //   // await dbref.collection('questions').doc('${foldername}').collection('count').doc('question_count').update({'no':i+1});
  // }
}