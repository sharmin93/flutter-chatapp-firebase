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
        conversations!.add(new Conversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userEmailId'] = this.userEmailId;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversation {
  String? otherEmailId;
  String? conversationId;
  String? conversationName;

  Conversation(
      {this.otherEmailId, this.conversationId, this.conversationName});

  Conversation.fromJson(Map<String, dynamic> json) {
    otherEmailId = json['otherEmailId'];
    conversationId = json['conversationId'];
    conversationName = json['conversationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherEmailId'] = this.otherEmailId;
    data['conversationId'] = this.conversationId;
    data['conversationName'] = this.conversationName;
    return data;
  }
}