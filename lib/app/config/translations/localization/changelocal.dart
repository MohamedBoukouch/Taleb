import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/function/fctconfing.dart';
import 'package:taleb/app/config/services/services.dart';

class localeController extends GetxController {
  Locale? Language;
  MyServices myservice = Get.put(MyServices());

  // Add a variable to store the selected language
  RxString selectedLanguage = "".obs;

  changeLang(String langcode) {
    Locale local = Locale(langcode);
    myservice.sharedPreferences.setString("lang", langcode);

    // Store the selected language using GetX reactive variable
    selectedLanguage.value = langcode;

    Get.updateLocale(local);
  }

  @override
  void onInit() {
    fctconfing();
    requestpermissionnotification();

    // Retrieve the selected language from SharedPreferences
    String? sharedPrefLang = myservice.sharedPreferences.getString("lang");

    // Use the selectedLanguage variable to store the selected language
    selectedLanguage.value = sharedPrefLang ?? Get.deviceLocale!.languageCode;

    // Use the selected language to set the Locale
    Language = Locale(selectedLanguage.value);
    if (sharedPrefLang == "ar") {
      Language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      Language = const Locale("en");
    } else if (sharedPrefLang == "fr") {
      Language = const Locale("fr");
    } else {
      Language = Locale(Get.deviceLocale!.languageCode);
    }

    super.onInit();
  }
}
