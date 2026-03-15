import '../models/chat_model.dart';

class ChatData {
  ChatData._();

  static const String kSelfId = 'self';
  static const String selfName = 'Miguel Santos';
  static const String selfStatus = 'Quezon City, Philippines';
  static const String selfProfileImageUrl = 'assets/images/profiles/self.jpg';

  static final List<Contact> contacts = [
    const Contact(
      id: 'c1',
      name: 'Alyssa Reyes',
      initials: 'AR',
      avatarUrl: 'assets/images/profiles/c1.jpg',
      isOnline: true,
      status: 'Makati coffee crawl',
      phone: '+63 917 100 1001',
    ),
    const Contact(
      id: 'c2',
      name: 'Paolo Dela Cruz',
      initials: 'PD',
      avatarUrl: 'assets/images/profiles/c2.jpg',
      isOnline: false,
      status: 'Leg day done',
      phone: '+63 917 100 1002',
    ),
    const Contact(
      id: 'c3',
      name: 'Bianca Villanueva',
      initials: 'BV',
      avatarUrl: 'assets/images/profiles/c3.jpg',
      isOnline: true,
      status: 'Book fair weekend',
      phone: '+63 917 100 1003',
    ),
    const Contact(
      id: 'c4',
      name: 'Ethan Navarro',
      initials: 'EN',
      avatarUrl: 'assets/images/profiles/c4.jpg',
      isOnline: false,
      status: 'BGC run club',
      phone: '+63 917 100 1004',
    ),
    const Contact(
      id: 'c5',
      name: 'Camille Mercado',
      initials: 'CM',
      avatarUrl: 'assets/images/profiles/c5.jpg',
      isOnline: true,
      status: 'Remote in Cebu',
      phone: '+63 917 100 1005',
    ),
    const Contact(
      id: 'c6',
      name: 'Noah Bautista',
      initials: 'NB',
      avatarUrl: 'assets/images/profiles/c6.jpg',
      isOnline: false,
      status: 'Trying adobo recipes',
      phone: '+63 917 100 1006',
    ),
    const Contact(
      id: 'c7',
      name: 'Jasmine Flores',
      initials: 'JF',
      avatarUrl: 'assets/images/profiles/c7.jpg',
      isOnline: true,
      status: 'Sketching in UP Diliman',
      phone: '+63 917 100 1007',
    ),
    const Contact(
      id: 'c8',
      name: 'Lucas Tan',
      initials: 'LT',
      avatarUrl: 'assets/images/profiles/c8.jpg',
      isOnline: false,
      status: 'Client calls all day',
      phone: '+63 917 100 1008',
    ),
    const Contact(
      id: 'c9',
      name: 'Mika Gonzales',
      initials: 'MG',
      avatarUrl: 'assets/images/profiles/c9.jpg',
      isOnline: true,
      status: 'Sunset walk at Manila Bay',
      phone: '+63 917 100 1009',
    ),
    const Contact(
      id: 'c10',
      name: 'Andre Lim',
      initials: 'AL',
      avatarUrl: 'assets/images/profiles/c10.jpg',
      isOnline: false,
      status: 'Battery at 2 percent',
      phone: '+63 917 100 1010',
    ),
    const Contact(
      id: 'g1',
      name: 'Barkada Weekend Ride',
      initials: 'BR',
      avatarUrl: 'assets/images/profiles/g1.jpg',
      isGroup: true,
      isOnline: true,
      status: '7 members',
    ),
    const Contact(
      id: 'g2',
      name: 'Team Halo-Halo',
      initials: 'TH',
      avatarUrl: 'assets/images/profiles/g2.jpg',
      isGroup: true,
      isOnline: true,
      status: '5 members',
    ),
    const Contact(
      id: 'g3',
      name: 'Barangay Basketball',
      initials: 'BB',
      avatarUrl: 'assets/images/profiles/g3.jpg',
      isGroup: true,
      isOnline: false,
      status: '12 members',
    ),
  ];

  static DateTime _ago({int h = 0, int m = 0, int s = 0}) =>
      DateTime.now().subtract(Duration(hours: h, minutes: m, seconds: s));

