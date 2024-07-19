

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/new_screen/landing_screen.dart';
import 'package:flutter_node_express_mongo/screens/camera_screen.dart';
import 'package:flutter_node_express_mongo/screens/home_screen.dart';
import 'package:flutter_node_express_mongo/screens/login_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF128C7E),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

