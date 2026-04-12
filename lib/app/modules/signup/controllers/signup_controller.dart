import 'package:get/get.dart';
import 'package:taleb/app/data/Api/auth_service.dart';
import 'package:taleb/app/data/Crud.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  final AuthService _authService = AuthService();

  final Crud _crud = Crud();

  final count = 0.obs;

  void increment() => count.value++;

  Future<void> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      await _authService.signup(
        email: email.trim(),
        password: password.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
      );

      Get.snackbar(
        "Success",
        "Check your email to verify your account 📧",
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
