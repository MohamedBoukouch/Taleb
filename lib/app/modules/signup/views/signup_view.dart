import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/signup/controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  final SignupController controller = Get.put(SignupController());

  static const Color _primary = Color(0xFF1565C0);
  static const Color _textLabel = Color(0xFF455A64);
  static const Color _textHint = Color(0xFFB0BEC5);

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
                  const SizedBox(height: 48),
                  _buildLogo(),
                  const SizedBox(height: 32),
                  Form(
                    key: _signupKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: 'First name',
                                hint: 'Youssef',
                                controller: _nomController,
                                icon: Icons.person_outline,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Required'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                label: 'Last name',
                                hint: 'Ait Ali',
                                controller: _prenomController,
                                icon: Icons.person_outline,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Required'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 24),
                        _buildPrimaryButton(
                          label: 'Create Account',
                          onTap: () async {
                            if (_signupKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              setState(() => _isLoading = true);
                              try {
                                await controller.signup(
                                  _nomController.text,
                                  _prenomController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              } catch (e) {
                                debugPrint(e.toString());
                              } finally {
                                setState(() => _isLoading = false);
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildDivider(),
                        const SizedBox(height: 20),
                        _buildGoogleButton(),
                        const SizedBox(height: 32),
                        _buildFooter(
                          text: 'Already have an account?  ',
                          actionText: 'Sign in',
                          onTap: () => Get.off(() => const LoginView()),
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
        const Text('Tawjihi',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: _primary,
                letterSpacing: -0.5)),
        const SizedBox(height: 4),
        const Text('Create your account',
            style: TextStyle(fontSize: 14, color: Colors.grey)),
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
            hintText: 'Min. 6 characters',
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
        onPressed: () {
          // TODO: Google Sign-Up
        },
        icon: Image.network(
          'https://www.google.com/favicon.ico',
          width: 18,
          height: 18,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.g_mobiledata, size: 22),
        ),
        label: const Text('Continue with Google',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF37474F))),
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
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFEEEEEE))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('or sign up with',
              style: TextStyle(fontSize: 12, color: Color(0xFFB0BEC5))),
        ),
        Expanded(child: Divider(color: Color(0xFFEEEEEE))),
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
