
import 'package:admin/services/add_question.dart';
import 'package:admin/services/count_doc.dart';
import 'package:admin/services/delete_doc.dart';
import 'package:admin/services/delete_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin/packages/constants.dart';
import 'drawer.dart';

class folderList extends StatefulWidget {
  @override
  _folderListState createState() => _folderListState();
}

class _folderListState extends State<folderList> {
  List<String> folder=new List();int count;int count2;GlobalKey<FormState>_key=GlobalKey();
  TextEditingController controller=new TextEditingController();bool foldername_notexist=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.grey,
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceaction,
            itemBuilder: (context){
              return constants.choices.map((String choice){
                return PopupMenuItem(value: choice, child: Text(choice));
              }).toList();
            },
          ),
        ],
        title: Text("Folders List"),),
      body: Container(
        color: Colors.grey[300],
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('questions_data').snapshots(),
          builder: (context,snapshot){
            if(snapshot.data == null) return Center(child: CircularProgressIndicator());
            else{
              return new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Card(
                    color: Colors.grey[400],
                    child:ListTile(
                      onTap: (){
                        pass_folder_name(ds['folder_id'],ds['folder_name'],context);
                      },
                      leading: Icon(
                        Icons.folder,
                        color: Colors.yellow[800],
                        ),
                      title:Text(ds['name']),
                      trailing: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: FlatButton.icon(
                        onPressed: (){
                          delete_ui(ds['name']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                          ), label: Text(""),
                    ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
   void choiceaction(String choice)async{
    if(choice==constants.add){
      check_folder();
      add_ui();
    }else if(choice==constants.report){
      print('report');
    }
  }
  void pass_folder_name(id,name,context){
    Navigator.pushNamed(context, '/questions',arguments: {
      'title': name,
      'id':id
    });
  }
  void test_count()async{
    int i=0;
    i =await count_doc().count_docs();
    print(i);
  }
  Future check_folder()async{
    folder.clear();
    test_count();
    FirebaseFirestore.instance.collection("questions").get().then((QuerySnapshot snapshot){
      Map<String,dynamic>data;
      snapshot.docs.forEach((element) {
        data=element.data();
        folder.add(data['folder_name']);
      });
    });
  }
  void delete_ui(String name){
    showDialog(
      context: context,
      builder: (_)=>AlertDialog(
        title: Text("Are you sure to delete?"),
        actions:[
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("no") ,
            ),
            FlatButton(
              onPressed: ()async{
                await deletedoc().delete(name);
                Navigator.pop(context);
              }, 
              child: Text("yes"))
        ]
      )
      );
  }
  Future docCount(doc)async{
    List<DocumentSnapshot> count=new List();
    QuerySnapshot snapshot=await FirebaseFirestore.instance.collection(doc).get();
    count =snapshot.docs;
    return count.length;
  }
  void add_ui(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_)=>AlertDialog(
        title: Text("Enter folder's name"),
        content: Form(
          key: _key,
          child: TextFormField(
            controller: controller,
            validator: (String value){
              check_foldername_exist();
              if(!foldername_notexist){
                return "name already exists";
              }
              if(value.length==0){
                return "name can't be empty";
              }
            },
          ),
          ),
          actions: [
            FlatButton(
              onPressed: (){
                controller.clear();
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            FlatButton(
              onPressed: ()async{
                if(_key.currentState.validate()){
                  Navigator.pop(context);
                  await addquestion().addDoc("${controller.text}");
                  controller.clear();
                  await check_folder();
                }
              },
              child: Text("add"),
            )
          ],
      ),
    );
  }
  void check_foldername_exist()async{
    int count=0;
    for(int i=0;i<folder.length;i++){
      if(controller.text==folder[i]){
        count++;
      }
    }
    if(count==0){
      foldername_notexist=true;
    }else{
      foldername_notexist=false;
    }
  }
}