import 'package:flutter/material.dart';
import 'package:untitled1/Chat_message.dart'
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


  void sendMessage(message) async {
    final response = await sendRequest(message);
    if (response.statusCode == 200) {
      final completions =
      json.decode(await response.transform(utf8.decoder).join())['choices'];
      for (var completion in completions) {
        print(completion['text']);
        _messages.insert(
            0, ChatMessage(text: completion['text'], sender: "OpenAI"));
      }
      setState(() {});
    } else {
      print("Error Here!");
    }
  }

  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Pro🤖Bot"),
        leading: Image.asset("assets/images/ChatGPT_Icon.png"),
      ),
      body: Column(
        children: <Widget>[

          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (_, index) {
                return _messages[index];
              },
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0, color: Colors.blue, thickness: 3),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(
              textController: _controller,
              isComposing: true,
              handleSubmitted: (x) {
                setState(() {
                  sendUser(x!);
                });
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer({
    required TextEditingController textController,
    required bool isComposing,
    required Function? Function(String? x) handleSubmitted,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  setState(() {
                    isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: handleSubmitted,
                decoration:
                const InputDecoration.collapsed(hintText: 'Ask me!'),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.blue,
              ),
              onPressed: isComposing
                  ? () => handleSubmitted(textController.text)
                  : null,
            ),
          ],
        ));
  }
}