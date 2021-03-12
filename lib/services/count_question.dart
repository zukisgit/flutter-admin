import 'package:admin/services/count_doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class countquestion{
  String doc_name;int count=0;
  countquestion({this.doc_name});

  Future count_question()async{
    Map<String,dynamic>data;
    DocumentSnapshot docsnap= await FirebaseFirestore.instance.collection('questions')
                                                              .doc('${doc_name}')
                                                              .collection('count')
                                                              .doc('question_count').get();
    data=docsnap.data();
    return data['no'];
  }

}