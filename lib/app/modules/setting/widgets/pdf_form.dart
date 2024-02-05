import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class PdfForm extends StatefulWidget {
  const PdfForm({Key? key}) : super(key: key);

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
          height: 170, // Adjust the height as needed
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 153, 83),
              border: Border.all(width: 2, color: Colors.red),
              borderRadius: BorderRadius.circular(15)),
        ),
        Center(
          child: Text("2021/2023"),
        )
      ],
    );
  }
}
