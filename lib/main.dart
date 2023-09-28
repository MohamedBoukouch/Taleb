import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taleb/app/data/binding/initialbinding.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding:initialBinding(),
      getPages: AppPages.routes,
    ),
  );
}
