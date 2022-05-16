class UsersInfoModel {
  String? userEmailId;
  String? id;
  String? name;
  List<Conversation>? conversations;

  UsersInfoModel({this.userEmailId, this.id, this.name, this.conversations});

  UsersInfoModel.fromJson(Map<String, dynamic> json) {
    userEmailId = json['userEmailId'];
    id = json['id'];
    name = json['name'];
    if (json['conversations'] != null) {
      conversations = <Conversation>[];
      json['conversations'].forEach((v) {
        conversations!.add(Conversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userEmailId'] = userEmailId;
    data['id'] = id;
    data['name'] = name;
    if (conversations != null) {
      data['conversations'] = conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversation {
  String? otherEmailId;
  String? conversationId;
  String? conversationName;

  Conversation({this.otherEmailId, this.conversationId, this.conversationName});

  Conversation.fromJson(Map<String, dynamic> json) {
    otherEmailId = json['otherEmailId'];
    conversationId = json['conversationId'];
    conversationName = json['conversationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherEmailId'] = otherEmailId;
    data['conversationId'] = conversationId;
    data['conversationName'] = conversationName;
    return data;
  }
}
