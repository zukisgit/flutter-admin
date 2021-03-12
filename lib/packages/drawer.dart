import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: ListView(
          children: [
            new DrawerHeader(
              child:Text("my drawer header"),
              decoration: new BoxDecoration(
               color: Colors.grey[400]
              )
            ),
            new ListTile(
              title:Text('profile'),
              onTap:(){
                Navigator.pushNamed(context, '/profile');
              }
            ),
            new ListTile(
              title:Text('Question Folders List'),
              onTap:(){
                Navigator.pushNamed(context, '/folders');
              }
            )
          ],
        ),
      );
  }
}