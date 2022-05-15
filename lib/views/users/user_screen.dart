import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:chat_app_using_firebase/views/users/user_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

import '../../controller/user_list_controller.dart';
import '../../firebase_db_data.dart';

class UserScreen extends StatefulWidget {
  final String? prefNameData;
  const UserScreen({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                    text: widget.prefNameData.toString().toUpperCase(),
                    color: ProjectColors.black,
                    fontSize: UdDesign.fontSize(14),
                  ),
                  UdGapY(
                    value: 10,
                  ),
                  UserListScreen(prefNameData: widget.prefNameData,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: UdDesign.pt(300),
                        child: UdBasicTextInputField(
                          onChanged: (_) {},
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
                          hintText: "Write your email",
                          fontSize: UdDesign.fontSize(14),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      UdGapY(
                        value: 20,
                      ),
                      UdTapper(
                        child: const Icon(Icons.add_circle_outline),
                        onTap: () {
                          userListController.getUserInfo(_textController.text,widget.prefNameData);
                          _textController.clear();
                        },
                      ),
                    ],
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
