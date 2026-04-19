import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/post_service.dart';
import 'package:taleb/app/data/model/concours_model.dart';
import 'package:taleb/app/modules/concours/widgets/pdf_reader_view.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F1117) : const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // APP BAR
          SliverAppBar(
            expandedHeight: 110,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF1C1F2E) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mes Favoris',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Obx(() => Text(
                        '${controller.filteredItems.length} élément(s)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color:
                              isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      )),
                ],
              ),
            ),
            actions: [
              Obx(() => controller.isSelectionMode.value
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: controller.deleteSelected,
                    )
                  : IconButton(
                      icon: Icon(Icons.checklist_rtl_rounded,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF475569)),
                      onPressed: controller.toggleSelectionMode,
                    )),
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: isDark
                    ? Colors.white.withOpacity(0.07)
                    : const Color(0xFFE2E8F0),
              ),
            ),
          ),

          // TYPE FILTER CHIPS
          SliverToBoxAdapter(
            child: _buildTypeFilters(controller, isDark),
          ),

          // LIST
          Obx(() {
            if (controller.isLoading.value) {
              return _buildShimmerLoading(isDark);
            }
            if (controller.hasError.value) {
              return _buildErrorState(controller, isDark);
            }
            final items = controller.filteredItems;
            if (items.isEmpty) {
              return _buildEmptyState(isDark);
            }
            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    final String id =
                        item is Concours ? (item.id ?? '') : item.id;

                    return _FavoriteCard(
                      item: item,
                      isDark: isDark,
                      isSelectionMode: controller.isSelectionMode.value,
                      isSelected: controller.selectedIds.contains(id),
                      onSelect: () => controller.toggleSelection(id),
                      onTap: () {
                        if (item is Concours) {
                          Get.to(() =>
                              PdfReaderView(title: item.title, url: item.url));
                        }
                        // For posts, navigate to post detail or do nothing
                      },
                      onRemove: () => controller.removeFromFavorites(item),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTypeFilters(FavoriteController controller, bool isDark) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.typeOptions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final option = controller.typeOptions[index];
          return Obx(() {
            final isSelected = controller.selectedType.value == option['key'];
            return GestureDetector(
              onTap: () => controller.setFilter(option['key'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : (isDark
                          ? Colors.white.withOpacity(0.07)
                          : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : (isDark
                            ? Colors.white.withOpacity(0.1)
                            : const Color(0xFFE2E8F0)),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3))
                        ]
                      : [],
                ),
                child: Row(
                  children: [
                    Icon(
                      option['icon'] as IconData,
                      size: 15,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white54 : const Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      option['label'] as String,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? Colors.white54
                                  : const Color(0xFF64748B))),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildShimmerLoading(bool isDark) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 110,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          childCount: 5,
        ),
      ),
    );
  }

  Widget _buildErrorState(FavoriteController controller, bool isDark) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_rounded,
                size: 64,
                color: isDark ? Colors.white24 : Colors.grey.shade300),
            const SizedBox(height: 16),
            Text('Erreur de connexion',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : const Color(0xFF475569))),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: controller.fetchFavorites,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite_border_rounded,
                  size: 44,
                  color: isDark ? Colors.white24 : const Color(0xFFCBD5E1)),
            ),
            const SizedBox(height: 20),
            Text('Aucun favori',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF0F172A))),
            const SizedBox(height: 8),
            Text(
                'Appuyez sur ❤️ sur un concours ou post\npour le sauvegarder ici',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                    height: 1.5)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.explore_rounded),
              label: const Text('Découvrir'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ],
        ),
      ),
    );
  }
}

// FAVORITE CARD
class _FavoriteCard extends StatelessWidget {
  final dynamic item; // Can be Concours or PostData
  final bool isDark;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteCard({
    required this.item,
    required this.isDark,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelect,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Determine item type and properties
    final bool isConcours = item is Concours;
    final String title =
        isConcours ? (item as Concours).title : (item as PostData).title;
    final String? id =
        isConcours ? (item as Concours).id : (item as PostData).id;
    final DateTime createdAt = isConcours
        ? (item as Concours).createdAt
        : DateTime.parse((item as PostData).createdAt);
    final Color domaineColor =
        isConcours ? (item as Concours).domaineColor : const Color(0xFF0A66C2);
    final String logoInitial =
        isConcours ? (item as Concours).logoInitial : 'P';
    final String typeDisplay =
        isConcours ? (item as Concours).type.displayName : 'Post';
    final String niveau = isConcours ? (item as Concours).niveau : '';

    return GestureDetector(
      onTap: isSelectionMode ? onSelect : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1F2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF6366F1), width: 2)
              : Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Selection checkbox
              if (isSelectionMode)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.transparent,
                      border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6366F1)
                              : (isDark
                                  ? Colors.white30
                                  : Colors.grey.shade300),
                          width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ),

              // Logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: domaineColor.withOpacity(isDark ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  logoInitial,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: domaineColor),
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: domaineColor.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        typeDisplay,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: domaineColor),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color:
                              isDark ? Colors.white : const Color(0xFF0F172A),
                          height: 1.3),
                    ),
                    const SizedBox(height: 4),

                    // Niveau + saved date
                    Row(
                      children: [
                        if (isConcours && niveau.isNotEmpty)
                          _MiniTag(
                              label: niveau,
                              color: const Color(0xFF6366F1),
                              isDark: isDark),
                        if (isConcours && niveau.isNotEmpty)
                          const SizedBox(width: 6),
                        Icon(Icons.access_time_rounded,
                            size: 11,
                            color: isDark
                                ? Colors.white38
                                : const Color(0xFF94A3B8)),
                        const SizedBox(width: 3),
                        Text(_formatDate(createdAt),
                            style: TextStyle(
                                fontSize: 10,
                                color: isDark
                                    ? Colors.white38
                                    : const Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              if (!isSelectionMode)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444)
                              .withOpacity(isDark ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.favorite_rounded,
                            color: Color(0xFFEF4444), size: 16),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Icon(Icons.chevron_right_rounded,
                        size: 18,
                        color: isDark ? Colors.white24 : Colors.grey.shade300),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'À l\'instant';
    if (diff.inHours < 1) return 'Il y a ${diff.inMinutes} min';
    if (diff.inDays < 1) return 'Il y a ${diff.inHours}h';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays}j';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;

  const _MiniTag(
      {required this.label, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.18 : 0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isDark ? color.withOpacity(0.9) : color),
      ),
    );
  }
}
