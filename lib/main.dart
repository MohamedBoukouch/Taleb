import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/config/services/services.dart';
import 'package:taleb/app/config/translations/localization/changelocal.dart';
import 'package:taleb/app/config/translations/localization/my_translation.dart';
import 'package:taleb/app/data/binding/initialbinding.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  sharedpref = await SharedPreferences.getInstance();
  localeController controller = Get.put(localeController());
  runApp(
    GetMaterialApp(
      title: "Application",
      translations: MyTranslation(),
      locale: controller.Language,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Bitter', fontWeight: FontWeight.bold, fontSize: 40),
          bodyText1: TextStyle(
              fontFamily: 'Bitter_italic',
              fontSize: 17,
              height: 2,
              color: Colors.white),
        ),
      ),

      initialRoute: AppPages.INITIAL,
      // initialRoute: sharedpref.getString("id") == null ? '/login' : '/home',
      initialBinding: initialBinding(),
      getPages: AppPages.routes,
    ),
  );
}
