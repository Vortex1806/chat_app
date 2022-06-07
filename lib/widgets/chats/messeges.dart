import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messeges extends StatelessWidget {
  const Messeges({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      // ignore: missing_return
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = chatSnapshot.data.docs;
        User currentuser = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          // ignore: missing_return
          itemBuilder: (context, index) => MessageBubble(
            documents[index]['text'],
            documents[index]['userId'] == currentuser.uid,
            documents[index]['username'],
            documents[index]['image_url'],
            key: ValueKey(
              //taken id
              documents[index].id,
            ),
          ),
        );
      },
    );
  }
}
