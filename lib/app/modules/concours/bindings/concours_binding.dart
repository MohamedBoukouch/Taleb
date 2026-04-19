import 'package:get/get.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:taleb/app/modules/concours/controllers/concours_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register controllers that need to be available globally
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ConcoursController>(() => ConcoursController());
  }
}
