import 'package:flutter/material.dart';

import '../models/curriculum.dart';

class AchievementHandler {
  AchievementHandler._();

  static const List<AchievementDef> all = [
    AchievementDef(
      id: 'ach_1',
      title: 'Primeiro café',
      subtitle: 'Desbloqueada após concluir 2 fases.',
      icon: Icons.local_cafe,
    ),
    AchievementDef(
      id: 'ach_2',
      title: 'Depurador em formação',
      subtitle: 'Desbloqueada após concluir 4 fases.',
      icon: Icons.bug_report,
    ),
    AchievementDef(
      id: 'ach_3',
      title: 'Loop & lógica',
      subtitle: 'Desbloqueada após concluir 6 fases.',
      icon: Icons.loop,
    ),
    AchievementDef(
      id: 'ach_4',
      title: 'Coleções no bolso',
      subtitle: 'Desbloqueada após concluir 8 fases.',
      icon: Icons.storage,
    ),
    AchievementDef(
      id: 'ach_5',
      title: 'Widget padawan',
      subtitle: 'Desbloqueada após concluir 10 fases.',
      icon: Icons.widgets,
    ),
    AchievementDef(
      id: 'ach_6',
      title: 'Navegador da pilha',
      subtitle: 'Desbloqueada após concluir 12 fases.',
      icon: Icons.navigation,
    ),
    AchievementDef(
      id: 'ach_7',
      title: 'Console aceso',
      subtitle: 'Desbloqueada após concluir 14 fases.',
      icon: Icons.cloud_outlined,
    ),
    AchievementDef(
      id: 'ach_8',
      title: 'Jornada completa',
      subtitle: 'Desbloqueada após concluir as 16 fases.',
      icon: Icons.emoji_events_outlined,
    ),
  ];

  static int unlockedCountForCompletedPhases(int completedPhases) {
    if (completedPhases < 2) return 0;
    return (completedPhases ~/ 2).clamp(0, all.length);
  }

  static List<({AchievementDef def, bool unlocked})> listForCompletedPhases(
    int completedPhases,
  ) {
    final n = unlockedCountForCompletedPhases(completedPhases);
    return [
      for (var i = 0; i < all.length; i++)
        (def: all[i], unlocked: i < n),
    ];
  }
}
