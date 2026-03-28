class Conversation {
  final String name;
  final String lastMessage;
  final String imageUrl;
  final String time;
  int unreadCount;
  Conversation({
    required this.name,
    required this.lastMessage,
    required this.imageUrl,
    required this.time,
    this.unreadCount = 0,
  });
}

class Message {
  final String text;
  final bool isMe;
  final DateTime time;
  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
}
