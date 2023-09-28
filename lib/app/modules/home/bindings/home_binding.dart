import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
