import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';

class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  
  }
}
