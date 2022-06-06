import 'package:chat_app/widgets/chats/messeges.dart';
import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyChat'),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemidentifier) {
              if (itemidentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Messeges(),
          ),
          NewMessage(),
        ],
        )
      ),
    );
  }
}
