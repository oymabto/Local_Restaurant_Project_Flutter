/// Devin Oxman
/// This is the class to hold messages so that they can be passed to the MessageManagementCard to be displayed
class MessageData {
  MessageData({required String this.date,
    required bool this.isSeen,
    required String this.message
  });
  String date;
  bool isSeen;
  String message;
}