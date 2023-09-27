import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

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

  signup(
      String firstname, String lastname, String email, String password) async {
    var response = await _crud.postRequest(linksignup, {
      "firstname": firstname,
      "lastname": lastname,
      "email":email,
      "password": password,
    });
    if (response['status'] == "success") {
      Get.to(() => const HomeView());
    } else {
      print("signup fail");
    }
  }
}
