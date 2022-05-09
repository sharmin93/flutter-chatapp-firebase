import 'package:chat_app_using_firebase/ui/chat_room.dart';
import 'package:chat_app_using_firebase/ui/user_screen.dart';
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
  @override
  void initState() {
    getPref();
    super.initState();
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.get('name');
    check = true;
    return check;
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat app'),
        ),
        body: check == true ? const ChatRoom() : const UserScreen());
  }
}
