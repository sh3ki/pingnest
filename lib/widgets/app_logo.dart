import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  const AppLogo({super.key, this.size = 48, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('🐦', style: TextStyle(fontSize: size * 0.7)),
        if (showText) ...[
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Ping', style: TextStyle(fontSize: size * 0.5, fontWeight: FontWeight.w800, color: AppTheme.primary)),
                TextSpan(text: 'Nest', style: TextStyle(fontSize: size * 0.5, fontWeight: FontWeight.w800, color: AppTheme.secondary)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class AvatarWidget extends StatelessWidget {
  final String emoji;
  final bool isOnline;
  final double size;
  const AvatarWidget({super.key, required this.emoji, this.isOnline = false, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size, height: size,
          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.12), shape: BoxShape.circle),
          child: Center(child: Text(emoji, style: TextStyle(fontSize: size * 0.5))),
        ),
        if (isOnline) Positioned(
          right: 0, bottom: 0,
          child: Container(
            width: size * 0.27, height: size * 0.27,
            decoration: BoxDecoration(color: AppTheme.secondary, shape: BoxShape.circle, border: const Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))),
          ),
        ),
      ],
    );
  }
}
