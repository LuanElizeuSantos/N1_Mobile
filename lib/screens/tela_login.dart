import 'package:flutter/material.dart';

import 'tela_home.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

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
            const TextField(
              decoration: InputDecoration(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaHome()),
                  );
                },
                child: const Text('BATER PONTO (ENTRAR)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
