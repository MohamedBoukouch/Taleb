import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.day}/${now.month}/${now.year}";

    return Scaffold(
      body: Center(
        child: Text(
          'Current Date and Time: ',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
