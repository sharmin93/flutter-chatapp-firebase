import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';
import 'package:ud_widgets/widgets/cards/card.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final firebaseData = FirebaseDbData();
  UsersInfoModel? usersInfoModel;
  final MessageController messageController = MessageController();
  List userList = [
    'tom@flyhub.com',
    'figma@flyhub.com',
    'cheku@yopmail.com',
    'abc@yomail.com'
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UdAppBar(
        context: context,
        customLeft: UdTapper(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UdCard(
                paddingHorizontal: 0,
                paddingVertical: 0,
                height: UdDesign.pt(25),
                width: UdDesign.pt(25),
                borderColor: ProjectColors.transparent,
                borderRadius: UdDesign.pt(1),
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  color: ProjectColors.white,
                  size: UdDesign.pt(24),
                ),
              ),
              UdGapX(
                value: 4,
              ),
              UdText(
                text: 'Select Contact',
                color: ProjectColors.white,
                fontWeight: FontWeight.bold,
                fontSize: UdDesign.fontSize(16),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: userList.isNotEmpty
                  ? ChangeNotifierProvider(
                      create: (_) => MessageController(),
                      child: Consumer<MessageController>(
                        builder: (context, messageController, __) {
                          return ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  messageController.checkMessagesConversations(
                                      selectedUser: userList[index].toString(),
                                      context: context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(UdDesign.pt(8)),
                                  child: Row(
                                    children: [
                                      UdShape(
                                        size: UdDesign.pt(30),
                                        radius: UdDesign.pt(20),
                                        color: ProjectColors.blue,
                                        child: Icon(
                                          Icons.person_rounded,
                                          color: ProjectColors.white,
                                          size: UdDesign.pt(25),
                                        ),
                                      ),
                                      UdGapX(
                                        value: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UdText(
                                            text: userList[index]
                                                .toString()
                                                .split("@")[0]
                                                .replaceAll(".com", ""),
                                            color: ProjectColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: UdDesign.fontSize(14),
                                          ),
                                          UdGapY(
                                            value: 4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : const CircularProgressIndicator()),
        ],
      ),
    );
  }
}
