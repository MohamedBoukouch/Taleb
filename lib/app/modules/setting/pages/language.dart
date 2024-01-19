import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/translations/localization/changelocal.dart';
import 'package:taleb/app/modules/setting/widgets/type_language.dart';
import 'package:taleb/app/shared/back.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final localeController _controller = Get.put(localeController());
  late String selectedLanguage; // Initial value

  @override
  void initState() {
    super.initState();
    // Retrieve the selected language from the controller
    selectedLanguage = _controller.selectedLanguage.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        title: Text("1".tr),
        leading: ButtonBack(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            right: AppConstant.screenWidth * .15,
            left: AppConstant.screenWidth * .15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TypeLanguage(
                text: "العربية",
                urlImage: "assets/flags/maroc.jpg",
                isSelected: selectedLanguage == "ar",
                onSelect: () {
                  setState(() {
                    selectedLanguage = "ar";
                    _controller.changeLang("ar");
                  });
                },
              ),
              SizedBox(height: 20),
              TypeLanguage(
                text: "English",
                urlImage: "assets/flags/englend.jpg",
                isSelected: selectedLanguage == "en",
                onSelect: () {
                  setState(() {
                    selectedLanguage = "en";
                    _controller.changeLang("en");
                  });
                },
              ),
              SizedBox(height: 20),
              TypeLanguage(
                text: "Francais",
                urlImage: "assets/flags/france.jpg",
                isSelected: selectedLanguage == "fr",
                onSelect: () {
                  setState(() {
                    selectedLanguage = "fr";
                    _controller.changeLang("fr");
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
