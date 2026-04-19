import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/model/concours_model.dart';
import 'package:taleb/app/modules/concours/controllers/concours_controller.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';
import 'pdf_reader_view.dart';

// ─────────────────────────────────────────────
//  SEARCH BAR
// ─────────────────────────────────────────────
class ConcoursSearchBar extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  const ConcoursSearchBar(
      {Key? key, required this.controller, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1F2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 3))
                ],
          border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : const Color(0xFFE5E7EB)),
        ),
        child: TextField(
          onChanged: controller.setSearch,
          style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF111827),
              fontSize: 14,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: 'Rechercher un concours...',
            hintStyle: TextStyle(
                color: isDark ? Colors.white30 : const Color(0xFF9CA3AF),
                fontSize: 14),
            prefixIcon: Icon(Icons.search_rounded,
                color: isDark ? Colors.white38 : const Color(0xFF6366F1),
                size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  NIVEAU CHIPS
// ─────────────────────────────────────────────
class NiveauChips extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  const NiveauChips({Key? key, required this.controller, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: controller.niveaux.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final niveau = controller.niveaux[i];
            return Obx(() {
              final selected = controller.selectedNiveau.value == niveau;
              return GestureDetector(
                onTap: () => controller.setNiveau(niveau),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF6366F1)
                        : (isDark
                            ? Colors.white.withOpacity(0.07)
                            : Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected
                            ? const Color(0xFF6366F1)
                            : (isDark
                                ? Colors.white.withOpacity(0.1)
                                : const Color(0xFFE5E7EB))),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                                color:
                                    const Color(0xFF6366F1).withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3))
                          ]
                        : [],
                  ),
                  child: Text(niveau,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : (isDark
                                  ? Colors.white60
                                  : const Color(0xFF6B7280)))),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DOMAINE CHIPS
