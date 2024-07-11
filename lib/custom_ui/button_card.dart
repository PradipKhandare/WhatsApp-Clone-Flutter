import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  ButtonCard({super.key, this.name, this.icon});

  final String? name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFF25D366),
          radius: 23,
          child: Icon(icon, size: 26,),
        ),
        title: Text(
          name!,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
