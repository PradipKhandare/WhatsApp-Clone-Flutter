import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  const OwnFileCard({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5,),
        child: Container(
          height: MediaQuery.of(context).size.height/2.3,
          width: MediaQuery.of(context).size.width/1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green[300],
          ),
          child: Card(
            margin: EdgeInsets.all(3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
            child: Image.file(File(path)),
          ),
        ),
      ),
    );
  }
}
