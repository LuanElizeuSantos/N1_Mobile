import 'package:flutter/material.dart';

import '../data/curriculum_data.dart';
import '../services/achievement_handler.dart';
import '../services/progress_service.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProgressService.instance,
      builder: (context, _) {
        final p = ProgressService.instance.progress;
        final mundo = switch (p.currentWorld) {
          1 => 'Mundo 1 — Dart',
          2 => 'Mundo 2 — Flutter',
          3 => 'Mundo 3 — Firebase',
          _ => 'Mundo ${p.currentWorld}',
        };
        final achievements =
            AchievementHandler.listForCompletedPhases(p.completedPhases);
        final fasesNoMundo = allPhases.where((e) => e.world == p.currentWorld).length;

        return Scaffold(
          appBar: AppBar(title: const Text('Crachá do Dev')),
          body: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
              const SizedBox(height: 10),
              Text(
                p.playerName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Nível ${p.playerLevel} · $mundo',
                style: const TextStyle(color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
              if (p.nextPhaseInWorld != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Próxima fase no mundo atual: ${p.nextPhaseInWorld}/$fasesNoMundo',
                    style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 13),
                  ),
                ),
              const Divider(height: 40),
              const Text(
                'CONQUISTAS',
                style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    final row = achievements[index];
                    final badge = row.def;
                    final ok = row.unlocked;
                    return Card(
                      color: ok ? Colors.blueGrey[800] : Colors.black26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            badge.icon,
                            size: 40,
                            color: ok ? Colors.orangeAccent : Colors.white10,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              badge.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ok ? Colors.white : Colors.white24,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          if (ok)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                              child: Text(
                                badge.subtitle,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10, color: Colors.white54),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: TextButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Zerar progresso?'),
                        content: const Text(
                          'Fases e conquistas voltam ao início. O nome do crachá '
                          'permanece o mesmo.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text(
                              'Zerar',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm != true || !context.mounted) return;
                    await ProgressService.instance.resetProgress();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Progresso zerado.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.restart_alt, color: Colors.redAccent),
                  label: const Text(
                    'Zerar progresso',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
