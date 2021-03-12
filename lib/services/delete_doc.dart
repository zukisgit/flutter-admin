import 'package:cloud_firestore/cloud_firestore.dart';

class deletedoc{

  Future delete(String docid){
    FirebaseFirestore.instance.collection("questions_data").doc(docid).delete();
  }
}