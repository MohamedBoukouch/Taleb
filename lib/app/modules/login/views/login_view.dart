import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/checkemail.dart';
import 'package:taleb/app/modules/signup/views/signup_view.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final controller = Get.put(LoginController());

  bool _obscurePassword = true;
  bool _isLoading = false;

  static const Color _primary = Color(0xFF1565C0);
  static const Color _primaryLight = Color(0xFFE3F2FD);
  static const Color _textHint = Color(0xFFB0BEC5);
  static const Color _textLabel = Color(0xFF455A64);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  Form(
                    key: _loginKey,
                    child: Column(
                      children: [
                        _buildField(
                          label: 'Email address',
                          hint: 'you@example.com',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            if (!v.contains('@') || !v.contains('.'))
                              return 'Invalid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Get.to(() => CheckEmail()),
                            style: TextButton.styleFrom(
                              foregroundColor: _primary,
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPrimaryButton(
                            label: 'Sign In',
                            onTap: () async {
                              if (_loginKey.currentState!.validate()) {
                                setState(() => _isLoading = true);

                                try {
                                  await controller.login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );

                                  // ✅ SUCCESS → GO HOME
                                  Get.offAll(() => HomeView());
                                } catch (e) {
                                  String message = "Login failed";

                                  if (e
                                      .toString()
                                      .contains("EMAIL_NOT_VERIFIED")) {
                                    message = "Please verify your email first";
                                  } else if (e.toString().contains("Invalid")) {
                                    message = "Invalid email or password";
                                  }

                                  // 🔴 RED SNACKBAR
                                  Get.snackbar(
                                    "Error",
                                    message,
                                    backgroundColor: const Color(0xFFE53935),
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } finally {
                                  setState(() => _isLoading = false);
                                }
                              }
                            }),
                        const SizedBox(height: 20),
                        _buildDivider(),
                        const SizedBox(height: 20),
                        _buildGoogleButton(),
                        const SizedBox(height: 32),
                        _buildFooter(
                          text: "Don't have an account?  ",
                          actionText: 'Sign up',
                          onTap: () => Get.off(() => const SignupView()),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              const Icon(Icons.school_rounded, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 16),
        const Text(
          'Tawjihi',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: _primary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Welcome back',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _textLabel,
                letterSpacing: 0.3)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A237E)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: _textHint, fontSize: 13),
            prefixIcon: Icon(icon, color: const Color(0xFF1976D2), size: 18),
            filled: true,
            fillColor: const Color(0xFFF8FBFF),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE3F2FD), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE3F2FD), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _textLabel,
                letterSpacing: 0.3)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Required';
            if (v.length < 6) return 'Minimum 6 characters';
            return null;
          },
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A237E)),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: _textHint, fontSize: 13),
            prefixIcon: const Icon(Icons.lock_outline,
                color: Color(0xFF1976D2), size: 18),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: 18,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FBFF),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE3F2FD), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE3F2FD), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(
      {required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () async {
          await controller.signInWithGoogle();
        },
        icon: Image.network(
          'https://www.google.com/favicon.ico',
          width: 18,
          height: 18,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.g_mobiledata, size: 22),
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF37474F)),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('or continue with',
              style: TextStyle(fontSize: 12, color: Color(0xFFB0BEC5))),
        ),
        const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
      ],
    );
  }

  Widget _buildFooter(
      {required String text,
      required String actionText,
      required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        GestureDetector(
          onTap: onTap,
          child: Text(actionText,
              style: const TextStyle(
                  fontSize: 13, color: _primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: const Center(child: CircularProgressIndicator(color: _primary)),
    );
  }
}
