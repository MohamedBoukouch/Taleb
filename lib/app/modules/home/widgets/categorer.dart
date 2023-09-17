import 'package:flutter/material.dart';

class Categorer extends StatelessWidget {
  final String titel;
  const Categorer({
    Key? key,
    required this.titel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 3, bottom: 3, right: 7, left: 7),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromARGB(219, 7, 1, 1).withOpacity(0.5),
        //     spreadRadius: 3,
        //     blurRadius: 2,
        //     offset: Offset(0, 2), // changes position of shadow
        //   ),
        // ],
        
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
      ),
      child: Text(
        titel,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
