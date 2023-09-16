import 'package:get/get.dart';

import '../controllers/init_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitController>(
      () => InitController(),
    );
  }
}
