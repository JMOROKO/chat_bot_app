import 'package:chat_bot_app/chatbot.page.dart';
import 'package:chat_bot_app/home.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        indicatorColor: Colors.white,
      ),
      home: HomePage(),
      //c'est ici que sont créé toutes les routes de l'application
      routes: {
        "/chat": (context) => ChatBotPage(),
      },
    );
  }
}
