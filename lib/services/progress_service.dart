import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_progress.dart';

class ProgressService extends ChangeNotifier {
  ProgressService._();
  static final ProgressService instance = ProgressService._();

  static const _storageKey = 'flutter_quest_progress_v1';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  UserProgress _progress = UserProgress.initial();
  UserProgress get progress => _progress;

  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    try {
      final raw = await _storage.read(key: _storageKey);
      if (raw != null && raw.isNotEmpty) {
        _progress = UserProgress.decode(raw);
      }
    } catch (e) {
      debugPrint('ProgressService.load: $e');
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _persist() async {
    try {
      await _storage.write(
        key: _storageKey,
        value: UserProgress.encode(_progress),
      );
    } catch (e) {
      debugPrint('ProgressService._persist: $e');
    }
    notifyListeners();
  }

  Future<void> setPlayerName(String name) async {
    final trimmed = name.trim();
    _progress = _progress.copyWith(
      playerName: trimmed.isEmpty ? 'Estagiário' : trimmed,
    );
    await _persist();
  }

  Future<void> completePhaseIfCurrent(int phaseIndex) async {
    if (phaseIndex != _progress.completedPhases) return;
    if (_progress.completedPhases >= 20) return;
    _progress = _progress.copyWith(completedPhases: _progress.completedPhases + 1);
    await _persist();
  }

  Future<void> resetProgress() async {
    _progress = UserProgress.initial().copyWith(playerName: _progress.playerName);
    await _persist();
  }
}
