import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

import '../../../config/themes/app_theme.dart';

class Slider_2 extends StatefulWidget {
  final String titel;
  final Icon icon;
  const Slider_2({Key? key, required this.titel, required this.icon})
      : super(key: key);

  @override
  State<Slider_2> createState() => _Slider_2State();
}

class _Slider_2State extends State<Slider_2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(right: 12, left: 12, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromARGB(66, 158, 158, 158))),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.blue_color_1,
            child: widget.icon,
          ),
          title: Text("${widget.titel}",style: TextStyle(fontSize: 14),),
          trailing: Icon(Icons.navigate_next_rounded)),
    );
  }
}
