import 'package:admin/packages/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  dynamic data;

  Future<dynamic> getData() async {
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        actionsIconTheme: IconThemeData(
          color: Colors.amber
        ),
        title: Row(
          children: [
            Text("zuki is admin")
          ],
        ),
      ),
    );
  }
  void initState(){
    super.initState();
    getData();
  }
}