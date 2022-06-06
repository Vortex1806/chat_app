import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              label: Text('Send Message...'),
            ),
            onChanged: (value) {
              _enteredMessage = value;
            },
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : () {},
          icon: const Icon(Icons.send),
          color: Theme.of(context).primaryColor,
        )
      ]),
    );
  }
}
