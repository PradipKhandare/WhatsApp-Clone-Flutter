import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number, required this.countryCode});

  final String number;
  final String countryCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Verify +${widget.countryCode.substring(1)} ${widget.number}",
          style: TextStyle(color: Colors.teal[800], fontSize: 16.5),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent an SMS with a code to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: "+" +
                        widget.countryCode.substring(1) +
                        " " +
                        widget.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " Wrong number?",
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter 4 digit code",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            bottomButton("Resend message", Icons.message),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey[350],
            ),
            SizedBox(
              height: 12,
            ),
            bottomButton("Call me", Icons.phone),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData iconName) {
    return Row(
      children: [
        Icon(
          iconName,
          color: Colors.teal,
          size: 24,
        ),
        SizedBox(
          width: 25,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.cyan[800],
            fontSize: 14.5,
          ),
        ),
      ],
    );
  }
}
