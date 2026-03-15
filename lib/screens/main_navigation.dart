import 'package:flutter/material.dart';
import '../data/chat_data.dart';
import 'chats_screen.dart';
import 'contacts_screen.dart';
import 'pulse_screen.dart';
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
    final totalUnread =
        ChatData.conversations.fold(0, (s, c) => s + c.unreadCount);

    final screens = const [
      ChatsScreen(),
      ContactsScreen(),
      PulseScreen(),
      StoriesScreen(),
      ProfileScreen(),
    ];

    final tabs = [
      (
        icon: Icons.chat_bubble_outline_rounded,
        active: Icons.chat_bubble_rounded,
        label: 'Chats',
        badge: totalUnread
      ),
      (
        icon: Icons.people_alt_outlined,
        active: Icons.people_alt_rounded,
        label: 'People',
        badge: 0
      ),
      (
        icon: Icons.local_fire_department_outlined,
        active: Icons.local_fire_department_rounded,
        label: 'Pulse',
        badge: 0
      ),
      (
        icon: Icons.photo_library_outlined,
        active: Icons.photo_library_rounded,
        label: 'Stories',
        badge: 0
      ),
      (
        icon: Icons.person_outline_rounded,
        active: Icons.person_rounded,
        label: 'Me',
        badge: 0
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _idx, children: screens),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
        decoration: BoxDecoration(
          color: const Color(0xFF10212A),
          border:
              Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
        ),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final tab = tabs[i];
            final selected = _idx == i;
            return Expanded(
              child: InkWell(
                onTap: () => setState(() => _idx = i),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withOpacity(0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF5EEAD4).withOpacity(0.45)
                          : Colors.transparent,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            selected ? tab.active : tab.icon,
                            color: selected
                                ? const Color(0xFF5EEAD4)
                                : Colors.white70,
                            size: 23,
                          ),
                          if (tab.badge > 0)
                            Positioned(
                              right: -8,
                              top: -7,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Text(
                                  '${tab.badge}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tab.label,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.white.withOpacity(0.68),
                          fontSize: 11,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
