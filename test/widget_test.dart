import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_quest_n1/main.dart';
import 'package:flutter_quest_n1/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await ProgressService.instance.load();
  });

  testWidgets('app renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ListenableBuilder(
        listenable: ProgressService.instance,
        builder: (context, _) {
          return const FlutterQuestApp();
        },
      ),
    );

    expect(find.text('FLUTTER QUEST'), findsOneWidget);
  });
}
