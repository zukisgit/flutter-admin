import 'package:admin/packages/constants.dart';
import 'package:admin/services/add_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class questions extends StatefulWidget {
  @override
  _questionsState createState() => _questionsState();
}

class _questionsState extends State<questions> {
  Map passed_data={};
  @override
  Widget build(BuildContext context) {
    passed_data=ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      appBar: AppBar(
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
        title: Text(passed_data['title']),),
      body: Container(
        color: Colors.grey[300],
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('questions').doc(passed_data['title']).collection('question').snapshots(),
          builder: (context,snapshot){
            if(snapshot.data==null) return Center(child: CircularProgressIndicator());
            else{
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context,int index){
                  DocumentSnapshot ds=snapshot.data.documents[index];
                  // String text="${index}."+"${ds['question']}";
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(6, 2, 6, 0),
                    child: Column(
                      children: [
                        Card(
                          color: Colors.grey[400],
                          child:ListTile(
                            leading: Text("${index+1}",style: TextStyle(color: Colors.blue[800]),),
                            title: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child:Text(ds['question'])
                                ),
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        )
      )
    );
  }

  void choiceaction(String choice)async{
    if(choice==constants.add){
      print("add");
      // addquestion(question: "what is your name?",foldername: passed_data['title']).add(); 
      }else if(choice==constants.report){
        print('report');
        }
  }
}