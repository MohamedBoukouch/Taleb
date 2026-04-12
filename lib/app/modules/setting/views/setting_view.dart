import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taleb/app/modules/home/pages/filter.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/main.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  static const Color _primary = Color(0xFF1565C0);
  static const Color _textSecondary = Color(0xFF78909C);

  final SettingController controller = Get.put(SettingController());

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF1A237E), size: 18),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // ── Profile Card ──────────────────────────────────
          _buildProfileCard(),
          const SizedBox(height: 20),

          // ── Account ───────────────────────────────────────
          _buildSectionLabel('Account'),
          _buildCard([
            _buildNavTile(
              icon: Icons.person_outline_rounded,
              label: 'Edit Profile',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavTile(
              icon: Icons.lock_outline_rounded,
              label: 'Change Password',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavTile(
              icon: Icons.email_outlined,
              label: 'Email Address',
              trailing: const Text(
                'boukouchmohamed7@gmail.com',
                style: TextStyle(fontSize: 12, color: _textSecondary),
              ),
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 16),

          // ── Preferences ───────────────────────────────────
          _buildSectionLabel('Preferences'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              label: 'Dark Mode',
              value: _darkModeEnabled,
              onChanged: (v) => setState(() => _darkModeEnabled = v),
            ),
            _buildDivider(),
            _buildNavTile(
              icon: Icons.language_outlined,
              label: 'Language',
              trailing: Text(
                _selectedLanguage,
                style: const TextStyle(
                    fontSize: 13,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () => _showLanguagePicker(),
            ),
          ]),
          const SizedBox(height: 16),

          // ── Support ───────────────────────────────────────
          _buildSectionLabel('Support'),
          _buildCard([
            _buildNavTile(
              icon: Icons.help_outline_rounded,
              label: 'Help & FAQ',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavTile(
              icon: Icons.privacy_tip_outlined,
              label: 'Privacy Policy',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavTile(
              icon: Icons.info_outline_rounded,
              label: 'About Tawjihi',
              trailing: const Text(
                'v1.0.0',
                style: TextStyle(fontSize: 12, color: _textSecondary),
              ),
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),

          // ── Logout Button ──────────────────────────────────
          _buildLogoutButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── Widgets ───────────────────────────────────────────────

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3F2FD), width: 1.5),
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
            child: const Center(
              child: Text(
                'MB',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohamed Boukouch',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'boukouchmohamed7@gmail.com',
                  style: TextStyle(fontSize: 12, color: _textSecondary),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.verified_rounded,
                        size: 13, color: Color(0xFF43A047)),
                    SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: TextStyle(
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
            icon: const Icon(Icons.edit_outlined, color: _primary, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
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
              child: Icon(icon, color: _primary, size: 18),
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
                const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFFB0BEC5), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
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
            child: Icon(icon, color: _primary, size: 18),
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
            activeColor: _primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 64,
      endIndent: 16,
      color: Color(0xFFF0F0F0),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 14, color: Color(0xFF78909C)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);

              // 👉 CALL CONTROLLER FUNCTION
              await controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () => _confirmLogout(),
        icon: const Icon(Icons.logout_rounded,
            color: Color(0xFFE53935), size: 20),
        label: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE53935),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFFCDD2), width: 1.5),
          backgroundColor: const Color(0xFFFFF8F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text('Select Language',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E))),
            const SizedBox(height: 12),
            for (final lang in ['English', 'Français', 'العربية'])
              ListTile(
                title: Text(lang, style: const TextStyle(fontSize: 14)),
                trailing: _selectedLanguage == lang
                    ? const Icon(Icons.check_rounded, color: _primary, size: 20)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = lang);
                  Navigator.pop(ctx);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
