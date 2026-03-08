import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import 'chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  String _formatTime(DateTime t) {
    final now = DateTime.now();
    if (DateUtils.isSameDay(t, now)) return DateFormat('hh:mm a').format(t);
    if (DateUtils.isSameDay(t, now.subtract(const Duration(days: 1)))) return 'Yesterday';
    return DateFormat('MMM d').format(t);
  }

  @override
  Widget build(BuildContext context) {
    final convos = MockData.conversations.where((c) => c.contact.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search chats...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        // Online contacts strip
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: MockData.contacts.where((c) => c.isOnline).length,
            itemBuilder: (_, i) {
              final online = MockData.contacts.where((c) => c.isOnline).toList();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(children: [
                  AvatarWidget(emoji: online[i].avatar, isOnline: true, size: 52),
                  const SizedBox(height: 4),
                  SizedBox(width: 56, child: Text(online[i].name.split(' ')[0], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis)),
                ]),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: convos.length,
            itemBuilder: (_, i) {
              final c = convos[i];
              final last = c.lastMessage;
              return ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(conversation: c))),
                leading: AvatarWidget(emoji: c.contact.avatar, isOnline: c.contact.isOnline, size: 52),
                title: Text(c.contact.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: last != null ? Text(
                  last.senderId == MockData.kSelfId ? 'You: ${last.text}' : last.text,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: c.unreadCount > 0 ? Colors.black87 : Colors.grey, fontWeight: c.unreadCount > 0 ? FontWeight.w600 : FontWeight.w400),
                ) : null,
                trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                  if (last != null) Text(_formatTime(last.timestamp), style: TextStyle(fontSize: 11, color: c.unreadCount > 0 ? AppTheme.primary : Colors.grey)),
                  const SizedBox(height: 4),
                  if (c.unreadCount > 0) Container(
                    width: 20, height: 20,
                    decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                    child: Center(child: Text('${c.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}
