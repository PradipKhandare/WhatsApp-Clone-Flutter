import 'dart:io';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key, this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.crop_rotate,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: 27,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path!),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextFormField(
                  maxLines: 6,
                  minLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Add caption',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0), // Add some padding if needed
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.check, size: 18),
                        backgroundColor: Colors.tealAccent[700],
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8.0), // Add some padding if needed
                      child: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
