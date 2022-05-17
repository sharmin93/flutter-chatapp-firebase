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
  List userList = ['fly.com', 'fig.com', 'check.com', 'abc.com'];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: UdText(
          text: 'Contact List',
          color: ProjectColors.white,
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
                                  child: UdCard(
                                    backgroundColor:
                                        ProjectColors.grey40.withOpacity(0.2),
                                    disableShadow: true,
                                    paddingHorizontal: UdDesign.pt(16),
                                    paddingVertical: UdDesign.pt(16),
                                    borderRadius: UdDesign.pt(10),
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
                                                    .replaceAll(".com", '')),
                                            UdGapY(
                                              value: 4,
                                            ),
                                            UdText(
                                                text:
                                                    userList[index].toString()),
                                          ],
                                        ),
                                      ],
                                    ),
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
