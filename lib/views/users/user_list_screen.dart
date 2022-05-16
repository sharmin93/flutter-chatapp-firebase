import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:flutter/material.dart';

import '../../firebase_db_data.dart';
import '../../main.dart';
import '../messages/chat_room.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final firebaseData = FirebaseDbData();
  UsersInfoModel? usersInfoModel;
  List userList = ['fly.com', 'fig.com', 'check.com'];

  @override
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: userList != null
            ? ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Text(userList[index].toString()),
                        onTap: () {
                          firebaseData
                              .getConversationId(
                                  userEmail, userList[index].toString())
                              .then((value) {
                            if (value == null) {
                              firebaseData
                                  .createConversation(
                                      userEmail, userList[index].toString())
                                  .then((createValue) {
                                if (createValue != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                        conversationId: createValue,
                                      ),
                                    ),
                                  );
                                }
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    conversationId: value,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ],
                  );
                })
            : const CircularProgressIndicator());
    // FirebaseAnimatedList(
    //   query: userInfoData.getOwnUser(),
    //   itemBuilder: (context, snapshot, animation, index) {
    //     final json = snapshot.value as Map<dynamic, dynamic>;
    //     final userInfoData = UsersInfoModel.fromJson(json);
    //     return UserListBody(
    //         userInfo: userInfoData, prefNameData: widget.prefNameData);
    //   },
    // ),
    // );
  }
}
