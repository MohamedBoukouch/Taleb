import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // SIGNUP
  Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'last_name': lastName,
      },
    );

    if (res.user == null) {
      throw Exception("Signup failed");
    }
  }

  // LOGIN
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = res.user;

    if (user == null) {
      throw Exception("Invalid email or password");
    }

    return user;
  }
}
