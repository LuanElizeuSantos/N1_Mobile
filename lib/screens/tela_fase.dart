import 'package:flutter/material.dart';

import '../data/curriculum_data.dart';
import '../models/curriculum.dart';
import '../services/achievement_handler.dart';
import '../services/progress_service.dart';
import '../widgets/activity_widgets.dart';
import '../widgets/curriculum_formatted_text.dart';

class TelaFase extends StatefulWidget {
  final int phaseIndex;

  const TelaFase({super.key, required this.phaseIndex});

  @override
  State<TelaFase> createState() => _TelaFaseState();
}

class _TelaFaseState extends State<TelaFase> {
  int _exerciseStep = 0;
  int _vidas = 3;

  PhaseData get _phase => allPhases[widget.phaseIndex];

  Future<void> _finishPhase(BuildContext context) async {
    final service = ProgressService.instance;
    final advanced = widget.phaseIndex == service.progress.completedPhases;
    final levelBefore = service.progress.playerLevel;

    await service.completePhaseIfCurrent(widget.phaseIndex);

    if (!context.mounted) return;

    final after = service.progress;

    if (advanced) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            after.completedPhases >= 20
                ? 'Jornada completa! Nível ${after.playerLevel}.'
                : 'Fase concluída! Nível ${after.playerLevel}.',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      final achBefore = AchievementHandler.unlockedCountForLevel(levelBefore);
      final achAfter = AchievementHandler.unlockedCountForLevel(after.playerLevel);
      if (achAfter > achBefore && AchievementHandler.all.isNotEmpty) {
        final newest = AchievementHandler.all[achAfter - 1];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nova conquista: ${newest.title}'),
            backgroundColor: Colors.deepPurple,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Esta fase já estava concluída — ótima revisão!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    Navigator.pop(context, advanced);
  }

  void _onExerciseCorrect(BuildContext context) {
    final acts = _phase.activities!;
    final next = _exerciseStep + 1;
    if (next >= acts.length) {
      _finishPhase(context);
      return;
    }
    setState(() => _exerciseStep = next);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Correto! Atividade ${next + 1}/${acts.length}.'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  void _onExerciseWrong(BuildContext context) {
    setState(() {
      if (_vidas > 0) _vidas--;
    });
    final explanation = _phase.activities![_exerciseStep].explanation;
    if (_vidas <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sem vidas! Tente esta fase novamente mais tarde.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context, false);
      return;
    }
    const snackStyle = TextStyle(color: Colors.white, fontSize: 14, height: 1.35);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text.rich(
          TextSpan(
            style: snackStyle,
            children: [
              const TextSpan(text: 'Ainda não. '),
              ...curriculumSpans(explanation, snackStyle),
            ],
          ),
        ),
        backgroundColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = _phase;

    if (p.kind == PhaseKind.conteudo) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Fase ${p.indexInWorld} · ${p.worldTitle}'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    p.titulo,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.descricao,
                    style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 15),
                  ),
                  const Divider(height: 32),
                  ...p.contentBlocks!.map((b) => ContentBlockView(block: b)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _finishPhase(context),
                  child: const Text('CONCLUIR LEITURA'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final activities = p.activities!;
    final act = activities[_exerciseStep];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fase ${p.indexInWorld} · ${p.worldTitle}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercício ${_exerciseStep + 1}/${activities.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
                ),
                Text('Vidas: ${'❤️' * _vidas}', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_exerciseStep + 1) / activities.length,
              backgroundColor: Colors.white10,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: ExerciseActivityPanel(
                  key: ValueKey('${_phase.globalIndex}_$_exerciseStep'),
                  activity: act,
                  activityIndex: _exerciseStep,
                  activityTotal: activities.length,
                  onCorrect: () => _onExerciseCorrect(context),
                  onWrong: () => _onExerciseWrong(context),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('SAIR DA FASE', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
