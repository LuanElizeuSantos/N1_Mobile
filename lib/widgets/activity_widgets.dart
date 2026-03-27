import 'package:flutter/material.dart';

import '../models/curriculum.dart';
import 'curriculum_formatted_text.dart';

bool _setEquals(Set<int> a, Set<int> b) {
  if (a.length != b.length) return false;
  for (final e in a) {
    if (!b.contains(e)) return false;
  }
  return true;
}

bool evaluateExerciseAttempt(
  ExerciseActivity activity, {
  required Set<int> selectedMultiple,
  required int? selectedSingle,
}) {
  switch (activity.kind) {
    case ExerciseKind.multiplasVerdadeiras:
      return _setEquals(selectedMultiple, activity.correctIndices);
    case ExerciseKind.marqueCorreta:
      return selectedSingle == activity.singleCorrectIndex;
    case ExerciseKind.marqueIncorreta:
      return selectedSingle == activity.singleIncorrectIndex;
  }
}

String _kindLabel(ExerciseKind k) {
  switch (k) {
    case ExerciseKind.multiplasVerdadeiras:
      return 'Assinale as verdadeiras';
    case ExerciseKind.marqueCorreta:
      return 'Marque a correta';
    case ExerciseKind.marqueIncorreta:
      return 'Marque a incorreta';
  }
}

class ExerciseActivityPanel extends StatefulWidget {
  final ExerciseActivity activity;
  final int activityIndex;
  final int activityTotal;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ExerciseActivityPanel({
    super.key,
    required this.activity,
    required this.activityIndex,
    required this.activityTotal,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  State<ExerciseActivityPanel> createState() => _ExerciseActivityPanelState();
}

class _ExerciseActivityPanelState extends State<ExerciseActivityPanel> {
  final Set<int> _multi = {};
  int? _single;

  void _submit() {
    final ok = evaluateExerciseAttempt(
      widget.activity,
      selectedMultiple: _multi,
      selectedSingle: _single,
    );

    if (widget.activity.kind == ExerciseKind.multiplasVerdadeiras && _multi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Marque ao menos uma opção ou revise suas escolhas.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (widget.activity.kind != ExerciseKind.multiplasVerdadeiras && _single == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma alternativa.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (ok) {
      widget.onCorrect();
    } else {
      widget.onWrong();
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.activity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: Text(
            'Atividade ${widget.activityIndex + 1}/${widget.activityTotal} · ${_kindLabel(a.kind)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: CurriculumFormattedText(
            a.prompt,
            style: const TextStyle(fontSize: 17, height: 1.35),
          ),
        ),
        const SizedBox(height: 20),
        if (a.kind == ExerciseKind.multiplasVerdadeiras) ...[
          ...List.generate(a.options.length, (i) {
            final checked = _multi.contains(i);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: const Color(0xFF252525),
                borderRadius: BorderRadius.circular(12),
                child:                 CheckboxListTile(
                  value: checked,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _multi.add(i);
                      } else {
                        _multi.remove(i);
                      }
                    });
                  },
                  title: CurriculumFormattedPlain(
                    a.options[i],
                    style: const TextStyle(fontSize: 15),
                    maxLines: 6,
                    overflow: TextOverflow.fade,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.black,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.greenAccent
                        : Colors.white24,
                  ),
                ),
              ),
            );
          }),
        ] else ...[
          ...List.generate(a.options.length, (i) {
            final selected = _single == i;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: selected ? Colors.blueGrey.shade800 : const Color(0xFF252525),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _single = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          selected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: selected ? Colors.lightBlueAccent : Colors.white38,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CurriculumFormattedPlain(
                            a.options[i],
                            style: TextStyle(
                              fontSize: 15,
                              color: selected ? Colors.white : Colors.white70,
                            ),
                            maxLines: 8,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('CONFIRMAR RESPOSTA'),
        ),
      ],
    );
  }
}

class ContentBlockView extends StatelessWidget {
  final ContentBlock block;

  const ContentBlockView({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    switch (block.style) {
      case 'code':
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade800),
          ),
          child: SelectableText(
            block.body,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.4,
              color: Colors.greenAccent,
            ),
          ),
        );
      case 'tip':
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x40FF8F00),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x99FF8F00)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline, color: Color(0xFFFFE082), size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: CurriculumFormattedText(
                  block.body,
                  style: const TextStyle(color: Color(0xFFFFECB3), height: 1.35),
                ),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CurriculumFormattedText(
            block.body,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        );
    }
  }
}
