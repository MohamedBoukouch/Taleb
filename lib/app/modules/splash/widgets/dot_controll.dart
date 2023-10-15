import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/datasource/static/splash_List.dart';
import 'package:taleb/app/modules/splash/controllers/splash_controller.dart';

class DotControll extends StatelessWidget {
  const DotControll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GetBuilder<SplashControllerImp>(
        builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              SplashList.length,
              (index) => AnimatedContainer(
                margin: EdgeInsets.only(right: 5),
                duration: const Duration(microseconds: 900),
                width: controller.currentpage == index ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
