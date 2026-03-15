import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  const AppLogo({super.key, this.size = 48, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: size * 0.82,
        height: size * 0.82,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: AppTheme.softShadow,
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.12),
          child: ClipOval(
            child: Image.asset(
              'assets/images/pingnest logo.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.chat_rounded,
                color: AppTheme.secondary,
                size: size * 0.45,
              ),
            ),
          ),
        ),
      ),
      if (showText) ...[
        const SizedBox(width: 8),
        Text(
          'PingNest',
          style: TextStyle(
            fontSize: size * 0.5,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    ]);
  }
}

class AvatarWidget extends StatelessWidget {
  final String initials;
  final String? imageUrl;
  final bool isOnline;
  final bool hasStory;
  final bool storyViewed;
  final double size;
  final Color? color;
  const AvatarWidget({
    super.key,
    required this.initials,
    this.imageUrl,
    this.isOnline = false,
    this.hasStory = false,
    this.storyViewed = false,
    this.size = 48,
    this.color,
  });

  Widget _buildAvatarImage(String source, Color bgColor) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return Image.network(
        source,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(
          child: Text(
            initials,
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.w700,
              color: bgColor,
            ),
          ),
        ),
      );
    }
    return Image.asset(
      source,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
            color: bgColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? AppTheme.primary;
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.12),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.6),
      ),
      child: ClipOval(
        child: imageUrl == null
            ? Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: size * 0.35,
                    fontWeight: FontWeight.w700,
                    color: bgColor,
                  ),
                ),
              )
            : _buildAvatarImage(imageUrl!, bgColor),
      ),
    );

    return Stack(children: [
      hasStory
          ? Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: storyViewed
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: storyViewed ? Colors.grey.shade300 : null,
              ),
              child: avatar,
            )
          : avatar,
      if (isOnline)
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: size * 0.27,
            height: size * 0.27,
            decoration: BoxDecoration(
                color: AppTheme.secondary,
                shape: BoxShape.circle,
                border: const Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 2))),
          ),
        ),
    ]);
  }
}
