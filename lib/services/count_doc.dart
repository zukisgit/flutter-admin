import 'package:cloud_firestore/cloud_firestore.dart';

class  count_doc{
  Future count_docs()async{
    Map<String,dynamic> data;
    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("count_folder").doc('count').get();
    data=snapshot.data();
    return data['folder_count'];
  }
}