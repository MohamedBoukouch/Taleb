import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/main.dart';

class MessagForm extends StatefulWidget {
  final String message;
  final String firstname;
  final String lastname;
  final String date;

  const MessagForm({
    Key? key,
    required this.message,
    required this.firstname,
    required this.lastname,
    required this.date,
  }) : super(key: key);

  @override
  State<MessagForm> createState() => _MessagFormState();
}

class _MessagFormState extends State<MessagForm> {
  @override
  Widget build(BuildContext context) {
    // return Container(child: Text(widget.message));
    // return Container(
    //   alignment: Alignment.topLeft,
    //   padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //   width: null, // Set width to null to take the size of the text
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(15),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
    //     children: [
    //       Text("${widget.firstname}_${widget.lastname}"),
    //       Text("${widget.message}")
    //     ],
    //   ),
    // );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
    //   children: [
    //     Text("${widget.firstname}_${widget.lastname}"),
    //     Text("${widget.message}"),
    //   ],
    // );
    return Column(
      children: [
        Container(
          // alignment: Alignment.centerLeft,
          color: Colors.white,
          child: Text("salam cava"),
        )
      ],
    );
  }
}
