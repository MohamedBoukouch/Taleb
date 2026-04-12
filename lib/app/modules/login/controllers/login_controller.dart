import 'package:get/get.dart';
import 'package:taleb/app/data/Api/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;

      if (session != null) {
        print("User logged in!");
        // 👉 You can navigate here if you want
        Get.offAll(() => HomeView());
      }
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final User user = await _authService.login(
      email: email,
      password: password,
    );

    // ✅ CHECK EMAIL VERIFIED
    if (user.emailConfirmedAt == null) {
      throw Exception("EMAIL_NOT_VERIFIED");
    }
  }

  Future<void> signInWithGoogle() async {
    await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.taleb.app://login-callback',
    );
  }
}
