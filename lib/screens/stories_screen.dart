import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  void _viewStory(int index) {
    setState(() => MockData.stories[index].viewed = true);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: AppTheme.heroGradient, borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(MockData.stories[index].emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(MockData.stories[index].contact.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(MockData.stories[index].caption, style: const TextStyle(color: Colors.white70, fontSize: 15), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(DateFormat('MMM d, hh:mm a').format(MockData.stories[index].timestamp), style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(title: const Text('Stories')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        // My Story
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
          child: Row(children: [
            Stack(children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: const Center(child: Text('🐦', style: TextStyle(fontSize: 28))),
              ),
              Positioned(right: 0, bottom: 0, child: Container(
                width: 20, height: 20,
                decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              )),
            ]),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('My Story', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              Text('Add to your story', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ]),
          ]),
        ),
        const Text('Recent Stories', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 12),
        ...MockData.stories.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return GestureDetector(
            onTap: () => _viewStory(i),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppTheme.softShadow,
                border: s.viewed ? null : Border.all(color: AppTheme.primary, width: 2),
              ),
              child: Row(children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    gradient: s.viewed ? null : AppTheme.heroGradient,
                    color: s.viewed ? Colors.grey[200] : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(s.emoji, style: const TextStyle(fontSize: 28))),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(s.contact.name, style: TextStyle(fontWeight: FontWeight.w700, color: s.viewed ? Colors.grey : Colors.black87)),
                  const SizedBox(height: 2),
                  Text(s.caption, style: const TextStyle(color: Colors.grey, fontSize: 13), overflow: TextOverflow.ellipsis),
                ])),
                Text(DateFormat('hh:mm a').format(s.timestamp), style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ]),
            ),
          );
        }),
      ]),
    );
  }
}
