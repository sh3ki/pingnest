class Contact {
  final String id;
  final String name;
  final String initials;
  final String avatarUrl;
  final bool isGroup;
  final bool isOnline;
  final String status;
  final String phone;

  const Contact({
    required this.id,
    required this.name,
    required this.initials,
    required this.avatarUrl,
    this.isGroup = false,
    this.isOnline = false,
    this.status = '',
    this.phone = '',
  });
}

enum MessageType { text, image, audio, emoji }

class Message {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final DateTime timestamp;
  bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    this.type = MessageType.text,
    required this.timestamp,
    this.isRead = true,
  });
}

class Conversation {
  final String id;
  final Contact contact;
  final List<Message> messages;
  int unreadCount;

  Conversation({
    required this.id,
    required this.contact,
    required this.messages,
    this.unreadCount = 0,
  });

  Message? get lastMessage => messages.isNotEmpty ? messages.last : null;
}

class Story {
  final Contact contact;
  final String imageUrl;
  final DateTime timestamp;
  bool viewed;

  Story({
    required this.contact,
    required this.imageUrl,
    required this.timestamp,
    this.viewed = false,
  });
}
