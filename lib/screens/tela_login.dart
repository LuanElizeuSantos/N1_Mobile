import 'package:flutter/material.dart';

import '../services/progress_service.dart';
import 'tela_home.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final n = ProgressService.instance.progress.playerName;
    if (n.isNotEmpty && n != 'Estagiário') {
      _nomeController.text = n;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    await ProgressService.instance.setPlayerName(_nomeController.text);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.code, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              'FLUTTER QUEST',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text('A Jornada do Estagiário'),
            const SizedBox(height: 40),
            TextField(
              controller: _nomeController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _entrar(),
              decoration: const InputDecoration(
                labelText: 'Nome do Estagiário',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _entrar,
                child: const Text('BATER PONTO (ENTRAR)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
