import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget
{
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
{
  @override
  Widget build(BuildContext context)
  {

    return Scaffold
      (
      appBar: AppBar
        (

        title: const Text
          (
          "Welcome... 😉!",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column
        (
        children:
        [
          const SizedBox
            (
            height: 30,
          ),
          Container
            (
            padding: const EdgeInsets.all(10),
            child: ClipRRect
              (
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("assets/images/ChatBot_MainScreen.jpg"),
            ),
          ),
          const SizedBox
            (
            height: 10,
          ),
      Column
        (
        children:
        [
          const Text("Whatever You will Ask, You'll get an Answer"),
          const SizedBox
            (
            height: 100,
          ),
        ],
      ),
    );
  }
}