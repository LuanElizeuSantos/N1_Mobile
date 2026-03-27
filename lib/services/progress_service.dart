import 'package:flutter/foundation.dart';

import '../data/curriculum_data.dart';
import '../models/user_progress.dart';

class ProgressService extends ChangeNotifier {
  ProgressService._();
  static final ProgressService instance = ProgressService._();

  UserProgress _progress = UserProgress.initial();
  UserProgress get progress => _progress;

  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _loaded = true;
    notifyListeners();
  }

  Future<void> setPlayerName(String name) async {
    final trimmed = name.trim();
    _progress = _progress.copyWith(
      playerName: trimmed.isEmpty ? 'Estagiário' : trimmed,
    );
    notifyListeners();
  }

  Future<void> completePhaseIfCurrent(int phaseIndex) async {
    if (phaseIndex != _progress.completedPhases) return;
    if (_progress.completedPhases >= allPhases.length) return;
    _progress = _progress.copyWith(completedPhases: _progress.completedPhases + 1);
    notifyListeners();
  }
}
