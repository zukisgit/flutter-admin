import 'package:cloud_firestore/cloud_firestore.dart';

class updatecount{
  int current_count;
  updatecount({this.current_count});
  Future update(){
    FirebaseFirestore.instance.collection("count_folder").doc('count').update({'folder_count':current_count+1});
  }
}