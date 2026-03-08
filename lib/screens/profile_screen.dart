import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _readReceipts = true;
  bool _lastSeen = false;

  @override
  Widget build(BuildContext context) {
    final onlineCount = MockData.contacts.where((c) => c.isOnline).length;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppTheme.primary,
          title: const Text('Profile'),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(gradient: AppTheme.heroGradient),
              child: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 24),
                Stack(children: [
                  Container(
                    width: 76, height: 76,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                    child: const Center(child: Text('🐦', style: TextStyle(fontSize: 38))),
                  ),
                  Positioned(right: 0, bottom: 0, child: Container(
                    width: 20, height: 20,
                    decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                  )),
                ]),
                const SizedBox(height: 8),
                const Text('Jordan Nest', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                const Text('Always connected 🐦', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ])),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _Stat('${MockData.contacts.length}', 'Contacts'),
                _Div(),
                _Stat('${MockData.conversations.length}', 'Chats'),
                _Div(),
                _Stat('$onlineCount', 'Online'),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Privacy & Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Column(children: [
                _Switch(Icons.notifications_outlined, 'Notifications', _notifications, (v) => setState(() => _notifications = v)),
                Divider(height: 1, color: Colors.grey[100]),
                _Switch(Icons.done_all, 'Read Receipts', _readReceipts, (v) => setState(() => _readReceipts = v)),
                Divider(height: 1, color: Colors.grey[100]),
                _Switch(Icons.access_time, 'Last Seen', _lastSeen, (v) => setState(() => _lastSeen = v)),
              ]),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Column(children: [
                _Item(Icons.star_outline, 'Starred Messages', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.share_outlined, 'Invite Friends', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.help_outline, 'Help & Support', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.info_outline, 'About PingNest', () {}),
              ]),
            ),
            const SizedBox(height: 24),
            Center(child: Text('PingNest v1.0.0  ·  Connect Closer', style: TextStyle(color: Colors.grey[400], fontSize: 12))),
            const SizedBox(height: 20),
          ],
        ))),
      ]),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat(this.value, this.label);

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary)),
    Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
  ]);
}

class _Div extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 36, color: Colors.grey[200]);
}

class _Switch extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _Switch(this.icon, this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppTheme.primary),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    trailing: Switch(value: value, onChanged: onChanged, activeColor: AppTheme.primary),
  );
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Item(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: AppTheme.primary),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
  );
}
