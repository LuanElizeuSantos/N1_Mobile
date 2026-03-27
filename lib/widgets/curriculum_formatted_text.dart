import 'package:flutter/material.dart';

List<InlineSpan> curriculumSpans(String input, TextStyle baseStyle) {
  if (input.isEmpty) {
    return [TextSpan(text: '', style: baseStyle)];
  }
  return _parseSegment(input, baseStyle);
}

TextStyle _codeStyle(TextStyle base) {
  final fs = base.fontSize ?? 14;
  return base.merge(TextStyle(
    fontFamily: 'monospace',
    fontSize: fs * 0.92,
    height: 1.25,
    backgroundColor: const Color(0x332196F3),
  ));
}

List<InlineSpan> _parseSegment(String s, TextStyle style) {
  final spans = <InlineSpan>[];
  var i = 0;
  while (i < s.length) {
    final strongStart = s.indexOf('<strong>', i);
    final codeStart = s.indexOf('<code>', i);

    int? nextStart;
    var isStrong = false;

    if (strongStart >= 0 && (codeStart < 0 || strongStart <= codeStart)) {
      nextStart = strongStart;
      isStrong = true;
    } else if (codeStart >= 0) {
      nextStart = codeStart;
      isStrong = false;
    }

    if (nextStart == null) {
      if (i < s.length) {
        spans.add(TextSpan(text: s.substring(i), style: style));
      }
      break;
    }

    if (nextStart > i) {
      spans.add(TextSpan(text: s.substring(i, nextStart), style: style));
    }

    if (isStrong) {
      const open = '<strong>';
      const close = '</strong>';
      final end = s.indexOf(close, nextStart + open.length);
      if (end < 0) {
        spans.add(TextSpan(text: s.substring(nextStart), style: style));
        break;
      }
      final inner = s.substring(nextStart + open.length, end);
      final strongStyle = style.merge(const TextStyle(fontWeight: FontWeight.w700));
      spans.add(TextSpan(
        style: strongStyle,
        children: _parseSegment(inner, strongStyle),
      ));
      i = end + close.length;
    } else {
      const open = '<code>';
      const close = '</code>';
      final end = s.indexOf(close, nextStart + open.length);
      if (end < 0) {
        spans.add(TextSpan(text: s.substring(nextStart), style: style));
        break;
      }
      final inner = s.substring(nextStart + open.length, end);
      spans.add(TextSpan(text: inner, style: _codeStyle(style)));
      i = end + close.length;
    }
  }
  return spans;
}

class CurriculumFormattedText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign textAlign;

  const CurriculumFormattedText(
    this.data, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return SelectableText.rich(
      TextSpan(children: curriculumSpans(data, base)),
      textAlign: textAlign,
    );
  }
}

class CurriculumFormattedPlain extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CurriculumFormattedPlain(
    this.data, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return Text.rich(
      TextSpan(children: curriculumSpans(data, base)),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}