// ─────────────────────────────────────────────
class DomaineChips extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  const DomaineChips({Key? key, required this.controller, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: controller.domaines.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final domaine = controller.domaines[i];
            return Obx(() {
              final selected = controller.selectedDomaine.value == domaine;
              return GestureDetector(
                onTap: () => controller.setDomaine(domaine),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF10B981)
                        : (isDark
                            ? Colors.white.withOpacity(0.07)
                            : Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected
                            ? const Color(0xFF10B981)
                            : (isDark
                                ? Colors.white.withOpacity(0.1)
                                : const Color(0xFFE5E7EB))),
                  ),
                  child: Text(domaine,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : (isDark
                                  ? Colors.white60
                                  : const Color(0xFF6B7280)))),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TYPE FILTERS
// ─────────────────────────────────────────────
class TypeFilters extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  const TypeFilters({Key? key, required this.controller, required this.isDark})
      : super(key: key);

  static const Map<ConcoursType?, Map<String, dynamic>> _typeLabels = {
    null: {'label': 'Tous', 'icon': Icons.grid_view_rounded},
    ConcoursType.cycle: {'label': 'Cycle', 'icon': Icons.school_rounded},
    ConcoursType.master: {
      'label': 'Master',
      'icon': Icons.workspace_premium_rounded
    },
    ConcoursType.licence: {'label': 'Licence', 'icon': Icons.menu_book_rounded},
    ConcoursType.doctorat: {'label': 'Doctorat', 'icon': Icons.science_rounded},
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: SizedBox(
        height: 36,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          children: _typeLabels.entries.map((e) {
            return Obx(() {
              final selected = controller.selectedType.value == e.key;
              final label = e.value['label'] as String;
              final icon = e.value['icon'] as IconData;
              return GestureDetector(
                onTap: () => controller.setType(e.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF0D1B2A)
                        : (isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFF3F4F6)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(icon,
                          size: 13,
                          color: selected
                              ? Colors.white70
                              : (isDark
                                  ? Colors.white38
                                  : const Color(0xFF9CA3AF))),
                      const SizedBox(width: 5),
                      Text(label,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : (isDark
                                      ? Colors.white38
                                      : const Color(0xFF6B7280)))),
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  RESULT COUNT
// ─────────────────────────────────────────────
class ResultCount extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  const ResultCount({Key? key, required this.controller, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final count = controller.concoursList.length;
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$count résultat${count != 1 ? 's' : ''}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white30 : const Color(0xFF9CA3AF))),
            if (controller.selectedNiveau.value != 'Tous' ||
                controller.selectedType.value != null ||
                controller.selectedDomaine.value != 'Tous' ||
                controller.searchQuery.value.isNotEmpty)
              GestureDetector(
                onTap: controller.clearFilters,
                child: const Text('Effacer filtres',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFEF4444))),
              ),
          ],
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────
//  CONCOURS CARD
// ─────────────────────────────────────────────
class ConcoursCard extends StatelessWidget {
  final Concours concours;
  final bool isDark;
  const ConcoursCard({Key? key, required this.concours, required this.isDark})
      : super(key: key);

  String _formatDate(DateTime date) {
    const months = [
      '',
      'Jan',
      'Fév',
      'Mar',
      'Avr',
      'Mai',
      'Jun',
      'Jul',
      'Aoû',
      'Sep',
      'Oct',
      'Nov',
      'Déc'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Safe find — FavoriteController registered in ConcoursView before this builds
    final favCtrl = Get.find<FavoriteController>();
    final id = concours.id ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1F2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ]
            : [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 4))
              ],
        border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : const Color(0xFFF3F4F6)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Get.to(
              () => PdfReaderView(title: concours.title, url: concours.url)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top row ──────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: concours.domaineColor
                            .withOpacity(isDark ? 0.25 : 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(concours.logoInitial,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: concours.domaineColor,
                              letterSpacing: 0.5)),
                    ),
                    const SizedBox(width: 12),

                    // Title + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(concours.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0D1B2A),
                                  height: 1.3)),
                          const SizedBox(height: 3),
                          Text('Ajouté le ${_formatDate(concours.createdAt)}',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white54
                                      : const Color(0xFF9CA3AF))),
                        ],
                      ),
                    ),

                    // ✅ Heart toggle — fixed: passes both id AND type
                    Obx(() {
                      final isFav = favCtrl.isFavorited(id,
                          type: 'concours'); // ✅ type param
                      return GestureDetector(
                        onTap: () => favCtrl.toggleFavorite(id, 'concours'),
                        child: TweenAnimationBuilder<double>(
                          key: ValueKey(isFav), // ✅ force rebuild on change
                          tween: Tween(begin: 0.8, end: 1.0),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.elasticOut,
                          builder: (_, scale, child) =>
                              Transform.scale(scale: scale, child: child),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isFav
                                  ? const Color(0xFFEF4444)
                                      .withOpacity(isDark ? 0.2 : 0.1)
                                  : (isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : const Color(0xFFF9FAFB)),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isFav
                                    ? const Color(0xFFEF4444).withOpacity(0.5)
                                    : (isDark
                                        ? Colors.white.withOpacity(0.08)
                                        : const Color(0xFFE5E7EB)),
                              ),
                            ),
                            child: Icon(
                              isFav
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 18,
                              color: isFav
                                  ? const Color(0xFFEF4444)
                                  : (isDark
                                      ? Colors.white38
                                      : const Color(0xFFCBD5E1)),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 14),
                Divider(
                    color: isDark
                        ? Colors.white.withOpacity(0.07)
                        : const Color(0xFFF3F4F6),
                    height: 1),
                const SizedBox(height: 12),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _Tag(
                        label: concours.niveau.toUpperCase(),
                        color: const Color(0xFF6366F1),
                        isDark: isDark),
                    _Tag(
                        label: concours.type.displayName,
                        color: concours.domaineColor,
                        isDark: isDark),
                    _Tag(
                      label: concours.domaine.isNotEmpty
                          ? concours.domaine[0].toUpperCase() +
                              concours.domaine.substring(1)
                          : 'Non spécifié',
                      color: const Color(0xFF0891B2),
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Bottom row
                Row(
                  children: [
                    Icon(Icons.picture_as_pdf_rounded,
                        size: 13,
                        color:
                            isDark ? Colors.white30 : const Color(0xFF9CA3AF)),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text('Google Drive',
                          style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? Colors.white38
                                  : const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis),
                    ),
                    const Text('Voir PDF',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6366F1))),
                    const SizedBox(width: 3),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 10, color: Color(0xFF6366F1)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAG
// ─────────────────────────────────────────────
class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  const _Tag({required this.label, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.18 : 0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? color.withOpacity(0.9) : color)),
    );
  }
}

// ─────────────────────────────────────────────
//  LOADING
// ─────────────────────────────────────────────
class ConcoursLoading extends StatelessWidget {
  final bool isDark;
  const ConcoursLoading({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
              color: isDark ? Colors.white70 : const Color(0xFF6366F1)),
          const SizedBox(height: 16),
          Text('Chargement des concours...',
              style: TextStyle(
                  color: isDark ? Colors.white54 : const Color(0xFF9CA3AF))),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ERROR
// ─────────────────────────────────────────────
class ConcoursError extends StatelessWidget {
  final ConcoursController controller;
  final bool isDark;
  final Future<void> Function() onRetry;
  const ConcoursError(
      {Key? key,
      required this.controller,
      required this.isDark,
      required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 56,
                color: isDark ? Colors.white24 : const Color(0xFFCCCCCC)),
            const SizedBox(height: 16),
            Text('Impossible de charger les concours',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : const Color(0xFF444444)),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Obx(() => Text(controller.errorMessage.value,
                style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : const Color(0xFF999999)),
                textAlign: TextAlign.center)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  EMPTY
// ─────────────────────────────────────────────
class ConcoursEmpty extends StatelessWidget {
  final bool isDark;
  const ConcoursEmpty({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              size: 52,
              color: isDark ? Colors.white12 : const Color(0xFFD1D5DB)),
          const SizedBox(height: 14),
          Text('Aucun concours trouvé',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white30 : const Color(0xFF9CA3AF))),
        ],
      ),
    );
  }
}
