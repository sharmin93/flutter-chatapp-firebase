import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/buttons/udTapper.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/input/basic_text_input_field.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';
import '../../reusable/widgets/getMessagList.dart';

class ChatRoom extends StatefulWidget {
  final String? prefNameData;
  const ChatRoom({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageTextController = TextEditingController();
  final messagesData = FirebaseDbData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: ChangeNotifierProvider(
            create: (_) => MessageController(),
            child: Consumer<MessageController>(
              builder: (context, messageController, __) {
                return Column(
                  children: [
                    GetMessageList(prefNameData: widget.prefNameData),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: UdDesign.pt(300),
                          child: UdBasicTextInputField(
                            onChanged: (_) {},
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
                        UdTapper(
                          child: const Icon(Icons.send_sharp),
                          onTap: () {
                            messageController.sendMessages(
                                _messageTextController.text,
                                widget.prefNameData);
                            _messageTextController.clear();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
