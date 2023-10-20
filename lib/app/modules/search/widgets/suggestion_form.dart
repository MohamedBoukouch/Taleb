import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/data/const_link.dart';

class suggestion extends StatefulWidget {
  String inputImage;
  suggestion({Key? key, required this.inputImage}) : super(key: key);

  @override
  State<suggestion> createState() => _suggestionState();
}

class _suggestionState extends State<suggestion> {
  late String inputImage = widget.inputImage;
  List<String> charArray = [];

  void splitString() {
    charArray = inputImage.split(',');
  }

  @override
  void initState() {
    super.initState();
    splitString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "$linkservername/Admin/publication/upload/${charArray[0]}",
          width: AppConstant.screenWidth,
          height: AppConstant.screenHeight,
          fit: BoxFit.cover,
        ),
        Container(
          width: AppConstant.screenWidth,
          height: AppConstant.screenHeight,
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    );
  }
}
