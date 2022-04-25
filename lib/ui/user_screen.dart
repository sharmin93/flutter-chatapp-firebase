import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/buttons/basic_button.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/input/basic_text_input_field.dart';

import 'chat_room.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _textController = TextEditingController();
  late final SharedPreferences prefs;
  final firebaseDB = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: Column(
          children: [
            UdBasicTextInputField(
              onChanged: (_) {},
              textInputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: _textController,
              disableShadow: true,
              borderColor: Colors.black,
              borderRadius: UdDesign.pt(5),
              borderWidth: UdDesign.pt(1),
              width: double.infinity,
              textAlignment: TextAlign.start,
              padding: EdgeInsets.only(
                left: UdDesign.pt(8),
              ),
              hintText: "Write your name",
              fontSize: UdDesign.fontSize(14),
              fontWeight: FontWeight.normal,
            ),
            UdGapY(
              value: 20,
            ),
            UdBasicButton(
              onTap: () {
                addName(_textController.text);
                firebaseDB
                    .collection('userName')
                    .add({'name': _textController.text});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatRoom()),
                );
              },
              width: double.infinity,
              backgroundColor: Colors.blue,
              borderRadius: UdDesign.pt(4),
              height: UdDesign.pt(48),
              title: "Submit request",
              titleFontSize: UdDesign.fontSize(16),
            ),
          ],
        ),
      ),
    );
  }

  addName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }
}
