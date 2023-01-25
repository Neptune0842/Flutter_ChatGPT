import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;

  const ChatMessage({super.key, required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(sender[0]),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            Container(
              width: 280,
              child: Text(text,
                 ),
            ),

              // Container(
              //   margin: const EdgeInsets.only(top: 5.0),
              //    child: Text(text,
              //   maxLines: 2,overflow: TextOverflow.fade),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}