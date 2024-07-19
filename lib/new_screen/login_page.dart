import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/model/country_model.dart';
import 'package:flutter_node_express_mongo/new_screen/otp_screen.dart';

import 'country_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "India";
  String countryCode = "+91";

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            wordSpacing: 1,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Colors.black),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'New group',
                    child: Text('New group'),
                  ),
                  PopupMenuItem(
                    value: 'New broadcast',
                    child: Text('New broadcast'),
                  ),
                  PopupMenuItem(
                    value: 'WhatsApp web',
                    child: Text('WhatsApp web'),
                  ),
                  PopupMenuItem(
                    value: 'Starred messages',
                    child: Text('Starred messages'),
                  ),
                  PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Whatsapp will send an SMS message to verify your numbner",
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "What's my number?",
              style: TextStyle(
                fontSize: 12.8,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            countryCard(),
            SizedBox(
              height: 5,
            ),
            number(),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                if (_textEditingController.text.length < 10) {
                  showAlertDilogueIfTextFieldIsEmpty();
                } else {
                  showAlertDilogue();
                }
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.tealAccent[400],
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => CountryPage(
              setCountryData: setCountryData,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  child: Center(
                child: Text(
                  countryName,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "+",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: TextFormField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: "Phone number",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Future<void> showAlertDilogue() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We will be verifying your phone number",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${countryCode} ${_textEditingController.text}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Is this ok, or would you like to edit the number?",
                  style: TextStyle(fontSize: 13.5),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Edit",
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => OtpScreen(
                      countryCode: countryCode,
                      number: _textEditingController.text,
                    ),
                  ),
                );
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlertDilogueIfTextFieldIsEmpty() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "There is no number you entered",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
