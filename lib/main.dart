import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/data/binding/initialbinding.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'app/routes/app_pages.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: sharedpref.getString("id") == null ? '/login' : '/home',
      initialBinding: initialBinding(),
      getPages: AppPages.routes,
    ),
  );
}
