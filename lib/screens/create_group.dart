import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/custom_ui/avatar_card.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';

import '../custom_ui/contact_card.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Pradip Khandare", status: "Mobile app developer"),
    ChatModel(name: "Shreyash Jadhav", status: "Automation tester"),
    ChatModel(name: "Disha Gujarathi", status: "App developer"),
    ChatModel(name: "Akshay Borawake", status: "App Developer"),
    ChatModel(name: "Shubham Jawale", status: "App Developer"),
    ChatModel(name: "Nikhil Sawant", status: "App Developer"),
    ChatModel(name: "Viajay Gandhare", status: "App Developer"),
    ChatModel(name: "Suraj Kokare", status: "App Developer"),
    ChatModel(name: "Taylor Smith", status: "App Developer"),
    ChatModel(name: "Alex Johnson", status: "App Developer"),
    ChatModel(name: "Jordan Brown", status: "App Developer"),
    ChatModel(name: "Casey White", status: "App Developer"),
    ChatModel(name: "Morgan Lee", status: "App Developer"),
    ChatModel(name: "Jamie Davis", status: "App Developer"),
    ChatModel(name: "Chris Martinez", status: "App Developer"),
    ChatModel(name: "Avery Anderson", status: "App Developer"),
    ChatModel(name: "Parker Thomas", status: "App Developer"),
    ChatModel(name: "Riley Harris", status: "App Developer"),
    ChatModel(name: "Cameron Clark", status: "App Developer"),
    ChatModel(name: "Sydney Lewis", status: "App Developer"),
    ChatModel(name: "Dakota Young", status: "App Developer"),
    ChatModel(name: "Quinn King", status: "App Developer"),
    ChatModel(name: "Harper Scott", status: "App Developer"),
    ChatModel(name: "Alex Reed", status: "App Developer"),
  ];
  List<ChatModel> groups = [];

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
              "New group",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if(index == 0){
                return Container(
                  height: groups.length > 0 ? 90: 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (contacts[index - 1].select == false) {
                    setState(() {
                      contacts[index - 1].select = true;
                      groups.add(contacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      contacts[index].select = false;
                      groups.remove(contacts[index - 1]);
                    });
                  }
                },
                child: ContactCard(
                  contact: contacts[index - 1],
                ),
              );
            },
          ),
         groups.length > 0 ? Column(
            children: [
              Container(
                height: 75,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    if (contacts[index].select == true) {
                      return InkWell(
                        onTap: (){
                            setState(() {
                              groups.remove(contacts[index]);
                              contacts[index].select = false;
                            });
                        },
                        child: AvatarCard(
                          contact: contacts[index],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[100],
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
