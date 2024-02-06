import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class TypeLanguage extends StatefulWidget {
  final String text;
  final String urlImage;
  final bool isSelected;
  final VoidCallback onSelect;

  TypeLanguage({
    Key? key,
    required this.text,
    required this.urlImage,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<TypeLanguage> createState() => _TypeLanguageState();
}

class _TypeLanguageState extends State<TypeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstant.screenWidth,
      height: AppConstant.screenHeight * .07,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isSelected ? Colors.blue : Color(0xFFD9D9D9),
          width: 1,
        ),
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ListTile(
        leading: Container(
          child: Image.asset(
            widget.urlImage,
            width: 30,
          ),
        ),
        title: Text(
          widget.text,
          style: TextStyle(
            color: widget.isSelected ? Colors.blue : Colors.black,
            fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Radio(
          value: widget.text,
          groupValue: widget.isSelected ? widget.text : null,
          onChanged: (value) {
            widget.onSelect();
          },
        ),
      ),
    );
  }
}
