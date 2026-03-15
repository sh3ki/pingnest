import 'package:flutter/material.dart';
import '../data/chat_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _readReceipts = true;
  bool _lastSeen = false;

  Widget _profileImage(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return Image.network(
        source,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _profileFallback(),
      );
    }
    return Image.asset(
      source,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _profileFallback(),
    );
  }

  Widget _profileFallback() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      alignment: Alignment.center,
      child: const Text(
        'MS',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onlineCount = ChatData.contacts.where((c) => c.isOnline).length;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppTheme.primary,
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
            AppLogo(size: 24, showText: false),
            SizedBox(width: 8),
            Text('Profile'),
          ]),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: AppTheme.primary,
              child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const SizedBox(height: 24),
                    Stack(children: [
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: ClipOval(
                          child: _profileImage(ChatData.selfProfileImageUrl),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                color: AppTheme.secondary,
                                shape: BoxShape.circle),
                          )),
                    ]),
                    const SizedBox(height: 8),
                    const Text(ChatData.selfName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800)),
                    Text(ChatData.selfStatus,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13)),
                  ])),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppTheme.softShadow),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _Stat('${ChatData.contacts.length}', 'Contacts'),
                            Container(
                                width: 1, height: 36, color: AppTheme.surface),
                            _Stat('${ChatData.conversations.length}', 'Chats'),
                            Container(
                                width: 1, height: 36, color: AppTheme.surface),
                            _Stat('$onlineCount', 'Online'),
                          ]),
                    ),
                    const SizedBox(height: 24),
                    const Text('Privacy & Notifications',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppTheme.softShadow),
                      child: Column(children: [
                        _Switch(
                            Icons.notifications_outlined,
                            'Notifications',
                            _notifications,
                            (v) => setState(() => _notifications = v)),
                        Divider(height: 1, color: Colors.grey[100]),
                        _Switch(
                            Icons.done_all_rounded,
                            'Read Receipts',
                            _readReceipts,
                            (v) => setState(() => _readReceipts = v)),
                        Divider(height: 1, color: Colors.grey[100]),
                        _Switch(Icons.access_time_rounded, 'Last Seen',
                            _lastSeen, (v) => setState(() => _lastSeen = v)),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppTheme.softShadow),
                      child: Column(children: [
                        _Item(Icons.star_outline_rounded, 'Starred Messages',
                            () {}),
                        Divider(height: 1, color: Colors.grey[100]),
                        _Item(Icons.share_outlined, 'Invite Friends', () {}),
                        Divider(height: 1, color: Colors.grey[100]),
                        _Item(Icons.help_outline_rounded, 'Help & Support',
                            () {}),
                        Divider(height: 1, color: Colors.grey[100]),
                        _Item(Icons.info_outline_rounded, 'About PingNest',
                            () {}),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: Column(children: [
                      const AppLogo(size: 32, showText: false),
                      const SizedBox(height: 8),
                      Text('PingNest v1.0.0',
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 12)),
                    ])),
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
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.secondary)),
        Text(label,
            style:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
      ]);
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
        title: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.secondary),
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
        title: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppTheme.textSecondary),
      );
}
