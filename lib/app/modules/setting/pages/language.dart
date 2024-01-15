import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/setting/widgets/type_language.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
              right: AppConstant.screenWidth * .15,
              left: AppConstant.screenWidth * .15),
          child: Column(
            children: [
              Type_language(text: "العربية"),
              SizedBox(
                height: 20,
              ),
              Type_language(text: "Francais"),
              SizedBox(
                height: 20,
              ),
              Type_language(text: "English"),
            ],
          ),
        ),
      ),
    );
  }
}
