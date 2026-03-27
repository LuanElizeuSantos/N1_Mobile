import '../models/curriculum.dart';

List<PhaseData> get allPhases => _phases;

final List<PhaseData> _phases = [
  PhaseData(
    globalIndex: 0,
    world: 1,
    indexInWorld: 1,
    titulo: 'Exercício: tipos (mock)',
    descricao: 'Prática com tipos A/B/C.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre <code>int</code> em Dart são verdadeiras?',
        options: const [
          '<code>int</code> guarda números inteiros',
          '<code>int</code> guarda texto',
          '5 é um valor válido para <code>int</code>',
          '<code>int?</code> pode ser <code>null</code>',
        ],
        correctIndices: const {0, 2, 3},
        explanation: 'int não armazena texto.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual declaração é válida?',
        options: const [
          '<code>String x = 1;</code>',
          "<code>String x = 'a';</code>",
          '<code>double x = true;</code>',
          '<code>bool x = 0;</code>',
        ],
        singleCorrectIndex: 1,
        explanation: 'String recebe texto entre aspas.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 1,
    world: 1,
    indexInWorld: 2,
    titulo: 'Exercício: operadores (mock)',
    descricao: 'Módulo e operadores lógicos.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Resultado de <code>7 % 3</code>?',
        options: const ['0', '1', '2', '3'],
        singleCorrectIndex: 2,
        explanation: 'Resto da divisão inteira.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Qual afirmação sobre <code>&&</code> e <code>||</code> está <strong>incorreta</strong>?',
        options: const [
          '<code>&&</code> exige ambas verdadeiras',
          '<code>||</code> exige ambas verdadeiras',
          '<code>!</code> nega um bool',
          '<code>||</code> é verdadeiro se ao menos uma for verdadeira',
        ],
        singleIncorrectIndex: 1,
        explanation: '<code>||</code> não exige ambas.',
      ),
    ],
  ),
];
