import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class PdfForm extends StatefulWidget {
  String annee_scolaire;
  PdfForm({Key? key, required this.annee_scolaire}) : super(key: key);

  @override
  State<PdfForm> createState() => _PdfFormState();
}

class _PdfFormState extends State<PdfForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppConstant.screenWidth * .4,
          height: 150, // Adjust the height as needed
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 39, 153, 83),
              // border: Border.all(width: 2, color: Colors.red),
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset(
            "assets/icons/Pdf_icon.png",
            color: Colors.red,
          ),
        ),
        Center(
          child: Text(
            "${widget.annee_scolaire}",
            style: TextStyle(
                fontFamily: 'Bitter',
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ],
    );
  }
}
