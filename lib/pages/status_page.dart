import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/custom_ui/status_page/others_status.dart';

import '../custom_ui/status_page/head_own_status.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            onPressed: () {},
            child: Icon(
              Icons.camera_alt,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 10,),
            HeadOwnStatus(),
            label("Recent updates"),
            OthersStatus(
              name: "Shreyash Jadhav",
              imageName: "assets/2.jpeg",
              time: "16:01",
            ),
            OthersStatus(
              name: "Disha Gujrathi",
              imageName: "assets/3.jpg",
              time: "11:01",
            ),
            OthersStatus(
              name: "Vijay Tatya",
              imageName: "assets/1.jpg",
              time: "03:01",
            ),
            SizedBox(height: 10,),
            label("Viewd updates"),
            OthersStatus(
              name: "Shreyash Jadhav",
              imageName: "assets/2.jpeg",
              time: "16:01",
            ),
            OthersStatus(
              name: "Disha Gujrathi",
              imageName: "assets/3.jpg",
              time: "11:01",
            ),
            OthersStatus(
              name: "Vijay Tatya",
              imageName: "assets/1.jpg",
              time: "03:01",
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.grey[300],
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
