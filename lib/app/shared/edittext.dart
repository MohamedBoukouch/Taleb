import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Edittext extends StatefulWidget {
  final String? hint;
  final bool? ispassword;
  final bool? isemail;
  final Icon? icon;
  Edittext({
    // super.key,
    this.hint,
    this.ispassword,
    this.isemail,
    this.icon,
  });

  @override
  State<Edittext> createState() => _EdittextState();
}

class _EdittextState extends State<Edittext> {
  bool _eyeactive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: widget.ispassword == true
            ? _eyeactive == true
                ? false
                : true
            : false,
        keyboardType:
            widget.isemail == true ? TextInputType.emailAddress : null,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.icon,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _eyeactive = !_eyeactive;
              });
            },
            child: Icon(
              widget.ispassword == false
                  ? null
                  : _eyeactive == true
                      ? Icons.visibility_off
                      : Icons.visibility,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3, //<-- SEE HERE
              color: const Color.fromARGB(255, 240, 177, 105),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2, //<-- SEE HERE
              color: Color.fromARGB(255, 7, 199, 225),
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
