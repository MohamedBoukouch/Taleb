import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/datasource/static/splash_List.dart';
import 'package:taleb/app/modules/splash/controllers/splash_controller.dart';

class Body extends GetView<SplashControllerImp> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: PageView.builder(
        onPageChanged: (index) {
          // controller.
          print(index);
        },
        itemCount: SplashList.length,
        itemBuilder: (context, i) => Column(
          children: [
            Text(
              SplashList[i].titel!,
              style: const TextStyle(
                  fontFamily: 'Bitter',
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            Image.asset(
              SplashList[i].image!,
              width: AppConstant.screenWidth * .8,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            Container(
              width: double.infinity,
              child: Text(
                SplashList[i].text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bitter_italic', fontSize: 17, height: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
