import 'package:flutter/material.dart';

class Authers extends StatefulWidget {
  const Authers({Key? key}) : super(key: key);

  @override
  State<Authers> createState() => _AuthersState();
}

class _AuthersState extends State<Authers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Authers")),
    );
  }
}
