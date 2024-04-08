import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef StringValidator = String? Function(String?);

class Edittext extends StatefulWidget {
  final String? hint;
  final bool? ispassword;
  final bool? isemail;
  final bool readonly;
  final Icon? icon;
  final bool? enable;
  final TextEditingController Controller;
  final StringValidator? validator;
  final Function(dynamic value)? onSaved;
  Edittext({
    // super.key,
    this.hint,
    this.ispassword,
    this.isemail,
    required this.readonly,
    this.icon,
    this.enable,
    required this.Controller,
    this.validator,
    this.onSaved,
  });

  @override
  State<Edittext> createState() => _EdittextState();
}

class _EdittextState extends State<Edittext> {
  bool _eyeactive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        enabled: true,
        controller: widget.Controller,
        readOnly: widget.readonly,
        validator: widget.validator,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14 // Set the text color to red
        ),
        obscureText: widget.ispassword == true
            ? _eyeactive == true
                ? false
                : true
            : false,
        keyboardType:
            widget.isemail == true ? TextInputType.emailAddress : null,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Color(0xFF555353),
          ),
          labelStyle: TextStyle(color: Colors.black),
          errorStyle: GoogleFonts.poppins(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            //letterSpacing: .5,
          ),
          hintText: widget.hint,
          prefixIcon: widget.icon,
          suffixIcon: widget.ispassword == true
              ? InkWell(
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
                )
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3, //<-- SEE HERE
              color: const Color.fromARGB(132, 255, 153, 0),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 1, //<-- SEE HERE
              //color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3, //<-- SEE HERE
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2, //<-- SEE HERE
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
