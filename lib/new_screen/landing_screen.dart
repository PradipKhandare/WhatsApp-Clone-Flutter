import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/new_screen/login_page.dart';
import 'package:flutter_node_express_mongo/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome to whatsapp",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 29,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Image.asset(
                "assets/bg.png",
                color: Colors.greenAccent[700],
                height: 340,
                width: 340,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    children: [
                      TextSpan(
                        text: "Agree and continue to accept the",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const TextSpan(
                        text: " Whatsapp Terms of Service and Privacy Policy",
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginPage()),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 110,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: Colors.greenAccent[700],
                    elevation: 8,
                    child: const Center(
                      child: Text(
                        "AGREE AND CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