  static final List<Conversation> conversations = [
    Conversation(
      id: 'conv1',
      contact: contacts[0],
      unreadCount: 2,
      messages: [
        Message(
            id: 'msg1',
            senderId: 'c1',
            text: 'Uy free ka tonight?',
            timestamp: _ago(h: 2, m: 30)),
        Message(
            id: 'msg2',
            senderId: kSelfId,
            text: 'Game! Dinner tayo?',
            timestamp: _ago(h: 2, m: 28)),
        Message(
            id: 'msg3',
            senderId: 'c1',
            text: '7pm sa Kapitolyo?',
            timestamp: _ago(h: 2, m: 25)),
        Message(
            id: 'msg4',
            senderId: kSelfId,
            text: 'Sige, see you!',
            timestamp: _ago(h: 2, m: 20)),
        Message(
            id: 'msg5',
            senderId: 'c1',
            text: 'Pakidala yung card game',
            timestamp: _ago(m: 45),
            isRead: false),
        Message(
            id: 'msg6',
            senderId: 'c1',
            text: 'Yung bago natin binili',
            timestamp: _ago(m: 44),
            isRead: false),
      ],
    ),
    Conversation(
      id: 'conv2',
      contact: contacts[1],
      unreadCount: 0,
      messages: [
        Message(
            id: 'msg7',
            senderId: kSelfId,
            text: 'Kamusta workout?',
            timestamp: _ago(h: 1, m: 10)),
        Message(
            id: 'msg8',
            senderId: 'c2',
            text: 'Solid! New PR sa bench',
            timestamp: _ago(h: 1, m: 5)),
        Message(
            id: 'msg9',
            senderId: kSelfId,
            text: 'Ilang kilos?',
            timestamp: _ago(h: 1)),
        Message(
            id: 'msg10',
            senderId: 'c2',
            text: '100kg bro',
            timestamp: _ago(m: 58)),
      ],
    ),
    Conversation(
      id: 'conv3',
      contact: contacts[2],
      unreadCount: 1,
      messages: [
        Message(
            id: 'msg11',
            senderId: 'c3',
            text: 'May bagong series sa Netflix!',
            timestamp: _ago(h: 3)),
        Message(
            id: 'msg12',
            senderId: kSelfId,
            text: 'Worth it ba?',
            timestamp: _ago(h: 2, m: 55)),
        Message(
            id: 'msg13',
            senderId: 'c3',
            text: 'Super worth it, binge mo na',
            timestamp: _ago(m: 20),
            isRead: false),
      ],
    ),
    Conversation(
      id: 'conv4',
      contact: contacts[3],
      unreadCount: 0,
      messages: [
        Message(
            id: 'msg14',
            senderId: 'c4',
            text: '5k done sa BGC!',
            timestamp: _ago(h: 5)),
        Message(
            id: 'msg15',
            senderId: kSelfId,
            text: 'Ang bilis mo na',
            timestamp: _ago(h: 4, m: 50)),
        Message(
            id: 'msg16',
            senderId: 'c4',
            text: 'Sama ka bukas 6am',
            timestamp: _ago(h: 4, m: 45)),
      ],
    ),
    Conversation(
      id: 'conv5',
      contact: contacts[4],
      unreadCount: 3,
      messages: [
        Message(
            id: 'msg17',
            senderId: kSelfId,
            text: 'Pwede pa-review ng PR?',
            timestamp: _ago(h: 6)),
        Message(
            id: 'msg18',
            senderId: 'c5',
            text: 'Sure, after lunch',
            timestamp: _ago(h: 5, m: 50)),
        Message(
            id: 'msg19',
            senderId: 'c5',
            text: 'Naglagay ako comments',
            timestamp: _ago(h: 1, m: 30),
            isRead: false),
        Message(
            id: 'msg20',
            senderId: 'c5',
            text: 'May small issue sa API mapping',
            timestamp: _ago(h: 1, m: 29),
            isRead: false),
        Message(
            id: 'msg21',
            senderId: 'c5',
            text: 'Call tayo kung need mo',
            timestamp: _ago(m: 10),
            isRead: false),
      ],
    ),
    Conversation(
      id: 'conv6',
      contact: contacts[5],
      unreadCount: 0,
      messages: [
        Message(
            id: 'msg22',
            senderId: 'c6',
            text: 'Nag-adobo ako tonight',
            timestamp: _ago(h: 8)),
        Message(
            id: 'msg23',
            senderId: kSelfId,
            text: 'Send recipe please',
            timestamp: _ago(h: 7, m: 55)),
        Message(
            id: 'msg24',
            senderId: 'c6',
            text: 'Sending na boss',
            timestamp: _ago(h: 7, m: 50)),
      ],
    ),
    Conversation(
      id: 'conv7',
      contact: contacts[10],
      unreadCount: 6,
      messages: [
        Message(
            id: 'msg25',
            senderId: 'g1',
            text: 'Sino game mag-Tagaytay ride?',
            timestamp: _ago(h: 2, m: 12),
            isRead: false),
        Message(
            id: 'msg26',
            senderId: kSelfId,
            text: 'Ako, basta Sunday',
            timestamp: _ago(h: 2, m: 9)),
        Message(
            id: 'msg27',
            senderId: 'g1',
            text: 'Meetup Shell C5 5:30am',
            timestamp: _ago(m: 38),
            isRead: false),
      ],
    ),
    Conversation(
      id: 'conv8',
      contact: contacts[11],
      unreadCount: 1,
      messages: [
        Message(
            id: 'msg28',
            senderId: 'g2',
            text: 'Standup moved to 10:15.',
            timestamp: _ago(h: 1, m: 22),
            isRead: false),
        Message(
            id: 'msg29',
            senderId: kSelfId,
            text: 'Copy, thanks.',
            timestamp: _ago(h: 1, m: 20)),
      ],
    ),
    Conversation(
      id: 'conv9',
      contact: contacts[12],
      unreadCount: 0,
      messages: [
        Message(
            id: 'msg30',
            senderId: 'g3',
            text: 'Practice Saturday 4pm.',
            timestamp: _ago(h: 9)),
        Message(
            id: 'msg31',
            senderId: kSelfId,
            text: 'Noted, dala ako tubig.',
            timestamp: _ago(h: 8, m: 55)),
      ],
    ),
  ];

  static final List<Story> stories = [
    Story(
      contact: contacts[0],
      imageUrl: 'assets/images/stories/s1.jpg',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Story(
      contact: contacts[2],
      imageUrl: 'assets/images/stories/s2.jpg',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      viewed: true,
    ),
    Story(
      contact: contacts[4],
      imageUrl: 'assets/images/stories/s3.jpg',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Story(
      contact: contacts[6],
      imageUrl: 'assets/images/stories/s4.jpg',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Story(
      contact: contacts[8],
      imageUrl: 'assets/images/stories/s5.jpg',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      viewed: true,
    ),
  ];

  static bool hasStory(String contactId) =>
      stories.any((story) => story.contact.id == contactId);

  static bool hasUnviewedStory(String contactId) =>
      stories.any((story) => story.contact.id == contactId && !story.viewed);
}
