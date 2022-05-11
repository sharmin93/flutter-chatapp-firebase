import 'package:chat_app_using_firebase/views/users/user_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_design/ud_design.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  SharedPreferences? prefs;
  bool check = false;
  String? prefData;
  @override
  void initState() {
    getPref().then((value) {
      if (value != null && value != '') {
        if (kDebugMode) {
          print('value$value');
        }
        check = true;
      }
    });
    super.initState();
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
    prefData = prefs?.get('name') as String?;
    return prefData;
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chat Group'),
        ),
        body: const UserScreen()

        ///previous views for group chat storing name to sharedPref///
        // check == true
        //     ? ChatRoom(prefNameData: prefData)
        //     : const UserScreen()
        );
  }
}
