import 'package:flutter_test/flutter_test.dart';
import 'package:pingnest/main.dart';

void main() {
  testWidgets('PingNestApp launches', (WidgetTester tester) async {
    await tester.pumpWidget(const PingNestApp());
    expect(find.byType(PingNestApp), findsOneWidget);
  });
}
