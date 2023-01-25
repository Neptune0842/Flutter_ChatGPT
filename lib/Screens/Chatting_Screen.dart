import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});



  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {

  static const apiKey = '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';
  Future<HttpClientResponse> sendRequest(String prompt) async {
    final client = HttpClient();
    final request = await client
        .postUrl(Uri.parse('https://api.openai.com/v1/completions'));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer $apiKey');
    request.add(utf8.encode(json.encode({
      'model': 'text-davinci-003',
      'prompt': prompt,
      'max_tokens': 2048,
      'stop': '',
      'temperature': 0.7,
    })));
    final response = await request.close();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }

}