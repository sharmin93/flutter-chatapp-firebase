import 'package:chat_app_using_firebase/views/users/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

import 'controller/user_list_controller.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController signInTextController = TextEditingController();

  SharedPreferences? prefs;
  String? prefData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UdText(
          text: 'LogIn',
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => UserListController(),
        child: Consumer<UserListController>(
          builder: (_, userListController, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(UdDesign.pt(16)),
                  child: SizedBox(
                    width: UdDesign.pt(300),
                    child: UdBasicTextInputField(
                      onChanged: (_) {},
                      controller: signInTextController,
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
                ),
                UdGapY(
                  value: 20,
                ),
                UdBasicButton(
                  title: 'save',
                  onTap: () {
                    //TODo
                    userListController.addUser(signInTextController.text);
                    addNamePref(signInTextController.text).then(
                      (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreen(
                              prefNameData: prefData,
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  addNamePref(String name) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString('name', name);
    return prefs;
  }
}
