import 'package:get/get.dart';

abstract class SplashController extends GetxController {
  // TODO: Implement SplashController

  next();
  onPageChanged(int index);
}

class SplashControllerImp extends SplashController {
  int currentpage = 0;

  @override
  void next() {
    // Implement your next() logic here.
  }

  @override
  void onPageChanged(int index) {
    currentpage = index;
    update();
    // super.onPageChanged(index);
  }
}
