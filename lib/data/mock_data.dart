import '../models/chat_model.dart';

class MockData {
  MockData._();

  static const String kSelfId = 'self';

  static final List<Contact> contacts = [
    const Contact(id: 'c1', name: 'Alice Morgan', avatar: '👩', isOnline: true, status: 'Coffee & code ☕', phone: '+1 555-0101'),
    const Contact(id: 'c2', name: 'Ben Carter', avatar: '👨', isOnline: false, status: 'At the gym 💪', phone: '+1 555-0102'),
    const Contact(id: 'c3', name: 'Chloe Kim', avatar: '🧑', isOnline: true, status: 'Reading 📚', phone: '+1 555-0103'),
    const Contact(id: 'c4', name: 'Daniel Park', avatar: '👦', isOnline: false, status: 'Out for a run 🏃', phone: '+1 555-0104'),
    const Contact(id: 'c5', name: 'Emma Davis', avatar: '👩‍💼', isOnline: true, status: 'Working from home', phone: '+1 555-0105'),
    const Contact(id: 'c6', name: 'Frank Ortiz', avatar: '👨‍🍳', isOnline: false, status: 'Cooking something 🍳', phone: '+1 555-0106'),
    const Contact(id: 'c7', name: 'Grace Lee', avatar: '🙋', isOnline: true, status: 'Painting 🎨', phone: '+1 555-0107'),
    const Contact(id: 'c8', name: 'Hiro Tanaka', avatar: '🧑‍💻', isOnline: false, status: 'Busy with meetings', phone: '+1 555-0108'),
    const Contact(id: 'c9', name: 'Iris Wilson', avatar: '👩‍🎤', isOnline: true, status: 'On a walk 🌿', phone: '+1 555-0109'),
    const Contact(id: 'c10', name: 'Jake Smith', avatar: '🧔', isOnline: false, status: 'Sleeping 😴', phone: '+1 555-0110'),
  ];

  static DateTime _ago({int h = 0, int m = 0, int s = 0}) =>
      DateTime.now().subtract(Duration(hours: h, minutes: m, seconds: s));

  static final List<Conversation> conversations = [
    Conversation(
      id: 'conv1',
      contact: contacts[0],
      unreadCount: 2,
      messages: [
        Message(id: 'msg1', senderId: 'c1', text: 'Hey! Are you free tonight?', timestamp: _ago(h: 2, m: 30)),
        Message(id: 'msg2', senderId: kSelfId, text: 'Yes! Was thinking about dinner 🍕', timestamp: _ago(h: 2, m: 28)),
        Message(id: 'msg3', senderId: 'c1', text: 'Perfect, 7pm at Rosario?', timestamp: _ago(h: 2, m: 25)),
        Message(id: 'msg4', senderId: kSelfId, text: 'Sounds great! See you there 🎉', timestamp: _ago(h: 2, m: 20)),
        Message(id: 'msg5', senderId: 'c1', text: 'Can you bring the board game?', timestamp: _ago(m: 45), isRead: false),
        Message(id: 'msg6', senderId: 'c1', text: 'The new one we bought 😄', timestamp: _ago(m: 44), isRead: false),
      ],
    ),
    Conversation(
      id: 'conv2',
      contact: contacts[1],
      unreadCount: 0,
      messages: [
        Message(id: 'msg7', senderId: kSelfId, text: 'How was the gym session?', timestamp: _ago(h: 1, m: 10)),
        Message(id: 'msg8', senderId: 'c2', text: 'Brutal but great 💪 PR on bench press!', timestamp: _ago(h: 1, m: 5)),
        Message(id: 'msg9', senderId: kSelfId, text: 'Nice!! What weight?', timestamp: _ago(h: 1)),
        Message(id: 'msg10', senderId: 'c2', text: '100kg! First time ever 🏆', timestamp: _ago(m: 58)),
      ],
    ),
    Conversation(
      id: 'conv3',
      contact: contacts[2],
      unreadCount: 1,
      messages: [
        Message(id: 'msg11', senderId: 'c3', text: 'Did you see the new Netflix series?', timestamp: _ago(h: 3)),
        Message(id: 'msg12', senderId: kSelfId, text: 'Not yet, is it good?', timestamp: _ago(h: 2, m: 55)),
        Message(id: 'msg13', senderId: 'c3', text: "It's absolutely amazing! Top tier storytelling 📺", timestamp: _ago(m: 20), isRead: false),
      ],
    ),
    Conversation(
      id: 'conv4',
      contact: contacts[3],
      unreadCount: 0,
      messages: [
        Message(id: 'msg14', senderId: 'c4', text: 'Morning run done! 5k in 22 min 🏃', timestamp: _ago(h: 5)),
        Message(id: 'msg15', senderId: kSelfId, text: 'That is impressive! I need to start running again 😅', timestamp: _ago(h: 4, m: 50)),
        Message(id: 'msg16', senderId: 'c4', text: 'Join me tomorrow morning!', timestamp: _ago(h: 4, m: 45)),
      ],
    ),
    Conversation(
      id: 'conv5',
      contact: contacts[4],
      unreadCount: 3,
      messages: [
        Message(id: 'msg17', senderId: kSelfId, text: 'Can you review my PR?', timestamp: _ago(h: 6)),
        Message(id: 'msg18', senderId: 'c5', text: 'Sure! I will take a look in a bit', timestamp: _ago(h: 5, m: 50)),
        Message(id: 'msg19', senderId: 'c5', text: 'Left some comments, mostly minor', timestamp: _ago(h: 1, m: 30), isRead: false),
        Message(id: 'msg20', senderId: 'c5', text: 'One thing about the API layer though', timestamp: _ago(h: 1, m: 29), isRead: false),
        Message(id: 'msg21', senderId: 'c5', text: 'Let me know if you want to hop on a call', timestamp: _ago(m: 10), isRead: false),
      ],
    ),
    Conversation(
      id: 'conv6',
      contact: contacts[5],
      unreadCount: 0,
      messages: [
        Message(id: 'msg22', senderId: 'c6', text: 'Made pasta tonight 🍝', timestamp: _ago(h: 8)),
        Message(id: 'msg23', senderId: kSelfId, text: 'Jealous! Send the recipe', timestamp: _ago(h: 7, m: 55)),
        Message(id: 'msg24', senderId: 'c6', text: 'Sending now...', timestamp: _ago(h: 7, m: 50)),
      ],
    ),
  ];

  static final List<Story> stories = [
    Story(contact: contacts[0], emoji: '☕', caption: 'Morning vibes!', timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    Story(contact: contacts[2], emoji: '📚', caption: 'Deep into a great book', timestamp: DateTime.now().subtract(const Duration(hours: 2)), viewed: true),
    Story(contact: contacts[4], emoji: '💻', caption: 'Working remotely today', timestamp: DateTime.now().subtract(const Duration(hours: 3))),
    Story(contact: contacts[6], emoji: '🎨', caption: 'New painting in progress!', timestamp: DateTime.now().subtract(const Duration(hours: 4))),
    Story(contact: contacts[8], emoji: '🌿', caption: 'Nature walk 🍃', timestamp: DateTime.now().subtract(const Duration(hours: 5)), viewed: true),
  ];
}
