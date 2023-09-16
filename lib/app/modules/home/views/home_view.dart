import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 1,
        body: ListView(
          children: <Widget>[
            Slidere(),
          ],
        ));
  }
}
