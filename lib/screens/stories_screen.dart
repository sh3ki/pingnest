import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/chat_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});
  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  Widget _storyImage(String source,
      {required double height, required BoxFit fit}) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return Image.network(
        source,
        height: height,
        width: double.infinity,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          height: height,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined, size: 36),
        ),
      );
    }
    return Image.asset(
      source,
      height: height,
      width: double.infinity,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        height: height,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined, size: 36),
      ),
    );
  }

  void _viewStory(int index) {
    setState(() => ChatData.stories[index].viewed = true);
    final story = ChatData.stories[index];
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            _storyImage(story.imageUrl, height: 560, fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xAA000000), Color(0x00000000)],
                  ),
                ),
                child: Row(
                  children: [
                    AvatarWidget(
                      initials: story.contact.initials,
                      imageUrl: story.contact.avatarUrl,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story.contact.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, hh:mm a')
                                .format(story.timestamp),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
        AppLogo(size: 24, showText: false),
        SizedBox(width: 8),
        Text('Stories'),
      ])),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        // My Story
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppTheme.softShadow),
          child: Row(children: [
            Stack(children: [
              const AvatarWidget(
                initials: 'MS',
                imageUrl: ChatData.selfProfileImageUrl,
                hasStory: true,
                storyViewed: false,
                size: 60,
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        color: AppTheme.secondary, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  )),
            ]),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('My Story',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppTheme.textPrimary)),
              Text('Add to your story',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ]),
          ]),
        ),
        const Text('Recent Stories',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppTheme.textPrimary)),
        const SizedBox(height: 12),
        ...ChatData.stories.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return GestureDetector(
            onTap: () => _viewStory(i),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppTheme.softShadow,
                border: s.viewed
                    ? null
                    : Border.all(color: AppTheme.secondary, width: 2),
              ),
              child: Column(children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(14)),
                  child:
                      _storyImage(s.imageUrl, height: 160, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    AvatarWidget(
                      initials: s.contact.initials,
                      imageUrl: s.contact.avatarUrl,
                      hasStory: true,
                      storyViewed: s.viewed,
                      size: 44,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        s.contact.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: s.viewed
                              ? AppTheme.textSecondary
                              : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm a').format(s.timestamp),
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          );
        }),
      ]),
    );
  }
}
