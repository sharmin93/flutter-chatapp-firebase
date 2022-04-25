import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/input/basic_text_input_field.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: UdDesign.pt(300),
                  child: UdBasicTextInputField(
                    onChanged: (_) {},
                    textInputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    controller: _messageTextController,
                    disableShadow: true,
                    borderColor: Colors.black,
                    borderRadius: UdDesign.pt(5),
                    borderWidth: UdDesign.pt(1),
                    width: double.infinity,
                    textAlignment: TextAlign.start,
                    padding: EdgeInsets.only(
                      left: UdDesign.pt(8),
                    ),
                    hintText: "Write something",
                    fontSize: UdDesign.fontSize(14),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                UdGapY(
                  value: 20,
                ),
                Icon(Icons.send_sharp)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
