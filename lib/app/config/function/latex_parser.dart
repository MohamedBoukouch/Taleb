/// Converts a simple LaTeX string into plain readable text.
/// Handles: \textbf{}, \textit{}, \n, \texttt{}, \underline{}

import 'package:flutter/material.dart';

String parseLatex(String latex) {
  String result = latex;

  // \textbf{text} → text (bold handled by UI)
  result = result.replaceAllMapped(
    RegExp(r'\\textbf\{([^}]*)\}'),
    (m) => m.group(1) ?? '',
  );

  // \textit{text} → text
  result = result.replaceAllMapped(
    RegExp(r'\\textit\{([^}]*)\}'),
    (m) => m.group(1) ?? '',
  );

  // \texttt{text} → text
  result = result.replaceAllMapped(
    RegExp(r'\\texttt\{([^}]*)\}'),
    (m) => m.group(1) ?? '',
  );

  // \underline{text} → text
  result = result.replaceAllMapped(
    RegExp(r'\\underline\{([^}]*)\}'),
    (m) => m.group(1) ?? '',
  );

  // \emph{text} → text
  result = result.replaceAllMapped(
    RegExp(r'\\emph\{([^}]*)\}'),
    (m) => m.group(1) ?? '',
  );

  // \n → real newline
  result = result.replaceAll(r'\n', '\n');

  // Remove any remaining \ commands
  result = result.replaceAll(RegExp(r'\\[a-zA-Z]+'), '');

  // Remove remaining { }
  result = result.replaceAll('{', '').replaceAll('}', '');

  return result.trim();
}

/// Same as above but returns styled TextSpan for rich rendering.
/// \textbf → bold, \textit → italic, plain → normal

List<InlineSpan> parseLatexToSpans(String latex,
    {double fontSize = 14, Color textColor = const Color(0xFF191919)}) {
  final spans = <InlineSpan>[];

  // Pattern matches \textbf{...}, \textit{...}, or plain text segments
  final pattern = RegExp(
    r'(\\textbf\{[^}]*\}|\\textit\{[^}]*\}|\\texttt\{[^}]*\}|\\underline\{[^}]*\}|\\emph\{[^}]*\}|\\n|[^\\]+)',
    dotAll: true,
  );

  for (final match in pattern.allMatches(latex)) {
    final token = match.group(0) ?? '';

    if (token == r'\n') {
      spans.add(const TextSpan(text: '\n'));
    } else if (token.startsWith(r'\textbf{')) {
      final inner = token.substring(8, token.length - 1);
      spans.add(TextSpan(
        text: inner,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: textColor,
          height: 1.55,
        ),
      ));
    } else if (token.startsWith(r'\textit{') || token.startsWith(r'\emph{')) {
      final start = token.startsWith(r'\textit{') ? 8 : 6;
      final inner = token.substring(start, token.length - 1);
      spans.add(TextSpan(
        text: inner,
        style: TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          color: textColor,
          height: 1.55,
        ),
      ));
    } else if (token.startsWith(r'\texttt{')) {
      final inner = token.substring(8, token.length - 1);
      spans.add(TextSpan(
        text: inner,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'monospace',
          color: textColor,
          height: 1.55,
        ),
      ));
    } else if (token.startsWith(r'\underline{')) {
      final inner = token.substring(11, token.length - 1);
      spans.add(TextSpan(
        text: inner,
        style: TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          color: textColor,
          height: 1.55,
        ),
      ));
    } else if (!token.startsWith('\\')) {
      spans.add(TextSpan(
        text: token,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          height: 1.55,
        ),
      ));
    }
    // skip unknown \commands
  }

  return spans;
}
