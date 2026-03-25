import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_quest_n1/main.dart';

void main() {
  testWidgets('app mostra login', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterQuestApp());

    expect(find.text('FLUTTER QUEST'), findsOneWidget);
  });
}
