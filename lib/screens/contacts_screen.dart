import 'package:flutter/material.dart';
import '../data/chat_data.dart';
import '../models/chat_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ChatData.contacts
        .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    final grouped = <String, List<Contact>>{};
    for (final c in contacts) {
      final letter = c.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []).add(c);
    }
    final keys = grouped.keys.toList()..sort();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
            AppLogo(size: 24, showText: false),
            SizedBox(width: 8),
            Text('Contacts'),
          ]),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.person_add_outlined))
          ]),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              prefixIcon: const Icon(Icons.search_rounded,
                  color: AppTheme.textSecondary),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: keys.length,
            itemBuilder: (_, i) {
              final letter = keys[i];
              final group = grouped[letter]!;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                      child: Text(letter,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.secondary,
                              fontSize: 13)),
                    ),
                    ...group.map((c) => ListTile(
                          leading: AvatarWidget(
                            initials: c.initials,
                            imageUrl: c.avatarUrl,
                            isOnline: c.isOnline,
                            hasStory: ChatData.hasStory(c.id),
                            storyViewed: !ChatData.hasUnviewedStory(c.id),
                            size: 48,
                          ),
                          title: Text(c.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary)),
                          subtitle: Text(c.status,
                              style: const TextStyle(
                                  color: AppTheme.textSecondary, fontSize: 13),
                              overflow: TextOverflow.ellipsis),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.call_outlined),
                                iconSize: 20,
                                color: AppTheme.primary),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.chat_bubble_outline),
                                iconSize: 20,
                                color: AppTheme.secondary),
                          ]),
                        )),
                  ]);
            },
          ),
        ),
      ]),
    );
  }
}
