import 'package:get/get.dart';

import '../controllers/concours_controller.dart';

class ConcoursBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConcoursController>(
      () => ConcoursController(),
    );
  }
}
