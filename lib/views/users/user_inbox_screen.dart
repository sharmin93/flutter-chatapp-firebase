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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UdCard(
              backgroundColor: Colors.blue,
              shadowOffset: const Offset(0, -1),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UdGapY(
                    value: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          UdShape(
                            size: UdDesign.pt(30),
                            radius: UdDesign.pt(20),
                            color: ProjectColors.white,
                            child: Icon(
                              Icons.person_rounded,
                              color: ProjectColors.blue,
                              size: UdDesign.pt(25),
                            ),
                          ),
                          UdGapX(
                            value: 8,
                          ),
                          UdText(
                            text: userEmail,
                            color: ProjectColors.white,
                            fontSize: UdDesign.fontSize(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserListScreen()),
                          );
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: UdDesign.pt(30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UdGapY(
              value: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: UdDesign.pt(10), top: UdDesign.pt(10)),
              child: UdText(
                text: 'Messages',
                fontSize: UdDesign.fontSize(18),
                color: ProjectColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            UdGapY(
              value: 10,
            ),
            const Expanded(
              child: MessagedUserList(),
            ),
          ],
        ),
      ),
    );
  }
}
