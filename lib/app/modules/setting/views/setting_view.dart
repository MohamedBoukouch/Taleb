import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';

class SettingView extends StatelessWidget {
  final String title;
  final String profileSectionLabel;
  final String accountSectionLabel;
  final String preferencesSectionLabel;
  final String supportSectionLabel;

  final String editProfileLabel;
  final String changePasswordLabel;
  final String emailAddressLabel;
  final String notificationsLabel;
  final String darkModeLabel;
  final String languageLabel;
  final String helpFaqLabel;
  final String privacyPolicyLabel;
  final String aboutLabel;
  final String logoutLabel;

  final String verifiedText;
  final String appVersion;

  final String editProfileDialogTitle;
  final String firstNameLabel;
  final String lastNameLabel;
  final String saveButtonText;
  final String cancelButtonText;

  final String changePasswordDialogTitle;
  final String currentPasswordLabel;
  final String newPasswordLabel;
  final String confirmPasswordLabel;
  final String updateButtonText;

  final String languagePickerTitle;
  final List<String> availableLanguages;

  final String logoutDialogTitle;
  final String logoutDialogMessage;

  final String successMessageProfile;
  final String successMessagePassword;
  final String errorMessagePassword;

  final String loadingText;

  const SettingView({
    Key? key,
    this.title = 'Settings',
    this.profileSectionLabel = 'Profile',
    this.accountSectionLabel = 'Account',
    this.preferencesSectionLabel = 'Preferences',
    this.supportSectionLabel = 'Support',
    this.editProfileLabel = 'Edit Profile',
    this.changePasswordLabel = 'Change Password',
    this.emailAddressLabel = 'Email Address',
    this.notificationsLabel = 'Notifications',
    this.darkModeLabel = 'Dark Mode',
    this.languageLabel = 'Language',
    this.helpFaqLabel = 'Help & FAQ',
    this.privacyPolicyLabel = 'Privacy Policy',
    this.aboutLabel = 'About Tawjihi',
    this.logoutLabel = 'Log Out',
    this.verifiedText = 'Verified',
    this.appVersion = 'v1.0.0',
    this.editProfileDialogTitle = 'Edit Profile',
    this.firstNameLabel = 'First Name',
    this.lastNameLabel = 'Last Name',
    this.saveButtonText = 'Save',
    this.cancelButtonText = 'Cancel',
    this.changePasswordDialogTitle = 'Change Password',
    this.currentPasswordLabel = 'Current Password',
    this.newPasswordLabel = 'New Password',
    this.confirmPasswordLabel = 'Confirm New Password',
    this.updateButtonText = 'Update',
    this.languagePickerTitle = 'Select Language',
    this.availableLanguages = const ['English', 'Français', 'العربية'],
    this.logoutDialogTitle = 'Log Out',
    this.logoutDialogMessage = 'Are you sure you want to log out?',
    this.successMessageProfile = 'Profile updated successfully',
    this.successMessagePassword = 'Password changed successfully',
    this.errorMessagePassword = 'Current password is incorrect',
    this.loadingText = 'Loading...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xFF1A237E),
            size: 18,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1565C0),
            ),
          );
        }
        return _SettingsBody(
          controller: controller,
          view: this,
        );
      }),
    );
  }
}

class _SettingsBody extends StatefulWidget {
  final SettingController controller;
  final SettingView view;

  const _SettingsBody({
    required this.controller,
    required this.view,
  });

