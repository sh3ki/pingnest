import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/chat_data.dart';
import '../models/chat_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class ChatDetailScreen extends StatefulWidget {
  final Conversation conversation;
  const ChatDetailScreen({super.key, required this.conversation});
  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  late final List<Message> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.conversation.messages);
    widget.conversation.unreadCount = 0;
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(
          id: 'new_${DateTime.now().millisecondsSinceEpoch}',
          senderId: ChatData.kSelfId,
          text: text,
          timestamp: DateTime.now()));
    });
    _msgCtrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients)
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contact = widget.conversation.contact;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Row(children: [
          AvatarWidget(
            initials: contact.initials,
            imageUrl: contact.avatarUrl,
            isOnline: contact.isOnline,
            hasStory: ChatData.hasStory(contact.id),
            storyViewed: !ChatData.hasUnviewedStory(contact.id),
            size: 40,
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(contact.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Text(
              contact.isGroup
                  ? contact.status
                  : (contact.isOnline ? 'Online' : 'Offline'),
              style:
                  TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
            ),
          ]),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollCtrl,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (_, i) {
              final msg = _messages[i];
              final isSelf = msg.senderId == ChatData.kSelfId;
              return Align(
                alignment:
                    isSelf ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.72),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelf ? AppTheme.sentBubble : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isSelf ? 18 : 4),
                      bottomRight: Radius.circular(isSelf ? 4 : 18),
                    ),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(msg.text,
                            style: TextStyle(
                                color: isSelf
                                    ? Colors.white
                                    : AppTheme.textPrimary,
                                fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(DateFormat('hh:mm a').format(msg.timestamp),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: isSelf
                                      ? Colors.white70
                                      : AppTheme.textSecondary)),
                          if (isSelf) ...[
                            const SizedBox(width: 4),
                            Icon(msg.isRead ? Icons.done_all : Icons.done,
                                size: 14, color: Colors.white70)
                          ],
                        ]),
                      ]),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SafeArea(
            child: Row(children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  color: AppTheme.secondary),
              Expanded(
                child: TextField(
                  controller: _msgCtrl,
                  decoration: InputDecoration(
                    hintText: 'Message...',
                    filled: true,
                    fillColor: AppTheme.surface,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                      color: AppTheme.secondary, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
