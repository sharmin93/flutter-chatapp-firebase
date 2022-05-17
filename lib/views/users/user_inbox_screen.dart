import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:chat_app_using_firebase/views/users/user_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

import '../../main.dart';
import '../messages/messaged_user_list.dart';

class UserInboxScreen extends StatefulWidget {
  const UserInboxScreen({Key? key}) : super(key: key);

  @override
  State<UserInboxScreen> createState() => _UserInboxScreenState();
}

class _UserInboxScreenState extends State<UserInboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UdGapY(
              value: 40,
            ),
            UdText(
              text: 'Chat',
              fontSize: UdDesign.fontSize(16),
              color: ProjectColors.blue,
            ),
            UdGapY(
              value: 8,
            ),
            UdCard(
              backgroundColor: ProjectColors.grey40.withOpacity(0.2),
              disableShadow: true,
              paddingHorizontal: UdDesign.pt(16),
              paddingVertical: UdDesign.pt(16),
              borderRadius: UdDesign.pt(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UdText(
                    text: userEmail,
                    color: ProjectColors.black,
                    fontSize: UdDesign.fontSize(14),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserListScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            UdGapY(
              value: 10,
            ),
            const Expanded(child: MessagedUserList()),
          ],
        ),
      ),
    );
  }
}
