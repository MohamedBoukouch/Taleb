import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;

  StyledText({required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    List<String> phrases = text.split('. ');

    for (String phrase in phrases) {
      if (phrase.startsWith('titel')) {
        textSpans.add(_buildTextSpan(
            phrase.replaceFirst('titel : ', ''),
            Colors.blue,
            FontWeight.bold,
            15.0)); // Adjust the size as needed
      } else if (phrase.startsWith('task')) {
        textSpans.add(_buildTextSpan(
            '• ' +
                phrase.replaceFirst('task : ', ''),
            Colors.black,
            FontWeight.normal,
            14.0)); // Adjust the size as needed, '• ' represents bullet point
      } else if (phrase.startsWith('date')) {
        textSpans.add(_buildTextSpan(
            phrase.replaceFirst('date : ', ''),
            Colors.red,
            FontWeight.bold,
            15.0));
      }else {
        textSpans.add(_buildTextSpan(
            phrase,
            Colors.black,
            FontWeight.normal,
            15.0));
      }
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(children: textSpans),
      ),
    );
  }

  TextSpan _buildTextSpan(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return TextSpan(
      text: text + '.\n',
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: 'Bitter',
      ),
    );
  }
}
