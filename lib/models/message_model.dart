class MessageModel{
  String? dateTime;
  String? receiverId;
  String? senderId;
  String? text;

  MessageModel({
    this.dateTime,
    this.receiverId,
    this.senderId,
    this.text
  });

  MessageModel.fromjson(Map<String,dynamic> json){
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
  }

  Map<String,dynamic> toMap(){
    return{
      'dateTime':dateTime,
      'receiverId':receiverId,
      'senderId':senderId,
      'text':text
    };
  }


}