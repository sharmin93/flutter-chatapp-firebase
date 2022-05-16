import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:chat_app_using_firebase/views/users/user_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

import '../../controller/user_list_controller.dart';
import '../../firebase_db_data.dart';

class UserDummyScreen extends StatefulWidget {
  final String? prefNameData;
  const UserDummyScreen({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<UserDummyScreen> createState() => _UserDummyScreenState();
}

class _UserDummyScreenState extends State<UserDummyScreen> {
  final TextEditingController _textController = TextEditingController();
  final userInfoData = FirebaseDbData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: ChangeNotifierProvider(
          create: (_) => UserListController(),
          child: Consumer<UserListController>(
            builder: (context, userListController, __) {
              return Column(
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
                  UdText(
                    text: widget.prefNameData.toString(),
                    color: ProjectColors.black,
                    fontSize: UdDesign.fontSize(14),
                  ),
                  UdGapY(
                    value: 10,
                  ),
                  UserListScreen(
                    prefNameData: widget.prefNameData,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

// addNamePref(String name) async {
//   prefs = await SharedPreferences.getInstance();
//   prefs?.setString('name', name);
// }

}
