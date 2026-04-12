// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_rounded, 'label': 'Accueil'},
    {'icon': Icons.emoji_events_rounded, 'label': 'Concours'},
    {'icon': Icons.leaderboard_rounded, 'label': 'Classement'},
    {'icon': Icons.person_rounded, 'label': 'Profil'},
  ];

  // ─────────────────────────────────────────────────────────────────────
  // STATIC DATA — 10 Marco Concours posts
  // ─────────────────────────────────────────────────────────────────────

  static const List<PostModel> _posts = [
    PostModel(
      id: '1',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '15 Mar 2025',
      category: 'Dressage',
      description:
          'Retour en images sur le Grand Prix Freestyle qui a réuni les meilleurs '
          'cavaliers de dressage du pays. Des reprises libres sur musique d\'un niveau '
          'technique exceptionnel. Merci à tous les participants et au public venu en masse !',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1452378174528-3090a4bba7b2?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 342,
      // externalLink: 'https://www.fei.org/dressage',
    ),
    PostModel(
      id: '2',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '2 Avr 2025',
      category: 'Jumping',
      description:
          'Le CSI 4★ de Marco a accueilli plus de 200 chevaux internationaux. '
          'Le parcours final à 1m60 a mis à l\'épreuve les meilleurs binômes. '
          'Résultats complets disponibles sur notre site officiel.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1452378174528-3090a4bba7b2?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 519,
      // externalLink: 'https://www.fei.org/jumping',
    ),
    PostModel(
      id: '3',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '20 Avr 2025',
      category: 'Eventing',
      description:
          'Le CCI 3★ a testé l\'endurance et la polyvalence des couples en dressage, '
          'cross-country et saut d\'obstacles sur trois jours intenses. '
          'Un format exigeant que les cavaliers ont relevé avec brio.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1452378174528-3090a4bba7b2?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 287,
    ),
    PostModel(
      id: '4',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '10 Mai 2025',
      category: 'Voltige',
      description:
          'Spectacle époustouflant lors du championnat régional de voltige équestre. '
          'Les gymnastes ont réalisé des figures aériennes impressionnantes sur des '
          'chevaux au galop. Un moment inoubliable pour toute la famille.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1504169565947-0fb0b1fb2e9c?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 204,
      // externalLink: 'https://www.fei.org/vaulting',
    ),
    PostModel(
      id: '5',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '28 Mai 2025',
      category: 'Endurance',
      description:
          'La Coupe Marco d\'endurance a réuni 85 couples sur un tracé de 160 km '
          'à travers les montagnes. La victoire est revenue à l\'équipe espagnole '
          'après 10 heures de course. Une performance remarquable !',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 176,
    ),
    PostModel(
      id: '6',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '7 Juin 2025',
      category: 'Reining',
      description:
          'Premier concours de reining affilié NRHA organisé par Marco Concours. '
          'Les spins, sliding stops et lead changes ont subjugué le public venu nombreux. '
          'Prochaine édition en septembre — inscriptions ouvertes !',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 398,
      // externalLink: 'https://www.nrha.com',
    ),
    PostModel(
      id: '7',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '22 Juin 2025',
      category: 'Poney',
      description:
          'Encourager la relève est au cœur de la mission de Marco Concours. '
          'Ce trophée dédié aux cavaliers de 8 à 16 ans a réuni 120 jeunes talents '
          'en poney club. Bravo à tous les petits champions !',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1567306301408-9b74779a11af?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 451,
    ),
    PostModel(
      id: '8',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '14 Juil 2025',
      category: 'Dressage',
      description:
          'Épreuve qualificative pour les Jeux Olympiques. Les couples ont livré des '
          'performances de très haut niveau, avec plusieurs scores dépassant les 80 % '
          'en Grand Prix Spécial. Résultats et vidéos sur notre site officiel.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 623,
      // externalLink: 'https://www.fei.org',
    ),
    PostModel(
      id: '9',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '3 Août 2025',
      category: 'Attelage',
      description:
          'Le CAI 3★ d\'attelage a mis en scène des carrioles à deux et quatre chevaux '
          'dans les épreuves de dressage, marathon et maniabilité. '
          'Ambiance électrique garantie et public conquis du début à la fin.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1474511320723-9a56873867b5?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 267,
      // externalLink: 'https://www.fei.org/driving',
    ),
    PostModel(
      id: '10',
      authorName: 'Marco Concours',
      authorSubtitle: 'Organisation équestre officielle · 12k abonnés',
      publishedAt: '20 Sep 2025',
      category: 'Multi-discipline',
      description:
          'L\'événement phare de l\'année ! La Finale Nationale regroupe les meilleurs '
          'qualifiés de toutes les disciplines pour une clôture de saison inoubliable. '
          'Rendez-vous le 20 septembre dans notre complexe équestre. '
          'Places limitées — réservez dès maintenant via le lien ci-dessous.',
      media: [
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1452378174528-3090a4bba7b2?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?w=900&q=80',
          type: PostMediaType.image,
        ),
        PostMedia(
          url:
              'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=900&q=80',
          type: PostMediaType.image,
        ),
      ],
      likes: 891,
      // externalLink: 'https://marcoconcours.com/finale-2025',
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────
  // NAV CONFIG
  // ─────────────────────────────────────────────────────────────────────

  // static const _navItems = [
  //   (icon: Icons.home_rounded,            label: 'Accueil'),
  //   (icon: Icons.emoji_events_rounded,    label: 'Concours'),
  //   (icon: Icons.leaderboard_rounded,     label: 'Classement'),
  //   (icon: Icons.person_rounded,          label: 'Profil'),
  // ];

  // ─────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F0),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (index) {
          setState(() {
            _navIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0A66C2),
        unselectedItemColor: const Color(0xFF999999),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_rounded),
            label: 'Concours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Classement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_navIndex) {
      case 0:
        return _buildFeed();

      case 1:
        return _buildPlaceholder(); // Concours

      case 2:
        return _buildPlaceholder(); // Classement

      case 3:
        return const SettingView(); // 👈 HERE
      default:
        return _buildFeed();
    }
  }

  // ── APP BAR ─────────────────────────────────────────────────────────────

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
            child: const Icon(Icons.emoji_events_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Marco Concours',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Actualités équestres',
                style: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 11,
                ),
              ),
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
          onPressed: () {
            Get.to(() => NotificationView());
          },
        ),
        const SizedBox(width: 4),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFFE0E0E0)),
      ),
    );
  }

  // ── FEED ────────────────────────────────────────────────────────────────

  Widget _buildFeed() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _posts.length,
      itemBuilder: (_, i) => PostCard(post: _posts[i]),
    );
  }

  // ── PLACEHOLDER ─────────────────────────────────────────────────────────

  Widget _buildPlaceholder() {
    final item = _navItems[_navIndex];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item['icon'], size: 56, color: const Color(0xFFCCCCCC)),
          const SizedBox(height: 12),
          Text(
            item['label'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFFAAAAAA),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Bientôt disponible',
            style: TextStyle(fontSize: 14, color: Color(0xFFBBBBBB)),
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ──────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: List.generate(_navItems.length, (i) {
              final active = i == _navIndex;
              final item = _navItems[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _navIndex = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Active indicator line
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2,
                        width: active ? 28 : 0,
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A66C2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Icon(
                        item['icon'],
                        size: 22,
                        color: active
                            ? const Color(0xFF0A66C2)
                            : const Color(0xFF999999),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item['label'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.w400,
                          color: active
                              ? const Color(0xFF0A66C2)
                              : const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
