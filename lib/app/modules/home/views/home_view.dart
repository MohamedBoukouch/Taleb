import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/post_card.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/app/modules/setting/views/setting_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _navIndex = 0;

  // Initialize controller once
  final HomeController _controller = Get.put(HomeController());

  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_rounded, 'label': 'Accueil'},
    {'icon': Icons.emoji_events_rounded, 'label': 'Concours'},
    {'icon': Icons.leaderboard_rounded, 'label': 'Classement'},
    {'icon': Icons.person_rounded, 'label': 'Profil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F0),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0A66C2),
        unselectedItemColor: const Color(0xFF999999),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_rounded), label: 'Concours'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_rounded), label: 'Classement'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_navIndex) {
      case 0:
        return _buildFeed();
      case 1:
        return _buildPlaceholder();
      case 2:
        return _buildPlaceholder();
      case 3:
        return const SettingView();
      default:
        return _buildFeed();
    }
  }

  // ── FEED ──────────────────────────────────────────────────────────────────

  Widget _buildFeed() {
    return Obx(() {
      // Loading state
      if (_controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF0A66C2)),
        );
      }

      // Error state
      if (_controller.hasError.value) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off_rounded,
                    size: 56, color: Color(0xFFCCCCCC)),
                const SizedBox(height: 16),
                const Text(
                  'Impossible de charger les posts',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF444444)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _controller.errorMessage.value,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF999999)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _controller.fetchPosts,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Réessayer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A66C2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // Empty state
      if (_controller.posts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.article_outlined,
                  size: 56, color: Color(0xFFCCCCCC)),
              const SizedBox(height: 12),
              const Text('Aucun post disponible',
                  style: TextStyle(fontSize: 16, color: Color(0xFFAAAAAA))),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _controller.fetchPosts,
                child: const Text('Actualiser'),
              ),
            ],
          ),
        );
      }

      // Posts list with pull-to-refresh
      return RefreshIndicator(
        color: const Color(0xFF0A66C2),
        onRefresh: _controller.fetchPosts,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _controller.posts.length,
          itemBuilder: (_, i) => PostCard(post: _controller.posts[i]),
        ),
      );
    });
  }

  // ── APP BAR ───────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF0A66C2),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.school_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tawjihi',
                  style: TextStyle(
                      color: Color(0xFF191919),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Text('Actualités',
                  style: TextStyle(color: Color(0xFF888888), fontSize: 11)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF444444)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: Color(0xFF444444)),
          onPressed: () => Get.to(() => NotificationView()),
        ),
        const SizedBox(width: 4),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFFE0E0E0)),
      ),
    );
  }

  Widget _buildPlaceholder() {
    final item = _navItems[_navIndex];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item['icon'], size: 56, color: const Color(0xFFCCCCCC)),
          const SizedBox(height: 12),
          Text(item['label'],
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFAAAAAA))),
          const SizedBox(height: 6),
          const Text('Bientôt disponible',
              style: TextStyle(fontSize: 14, color: Color(0xFFBBBBBB))),
        ],
      ),
    );
  }
}
