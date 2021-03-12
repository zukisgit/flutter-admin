import 'package:cloud_firestore/cloud_firestore.dart';

class deletequestion{
  int id;
  deletequestion(this.id);
  delete_for_folder_delete(){
    FirebaseFirestore.instance.collection('questions')
                              .where("folder_id",isEqualTo:id)
                              .get()
                              .then((value) => value.docs.first.reference.delete());
  }
}