
import 'package:admin/packages/folderList.dart';
import 'package:admin/packages/home.dart';
import 'package:admin/packages/profile.dart';
import 'package:admin/packages/questions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=>home(),
      '/folders':(context)=>folderList(),
      '/profile':(context)=>profile(),
      '/questions':(context)=>questions()
    },
  ));
}
