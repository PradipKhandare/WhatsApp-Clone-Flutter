import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/custom_ui/button_card.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';

import '../custom_ui/contact_card.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(name: "Pradip Khandare", status: "Mobile app developer"),
    ChatModel(name: "Shreyash Jadhav", status: "Automation tester"),
    ChatModel(name: "Disha Gujarathi", status: "App developer"),
    ChatModel(name: "Akshay Borawake", status: "App Developer"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select contact",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "280 contacts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 26,
              color: Colors.white,
            ),
          ),
          IconTheme(
            data: IconThemeData(
              color: Colors.white,
            ),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Invite a friend',
                    child: Text('Invite a friend'),
                  ),
                  PopupMenuItem(
                    value: 'Contacts',
                    child: Text('Contacts'),
                  ),
                  PopupMenuItem(
                    value: 'Refresh',
                    child: Text('Refresh'),
                  ),
                  PopupMenuItem(
                    value: 'Help',
                    child: Text('Help'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ButtonCard(icon: Icons.group, name: 'New group');
            } else if (index == 1) {
              return ButtonCard(icon: Icons.person, name: 'New contact');
            }
            return ContactCard(contact: contacts[index - 2]);
          }),
    );
  }
}
