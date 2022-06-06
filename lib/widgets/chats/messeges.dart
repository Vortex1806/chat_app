import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Messeges extends StatelessWidget {
  const Messeges({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      // ignore: missing_return
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = chatSnapshot.data.docs;
        return ListView.builder(
          itemCount: documents.length,
          // ignore: missing_return
          itemBuilder: (context, index) => Text(documents[index]['text']),
        );
      },
    );
  }
}
