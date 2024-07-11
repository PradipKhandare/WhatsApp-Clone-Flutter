import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';
import 'package:flutter_node_express_mongo/custom_ui/custom_card.dart';
import 'package:flutter_node_express_mongo/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Pradip Khandare",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Hello Everyone!'),
    ChatModel(
        name: "Shreyash Jadhav",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Chaha?'),
    ChatModel(
        name: "Disha Gujarathi",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Khana khane chal'),
    ChatModel(
        name: "Suraj Kokare",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Kay krtos?'),
    ChatModel(
        name: "AppDev-NTS",
        icon: "assets/person.svg",
        isGroup: true,
        time: "9.00",
        currentMessage: 'Hello team, doing wfh today'),
    ChatModel(
        name: "Shubham Jawale",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Akshya nhi aala ka?'),
    ChatModel(
        name: "Rocksy",
        icon: "assets/person.svg",
        isGroup: false,
        time: "4.00",
        currentMessage: 'Kalki dekha kya?')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectContact(),),);
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
    );
  }
}
