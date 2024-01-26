import 'package:flutter/material.dart';
import 'package:taleb/app/config/themes/app_theme.dart';

class TypeConcoure extends StatefulWidget {
  String url_img;
  String titel;
  int type;
  TypeConcoure(
      {Key? key,
      required this.url_img,
      required this.titel,
      required this.type})
      : super(key: key);

  @override
  State<TypeConcoure> createState() => _TypeConcoureState();
}

class _TypeConcoureState extends State<TypeConcoure> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 12, left: 12, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(219, 158, 158, 158).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromARGB(66, 158, 158, 158))),
      child: ListTile(
        leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(widget.url_img)),
        title: Text(
          widget.titel,
          style: TextStyle(fontSize: 17, fontFamily: 'Bitter'),
        ),
        trailing:
            Icon(widget.type == 1 ? Icons.navigate_next_rounded : Icons.folder),
        iconColor: AppTheme.yellow_color,
      ),
    );
  }
}
