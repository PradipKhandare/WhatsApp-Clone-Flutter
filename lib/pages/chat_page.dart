import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';
import 'package:flutter_node_express_mongo/custom_ui/custom_card.dart';
import 'package:flutter_node_express_mongo/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.chatModels, this.sourceChat});
  final List<ChatModel>? chatModels;
  final ChatModel? sourceChat;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

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
        itemCount: widget.chatModels!.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatModels![index], sourceChat: widget.sourceChat!,
        ),
      ),
    );
  }
}
