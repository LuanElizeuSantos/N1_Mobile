import 'package:flutter/material.dart';

enum PhaseKind { conteudo, exercicio }

enum ExerciseKind { multiplasVerdadeiras, marqueCorreta, marqueIncorreta }

class ContentBlock {
  final String body;
  final String style;

  const ContentBlock({required this.body, this.style = 'text'});
}

class ExerciseActivity {
  final ExerciseKind kind;
  final String prompt;
  final List<String> options;
  final Set<int> correctIndices;
  final int? singleCorrectIndex;
  final int? singleIncorrectIndex;
  final String explanation;

  const ExerciseActivity({
    required this.kind,
    required this.prompt,
    required this.options,
    this.correctIndices = const {},
    this.singleCorrectIndex,
    this.singleIncorrectIndex,
    required this.explanation,
  });
}

class PhaseData {
  final int globalIndex;
  final int world;
  final int indexInWorld;
  final String titulo;
  final String descricao;
  final PhaseKind kind;
  final List<ContentBlock>? contentBlocks;
  final List<ExerciseActivity>? activities;

  const PhaseData({
    required this.globalIndex,
    required this.world,
    required this.indexInWorld,
    required this.titulo,
    required this.descricao,
    required this.kind,
    this.contentBlocks,
    this.activities,
  });

  String get worldTitle => world == 1 ? 'Mundo 1 — Dart' : 'Mundo 2 — Flutter';
}

class AchievementDef {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  const AchievementDef({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
