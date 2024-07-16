import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/custom_ui/button_card.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';
import 'package:flutter_node_express_mongo/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;

  List<ChatModel> chatModels = [
    ChatModel(
        id: 1,
        name: "Pradip Khandare",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Hello Everyone!'),
    ChatModel(
        id: 2,
        name: "Shreyash Jadhav",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Chaha?'),
    ChatModel(
        id: 3,
        name: "Disha Gujrathi",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Khana khane chal'),
    ChatModel(
        id: 4,
        name: "Suraj Kokare",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Kay krtos?'),
    ChatModel(
        id: 5,
        name: "Shubham Jawale",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Akshya nhi aala ka?'),
    ChatModel(
        id: 6,
        name: "Rocksy",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Kalki dekha kya?')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  chatModels: chatModels,
                  sourceChat: sourceChat,
                ),
              ),
            );
          },
          child: ButtonCard(
            name: chatModels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
