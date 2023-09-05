import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FeedsPage extends StatelessWidget {
 FeedsPage({super.key});
  final ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Data")),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(child: FirebaseAnimatedList(query: ref, itemBuilder: (context,snapshot,animation,index)=>ListTile(
              title: Text(snapshot.child('name').value.toString()),
            )))
          ],
        ),
      ),
    );
  }
}
