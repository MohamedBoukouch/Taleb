// lib/app/modules/notification/views/notification_view.dart

import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int _filterIndex = 0;

  static const _filters = ['Tout', 'Concours', 'Résultats'];

  static final List<_NotifItem> _notifications = [
    _NotifItem(
      id: '1',
      iconBg: Color(0xFFE6F1FB),
      iconColor: Color(0xFF0A66C2),
      badgeBg: Color(0xFF0A66C2),
      icon: Icons.emoji_events_rounded,
      badgeIcon: Icons.star_rounded,
      title: 'CSI 4★ Marco',
      body: '— Les inscriptions ferment dans 48h. Complétez votre dossier.',
      boldWords: ['CSI 4★ Marco', '48h'],
      time: 'Il y a 23 min',
      isUnread: true,
      section: 'AUJOURD\'HUI',
      category: 'Concours',
    ),
    _NotifItem(
      id: '2',
      iconBg: Color(0xFFEAF3DE),
      iconColor: Color(0xFF3B6D11),
      badgeBg: Color(0xFF639922),
      icon: Icons.show_chart_rounded,
      badgeIcon: Icons.check_rounded,
      title: 'Grand Prix Dressage',
      body: 'Résultats publiés — Vous êtes classé 3ème.',
      boldWords: ['Grand Prix Dressage', '3ème'],
      time: 'Il y a 1h',
      isUnread: true,
      category: 'Résultats',
    ),
    _NotifItem(
      id: '3',
      iconBg: Color(0xFFF1EFE8),
      iconColor: Color(0xFF5F5E5A),
      icon: Icons.group_rounded,
      title: 'Marco Concours',
      body: 'a ajouté 12 nouvelles photos à l\'album CSI Jumping.',
      boldWords: ['Marco Concours', 'CSI Jumping'],
      time: 'Il y a 3h',
      isUnread: false,
      category: 'Concours',
    ),
    _NotifItem(
      id: '4',
      iconBg: Color(0xFFFAEEDA),
      iconColor: Color(0xFFBA7517),
      badgeBg: Color(0xFFEF9F27),
      icon: Icons.notifications_rounded,
      badgeIcon: Icons.warning_amber_rounded,
      title: 'CCI Eventing 3★',
      body: 'Rappel — commence dans 3 jours.',
      boldWords: ['CCI Eventing 3★', '3 jours'],
      time: 'Lun, 7 Avr',
      isUnread: false,
      section: 'CETTE SEMAINE',
      category: 'Concours',
    ),
    _NotifItem(
      id: '5',
      iconBg: Color(0xFFEEEDFE),
      iconColor: Color(0xFF534AB7),
      icon: Icons.play_circle_outline_rounded,
      title: 'Grand Prix Freestyle',
      body: 'Live disponible — Rewatch 2h de compétition.',
      boldWords: ['Grand Prix Freestyle'],
      time: 'Dim, 6 Avr',
      isUnread: false,
      category: 'Résultats',
    ),
    _NotifItem(
      id: '6',
      iconBg: Color(0xFFFAECE7),
      iconColor: Color(0xFFD85A30),
      icon: Icons.favorite_rounded,
      title: 'Karim M.',
      body: 'et 24 autres ont aimé votre publication sur le CSI 4★.',
      boldWords: ['Karim M.', 'CSI 4★'],
      time: 'Sam, 5 Avr',
      isUnread: false,
      category: 'Concours',
    ),
  ];

  List<_NotifItem> get _filtered {
    if (_filterIndex == 0) return _notifications;
    final cat = _filters[_filterIndex];
    return _notifications.where((n) => n.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F0),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 48,
      leading: const BackButton(color: Color(0xFF444444)),
      title: const Text(
        'Notifications',
        style: TextStyle(
          color: Color(0xFF191919),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF444444)),
          onSelected: (val) {
            if (val == 'read_all') {
              setState(() {
                for (final n in _notifications) {
                  n.isUnread = false;
                }
              });
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'read_all',
              child: Text('Tout marquer comme lu'),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(41),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Filter tabs
              Row(
                children: List.generate(_filters.length, (i) {
                  final active = i == _filterIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _filterIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: active
                                ? const Color(0xFF0A66C2)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: active
                              ? const Color(0xFF0A66C2)
                              : const Color(0xFF666666),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    final items = _filtered;
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_outlined,
                size: 52, color: Color(0xFFCCCCCC)),
            SizedBox(height: 12),
            Text(
              'Aucune notification',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFAAAAAA),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Tout est à jour pour l\'instant.',
              style: TextStyle(fontSize: 13, color: Color(0xFFBBBBBB)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        final showSection = item.section != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSection)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
                child: Text(
                  item.section!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF888888),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            _NotifTile(item: item),
            const SizedBox(height: 1),
          ],
        );
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _NotifTile extends StatelessWidget {
  final _NotifItem item;
  const _NotifTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Unread accent bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 3,
              color:
                  item.isUnread ? const Color(0xFF0A66C2) : Colors.transparent,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 12),
                    Expanded(child: _buildContent()),
                    if (item.isUnread) ...[
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xFF0A66C2),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: item.iconBg,
          child: Icon(item.icon, color: item.iconColor, size: 20),
        ),
        if (item.badgeBg != null && item.badgeIcon != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: item.badgeBg,
              child: Icon(item.badgeIcon!, color: Colors.white, size: 10),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF444444),
              height: 1.4,
            ),
            children: _buildSpans(),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          item.time,
          style: TextStyle(
            fontSize: 12,
            fontWeight: item.isUnread ? FontWeight.w600 : FontWeight.normal,
            color: item.isUnread
                ? const Color(0xFF0A66C2)
                : const Color(0xFF888888),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildSpans() {
    final fullText = '${item.title} ${item.body}';
    final spans = <TextSpan>[];
    int cursor = 0;

    for (final word in item.boldWords) {
      final idx = fullText.indexOf(word, cursor);
      if (idx == -1) continue;
      if (idx > cursor) {
        spans.add(TextSpan(text: fullText.substring(cursor, idx)));
      }
      spans.add(TextSpan(
        text: word,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF191919),
        ),
      ));
      cursor = idx + word.length;
    }

    if (cursor < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(cursor)));
    }

    return spans;
  }
}

// ── Model ─────────────────────────────────────────────────────────────────────

class _NotifItem {
  final String id;
  final Color iconBg;
  final Color iconColor;
  final Color? badgeBg;
  final IconData icon;
  final IconData? badgeIcon;
  final String title;
  final String body;
  final List<String> boldWords;
  final String time;
  bool isUnread;
  final String? section;
  final String category;

  _NotifItem({
    required this.id,
    required this.iconBg,
    required this.iconColor,
    this.badgeBg,
    required this.icon,
    this.badgeIcon,
    required this.title,
    required this.body,
    required this.boldWords,
    required this.time,
    required this.isUnread,
    this.section,
    required this.category,
  });
}
