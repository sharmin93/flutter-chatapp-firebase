import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app_using_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';
import '../../models/message_model.dart';
import '../../utilities/constants/colors.dart';
import '../../firebase_db_data.dart';
import '../../main.dart';

class MessagedUserList extends StatefulWidget {
  const MessagedUserList({Key? key}) : super(key: key);

  @override
  State<MessagedUserList> createState() => _MessagedUserListState();
}

class _MessagedUserListState extends State<MessagedUserList> {
  MessageController messageController = MessageController();
  final FirebaseDbData firebaseDbData = FirebaseDbData();

  @override
  void initState() {
    // firebaseDbData.inboxQueryMessage(userEmail);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: firebaseDbData.inboxQueryMessage(userEmail),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return const Text('error');
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          'value${snapshot.data?.docs[index].data().toString()}');
                      return UdText(
                          text: snapshot.data?.docs[index]
                              .data()['sender']
                              .toString());
                    },
                  );
                } else {
                  return UdText(
                    text: 'No user found',
                  );
                }
              }
            },
          ),
        ),
      ],
    );
    // return Scaffold(
    //   body:
    //   ChangeNotifierProvider(
    //     create: (_) => messageController,
    //     child: Consumer<MessageController>(
    //       builder: (_, messageController, __) {
    //         return Column(children: [
    //           Padding(
    //             padding: EdgeInsets.all(UdDesign.pt(8)),
    //             child: UdCard(
    //               backgroundColor: ProjectColors.grey40.withOpacity(0.2),
    //               disableShadow: true,
    //               paddingHorizontal: UdDesign.pt(16),
    //               paddingVertical: UdDesign.pt(16),
    //               borderRadius: UdDesign.pt(10),
    //               child: Row(
    //                 children: [
    //                   UdShape(
    //                     size: UdDesign.pt(30),
    //                     radius: UdDesign.pt(20),
    //                     color: ProjectColors.blue,
    //                     child: Icon(
    //                       Icons.person_rounded,
    //                       color: ProjectColors.white,
    //                       size: UdDesign.pt(25),
    //                     ),
    //                   ),
    //                   UdGapX(
    //                     value: 10,
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       UdText(text: 'userName'),
    //                       UdGapY(
    //                         value: 4,
    //                       ),
    //                       UdText(text: 'latest messages'),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ]);
    //       },
    //     ),
    //   ),
    // );
  }
}
