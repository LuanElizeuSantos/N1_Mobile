import 'package:flutter/material.dart';

import '../models/curriculum.dart';

class AchievementHandler {
  AchievementHandler._();

  static const List<AchievementDef> all = [
    AchievementDef(
      id: 'ach_1',
      title: 'Primeiro café',
      subtitle: 'Nível 2 -> você completou as primeiras duas fases.',
      icon: Icons.local_cafe,
    ),
    AchievementDef(
      id: 'ach_2',
      title: 'Depurador em formação',
      subtitle: 'Nível 4 -> fundamentos de Dart consolidados.',
      icon: Icons.bug_report,
    ),
    AchievementDef(
      id: 'ach_3',
      title: 'Loop & lógica',
      subtitle: 'Nível 6 -> condicionais e fluxo sob controle.',
      icon: Icons.loop,
    ),
    AchievementDef(
      id: 'ach_4',
      title: 'Coleções no bolso',
      subtitle: 'Nível 8 -> listas, conjuntos e mapas.',
      icon: Icons.storage,
    ),
    AchievementDef(
      id: 'ach_5',
      title: 'Widget padawan',
      subtitle: 'Nível 10 -> Dart completo; Flutter na mira.',
      icon: Icons.widgets,
    ),
    AchievementDef(
      id: 'ach_6',
      title: 'Navegador da pilha',
      subtitle: 'Nível 12+ -> UI e navegação no radar.',
      icon: Icons.navigation,
    ),
  ];

  static int unlockedCountForLevel(int playerLevel) {
    if (playerLevel < 2) return 0;
    final n = playerLevel ~/ 2;
    return n.clamp(0, all.length);
  }

  static List<({AchievementDef def, bool unlocked})> listForLevel(int playerLevel) {
    final n = unlockedCountForLevel(playerLevel);
    return [
      for (var i = 0; i < all.length; i++)
        (def: all[i], unlocked: i < n),
    ];
  }
}
