import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/tdRbEX7AlqISl9KPXPdF/messages')
            .snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final documents = snapshot.data.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: ((context, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(documents[index]['text']),
                  )));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/tdRbEX7AlqISl9KPXPdF/messages')
              .add({'text': 'This was added By clicking the button'});
        },
      ),
    );
  }
}
