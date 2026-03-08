import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import 'chats_screen.dart';
import 'contacts_screen.dart';
import 'stories_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final totalUnread = MockData.conversations.fold(0, (s, c) => s + c.unreadCount);

    final screens = [
      const ChatsScreen(),
      const ContactsScreen(),
      const StoriesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _idx, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: [
          NavigationDestination(
            icon: Badge(isLabelVisible: totalUnread > 0, label: Text('$totalUnread'), child: const Icon(Icons.chat_bubble_outline)),
            selectedIcon: Badge(isLabelVisible: totalUnread > 0, label: Text('$totalUnread'), child: Icon(Icons.chat_bubble, color: AppTheme.primary)),
            label: 'Chats',
          ),
          NavigationDestination(icon: const Icon(Icons.people_outline), selectedIcon: Icon(Icons.people, color: AppTheme.primary), label: 'Contacts'),
          NavigationDestination(icon: const Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories, color: AppTheme.primary), label: 'Stories'),
          NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: AppTheme.primary), label: 'Profile'),
        ],
      ),
    );
  }
}
