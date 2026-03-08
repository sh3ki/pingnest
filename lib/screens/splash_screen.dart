import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.7)));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigation()));
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.heroGradient),
        child: SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ScaleTransition(scale: _scale, child: FadeTransition(opacity: _fade, child: const Text('🐦', style: TextStyle(fontSize: 96)))),
          const SizedBox(height: 20),
          FadeTransition(opacity: _fade, child: Column(children: [
            RichText(text: const TextSpan(children: [
              TextSpan(text: 'Ping', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.white)),
              TextSpan(text: 'Nest', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Color(0xFFA7F3D0))),
            ])),
            const SizedBox(height: 8),
            const Text('Connect Closer', style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _Feature('💬', 'Chat'),
              const SizedBox(width: 28),
              _Feature('👥', 'Contacts'),
              const SizedBox(width: 28),
              _Feature('📖', 'Stories'),
            ]),
          ])),
        ]))),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final String emoji, label;
  const _Feature(this.emoji, this.label);

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(emoji, style: const TextStyle(fontSize: 24)),
    const SizedBox(height: 4),
    Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
  ]);
}
