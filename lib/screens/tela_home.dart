import 'package:flutter/material.dart';

import '../data/curriculum_data.dart';
import '../models/curriculum.dart';
import '../services/progress_service.dart';
import 'tela_fase.dart';
import 'tela_perfil.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  static String _worldLabel(int w) {
    switch (w) {
      case 1:
        return 'Dart';
      case 2:
        return 'Flutter';
      case 3:
        return 'Firebase';
      default:
        return 'Mundo $w';
    }
  }

  static int _firstGlobalIndexForWorld(int world) =>
      allPhases.firstWhere((e) => e.world == world).globalIndex;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProgressService.instance,
      builder: (context, _) {
        final done = ProgressService.instance.progress.completedPhases;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Jornada Flutter'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle, size: 30),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPerfil()),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              _HeaderProgress(
                completedPhases: done,
                worldLabel: _worldLabel,
              ),
              const SizedBox(height: 24),
              _WorldSection(
                world: 1,
                title: 'Mundo 1 — Dart',
                subtitle: 'Fundamentos da linguagem',
                completedPhases: done,
              ),
              const SizedBox(height: 16),
              _WorldSection(
                world: 2,
                title: 'Mundo 2 — Flutter',
                subtitle: 'Widgets, layout e navegação',
                completedPhases: done,
              ),
              const SizedBox(height: 16),
              _WorldSection(
                world: 3,
                title: 'Mundo 3 — Firebase',
                subtitle: 'Backend, dados e integração no app',
                completedPhases: done,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderProgress extends StatelessWidget {
  final int completedPhases;
  final String Function(int) worldLabel;

  const _HeaderProgress({
    required this.completedPhases,
    required this.worldLabel,
  });

  @override
  Widget build(BuildContext context) {
    final p = ProgressService.instance.progress;
    final total = allPhases.length;
    final fasesNoMundoAtual =
        allPhases.where((e) => e.world == p.currentWorld).length;
    return Card(
      color: const Color(0xFF1E2430),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${p.playerName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nível ${p.playerLevel} · Mundo atual: ${worldLabel(p.currentWorld)} · '
              '${completedPhases >= total ? "Jornada completa" : "Próxima: fase ${p.nextPhaseInWorld ?? "-"} de $fasesNoMundoAtual"}',
              style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 14),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: total > 0 ? completedPhases / total : 0,
              backgroundColor: Colors.white10,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 4),
            Text(
              '$completedPhases/$total fases',
              style: const TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorldSection extends StatelessWidget {
  final int world;
  final String title;
  final String subtitle;
  final int completedPhases;

  const _WorldSection({
    required this.world,
    required this.title,
    required this.subtitle,
    required this.completedPhases,
  });

  @override
  Widget build(BuildContext context) {
    final phases = allPhases.where((e) => e.world == world).toList()
      ..sort((a, b) => a.indexInWorld.compareTo(b.indexInWorld));
    final startW2 = TelaHome._firstGlobalIndexForWorld(2);
    final startW3 = TelaHome._firstGlobalIndexForWorld(3);

    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ExpansionTile(
        initiallyExpanded: world == 1 ||
            (world == 2 && completedPhases >= startW2) ||
            (world == 3 && completedPhases >= startW3),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
        children: [
          for (final phase in phases)
            _PhaseTile(
              phase: phase,
              completedPhases: completedPhases,
            ),
        ],
      ),
    );
  }
}

class _PhaseTile extends StatelessWidget {
  final PhaseData phase;
  final int completedPhases;

  const _PhaseTile({
    required this.phase,
    required this.completedPhases,
  });

  @override
  Widget build(BuildContext context) {
    final idx = phase.globalIndex;
    final unlocked = idx <= completedPhases;
    final completed = idx < completedPhases;
    final isExercise = phase.kind == PhaseKind.exercicio;

    return ListTile(
      leading: Icon(
        completed
            ? Icons.check_circle
            : unlocked
                ? (isExercise ? Icons.fitness_center : Icons.menu_book)
                : Icons.lock_outline,
        color: completed
            ? Colors.greenAccent
            : unlocked
                ? Colors.lightBlueAccent
                : Colors.white24,
      ),
      title: Text('Fase ${phase.indexInWorld}: ${phase.titulo}'),
      subtitle: Text(
        isExercise ? 'Exercício (vidas)' : 'Conteúdo',
        style: const TextStyle(fontSize: 12),
      ),
      onTap: () {
        if (!unlocked) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conclua a fase anterior para desbloquear.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaFase(phaseIndex: idx),
          ),
        );
      },
    );
  }
}
