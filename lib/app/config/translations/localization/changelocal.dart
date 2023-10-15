import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/services/services.dart';

class localeController extends GetxController {
  Locale? Language;
  MyServices myservice = Get.put(MyServices());

  changeLang(String langcode) {
    Locale local = Locale(langcode);
    myservice.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(local);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    String? SharedPrefLang = myservice.sharedPreferences.getString("lang");
    if (SharedPrefLang == "ar") {
      Language = const Locale("ar");
    } else if (SharedPrefLang == "en") {
      Language = const Locale("en");
    } else {
      Language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
