import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  Crud _crud = Crud();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getpublication() async {
    var response = await _crud.getRequest(linkshowpubli);
    return response;
  }
}
