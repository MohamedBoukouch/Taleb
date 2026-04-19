import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:http/http.dart' as http;

class SettingController extends GetxController {
  final count = 0.obs;
  void increment() => count.value++;

  // Observable user data from Supabase
  var userId = ''.obs;
  var userEmail = ''.obs;
  var userFirstName = ''.obs;
  var userLastName = ''.obs;
  var userFullName = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fetch user data directly from Supabase Auth
  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        userId.value = user.id;
        userEmail.value = user.email ?? '';
        userFirstName.value = user.userMetadata?['first_name'] ?? '';
        userLastName.value = user.userMetadata?['last_name'] ?? '';

        // For Google login, try to get name from full_name
        if (userFirstName.value.isEmpty && userLastName.value.isEmpty) {
          final fullName = user.userMetadata?['full_name'] ?? '';
          if (fullName.isNotEmpty) {
            final names = fullName.toString().split(' ');
            userFirstName.value = names.first;
            userLastName.value = names.skip(1).join(' ');
          }
        }

        userFullName.value =
            '${userFirstName.value} ${userLastName.value}'.trim();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // UPDATE PASSWORD - Dynamic with current password verification
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // First verify current password by attempting to sign in
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: userEmail.value,
        password: currentPassword,
      );

      if (response.user == null) {
        throw Exception('Current password is incorrect');
      }

      // Update password
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      return true;
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  // UPDATE PROFILE - Dynamic first/last name
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {
            'first_name': firstName,
            'last_name': lastName,
          },
        ),
      );

      if (response.user != null) {
        // Update local observables
        userFirstName.value = firstName;
        userLastName.value = lastName;
        userFullName.value = '$firstName $lastName'.trim();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  // Refresh user data
  Future<void> refreshUserData() async {
    await fetchUserData();
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      userId.value = '';
      userEmail.value = '';
      userFirstName.value = '';
      userLastName.value = '';
      userFullName.value = '';

      Get.offAll(() => const LoginView());
    } catch (e) {
      Get.snackbar("Error", "Logout failed",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
