import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'chatMessage.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat GPT'),
        leading: Image.asset("assets/images/op.jpg"),
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
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(
              textController: _controller,
              isComposing: true,
              handleSubmitted: (x){
                setState(() {
                   sendMessage(x!);
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
                    const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: isComposing
                  ? () => handleSubmitted(textController.text)
                  : null,
            ),
          ],
        )
);
  }




  // function API
  void sendMessage( message) async
  {
    final response = await sendRequest(message);
    if (response.statusCode == 200) {
      // Read the response
      final completions = json.decode(await response.transform(utf8.decoder).join())['choices'];

      // Print the completions
      for (var completion in completions) {
        //String valueCom = completion['text'];
        print(completion['text']);
        _messages.add(ChatMessage(text: completion['text'], sender: "GPT"));


      }
      setState(() {

      });
    } else {
      print("ERROR!!");
    }

  }




  static const apiKey = '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';

// Send a request to the OpenAI API to get completions from the GPT-3 model
  Future<HttpClientResponse> sendRequest(String prompt) async {
    final client = HttpClient();
    final request = await client.postUrl(Uri.parse('https://api.openai.com/v1/completions'));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer $apiKey');
    request.add(utf8.encode(json.encode({
      'model': 'text-davinci-002',
      'prompt': prompt,
      'max_tokens': 2048,
      'stop': '',
      'temperature': 0.7,
    })));
    final response = await request.close();
    return response;
  }

}