  @override
  State<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        _ProfileCard(
          controller: widget.controller,
          verifiedText: widget.view.verifiedText,
          loadingText: widget.view.loadingText,
        ),
        const SizedBox(height: 20),
        _Section(
          label: widget.view.accountSectionLabel,
          children: [
            _NavTile(
              icon: Icons.person_outline_rounded,
              label: widget.view.editProfileLabel,
              onTap: () => _showEditProfileDialog(context),
            ),
            const _Divider(),
            _NavTile(
              icon: Icons.lock_outline_rounded,
              label: widget.view.changePasswordLabel,
              onTap: () => _showChangePasswordDialog(context),
            ),
            const _Divider(),
            _NavTile(
              icon: Icons.email_outlined,
              label: widget.view.emailAddressLabel,
              trailing: Obx(() => Text(
                    widget.controller.userEmail.value,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF78909C),
                    ),
                  )),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          label: widget.view.preferencesSectionLabel,
          children: [
            _SwitchTile(
              icon: Icons.notifications_outlined,
              label: widget.view.notificationsLabel,
              value: notificationsEnabled,
              onChanged: (v) => setState(() => notificationsEnabled = v),
            ),
            const _Divider(),
            _SwitchTile(
              icon: Icons.dark_mode_outlined,
              label: widget.view.darkModeLabel,
              value: darkModeEnabled,
              onChanged: (v) => setState(() => darkModeEnabled = v),
            ),
            const _Divider(),
            _NavTile(
              icon: Icons.language_outlined,
              label: widget.view.languageLabel,
              trailing: Text(
                selectedLanguage,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF78909C),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => _showLanguagePicker(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          label: widget.view.supportSectionLabel,
          children: [
            _NavTile(
              icon: Icons.help_outline_rounded,
              label: widget.view.helpFaqLabel,
              onTap: () {},
            ),
            const _Divider(),
            _NavTile(
              icon: Icons.privacy_tip_outlined,
              label: widget.view.privacyPolicyLabel,
              onTap: () {},
            ),
            const _Divider(),
            _NavTile(
              icon: Icons.info_outline_rounded,
              label: widget.view.aboutLabel,
              trailing: Text(
                widget.view.appVersion,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF78909C),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _LogoutButton(
          label: widget.view.logoutLabel,
          onTap: () => _confirmLogout(context),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final firstNameCtrl = TextEditingController(
      text: widget.controller.userFirstName.value,
    );
    final lastNameCtrl = TextEditingController(
      text: widget.controller.userLastName.value,
    );
    final formKey = GlobalKey<FormState>();
    final isLoading = false.obs;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          widget.view.editProfileDialogTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DialogField(
                controller: firstNameCtrl,
                label: widget.view.firstNameLabel,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              _DialogField(
                controller: lastNameCtrl,
                label: widget.view.lastNameLabel,
                icon: Icons.person_outline,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(widget.view.cancelButtonText),
          ),
          Obx(() => ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          try {
                            await widget.controller.updateProfile(
                              firstName: firstNameCtrl.text.trim(),
                              lastName: lastNameCtrl.text.trim(),
                            );
                            Get.back();
                            _showSuccessSnackbar(
                                widget.view.successMessageProfile);
                          } catch (e) {
                            _showErrorSnackbar(e.toString());
                          } finally {
                            isLoading.value = false;
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                ),
                child: isLoading.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(widget.view.saveButtonText),
              )),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isLoading = false.obs;
    final obscureCurrent = true.obs;
    final obscureNew = true.obs;
    final obscureConfirm = true.obs;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          widget.view.changePasswordDialogTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => _DialogField(
                    controller: currentPassCtrl,
                    label: widget.view.currentPasswordLabel,
                    icon: Icons.lock_outline,
                    obscureText: obscureCurrent.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureCurrent.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => obscureCurrent.toggle(),
                    ),
                  )),
              const SizedBox(height: 12),
              Obx(() => _DialogField(
                    controller: newPassCtrl,
                    label: widget.view.newPasswordLabel,
                    icon: Icons.lock_outline,
                    obscureText: obscureNew.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureNew.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => obscureNew.toggle(),
                    ),
                  )),
              const SizedBox(height: 12),
              Obx(() => _DialogField(
                    controller: confirmPassCtrl,
                    label: widget.view.confirmPasswordLabel,
                    icon: Icons.lock_outline,
                    obscureText: obscureConfirm.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirm.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => obscureConfirm.toggle(),
                    ),
                    validator: (v) {
                      if (v != newPassCtrl.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(widget.view.cancelButtonText),
          ),
          Obx(() => ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          try {
                            await widget.controller.updatePassword(
                              currentPassword: currentPassCtrl.text,
                              newPassword: newPassCtrl.text,
                            );
                            Get.back();
                            _showSuccessSnackbar(
                              widget.view.successMessagePassword,
                            );
                          } catch (e) {
                            _showErrorSnackbar(
                                widget.view.errorMessagePassword);
                          } finally {
                            isLoading.value = false;
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                ),
                child: isLoading.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(widget.view.updateButtonText),
              )),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              widget.view.languagePickerTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 12),
            for (final lang in widget.view.availableLanguages)
              ListTile(
                title: Text(
                  lang,
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: selectedLanguage == lang
                    ? const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF1565C0),
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() => selectedLanguage = lang);
                  Get.back();
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          widget.view.logoutDialogTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
        ),
        content: Text(
          widget.view.logoutDialogMessage,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF78909C),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(widget.view.cancelButtonText),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await widget.controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
            ),
            child: Text(widget.view.logoutLabel),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: const Color(0xFF43A047),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: const Color(0xFFE53935),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final SettingController controller;
  final String verifiedText;
  final String loadingText;

  const _ProfileCard({
    required this.controller,
    required this.verifiedText,
    required this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final initials = _getInitials();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE3F2FD),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userFullName.value.isNotEmpty
                        ? controller.userFullName.value
                        : loadingText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    controller.userEmail.value,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF78909C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 13,
                        color: Color(0xFF43A047),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        verifiedText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF43A047),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Color(0xFF1565C0),
                size: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );
    });
  }

  String _getInitials() {
    String result = '';
    if (controller.userFirstName.value.isNotEmpty) {
      result += controller.userFirstName.value[0];
    }
    if (controller.userLastName.value.isNotEmpty) {
      result += controller.userLastName.value[0];
    }
    return result.isEmpty ? '??' : result.toUpperCase();
  }
}

class _Section extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const _Section({
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF78909C),
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FBFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1565C0),
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF263238),
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFB0BEC5),
                  size: 20,
                ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1565C0),
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF263238),
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1565C0),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 64,
      endIndent: 16,
      color: Color(0xFFF0F0F0),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _LogoutButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: const Icon(
          Icons.logout_rounded,
          color: Color(0xFFE53935),
          size: 20,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE53935),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFFFFCDD2),
            width: 1.5,
          ),
          backgroundColor: const Color(0xFFFFF8F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _DialogField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator ?? (v) => v?.isEmpty ?? true ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
