import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 0,
      body: Container(),
    );
  }
}
