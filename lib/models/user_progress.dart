import 'dart:convert';

import '../data/curriculum_data.dart';

class UserProgress {
  final int completedPhases;
  final String playerName;

  const UserProgress({
    required this.completedPhases,
    required this.playerName,
  });

  factory UserProgress.initial() => const UserProgress(
        completedPhases: 0,
        playerName: 'Estagiário',
      );

  int get playerLevel => 1 + (completedPhases ~/ 2);

  int get currentWorld {
    if (allPhases.isEmpty) return 1;
    if (completedPhases >= allPhases.length) return allPhases.last.world;
    return allPhases[completedPhases].world;
  }

  int? get nextPhaseInWorld {
    if (completedPhases >= allPhases.length) return null;
    return allPhases[completedPhases].indexInWorld;
  }

  UserProgress copyWith({
    int? completedPhases,
    String? playerName,
  }) {
    return UserProgress(
      completedPhases: completedPhases ?? this.completedPhases,
      playerName: playerName ?? this.playerName,
    );
  }

  Map<String, dynamic> toJson() => {
        'completedPhases': completedPhases,
        'playerName': playerName,
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    final raw = json['completedPhases'];
    int phases = 0;
    if (raw is int) phases = raw;
    if (raw is num) phases = raw.toInt();
    phases = phases.clamp(0, allPhases.length);

    final name = json['playerName'] is String
        ? (json['playerName'] as String).trim()
        : 'Estagiário';

    return UserProgress(
      completedPhases: phases,
      playerName: name.isEmpty ? 'Estagiário' : name,
    );
  }

  static String encode(UserProgress p) => jsonEncode(p.toJson());

  static UserProgress decode(String s) =>
      UserProgress.fromJson(jsonDecode(s) as Map<String, dynamic>);
}
