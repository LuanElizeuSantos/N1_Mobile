import 'package:flutter/material.dart';

import 'screens/tela_login.dart';
import 'services/progress_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProgressService.instance.load();

  runApp(
    ListenableBuilder(
      listenable: ProgressService.instance,
      builder: (context, _) {
        return const FlutterQuestApp();
      },
    ),
  );
}

class FlutterQuestApp extends StatelessWidget {
  const FlutterQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      home: const TelaLogin(),
    );
  }
}
