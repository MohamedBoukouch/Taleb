import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
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
          // ── APP BAR COLLAPSIBLE ─────────────────────────────
          SliverAppBar(
            expandedHeight: 120,
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
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Obx(() => Text(
                        '${controller.favorites.length} éléments sauvegardés',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      )),
                ],
              ),
            ),
            actions: [
              // Bouton sélection multiple
              Obx(() => controller.isSelectionMode.value
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: controller.deleteSelected,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.checklist_rtl_rounded,
                        color:
                            isDark ? Colors.white70 : const Color(0xFF475569),
                      ),
                      onPressed: controller.toggleSelectionMode,
                    )),
              const SizedBox(width: 8),
            ],
          ),

          // ── FILTRES PAR CATÉGORIE ───────────────────────────
          SliverToBoxAdapter(
            child: _buildCategoryFilters(controller, isDark),
          ),

          // ── LISTE DES FAVORIS ───────────────────────────────
          Obx(() {
            if (controller.isLoading.value) {
              return _buildShimmerLoading(isDark);
            }

            if (controller.hasError.value) {
              return _buildErrorState(controller, isDark);
            }

            if (controller.favorites.isEmpty) {
              return _buildEmptyState(isDark);
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final favorite = controller.favorites[index];
                    return _FavoriteCard(
                      favorite: favorite,
                      isDark: isDark,
                      isSelectionMode: controller.isSelectionMode.value,
                      isSelected: controller.selectedIds.contains(favorite.id),
                      onSelect: () => controller.toggleSelection(favorite.id),
                      onTap: () => controller.openPost(favorite.postId),
                      onRemove: () => controller.removeFavorite(favorite.id),
                    );
                  },
                  childCount: controller.favorites.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── CATEGORY FILTERS ─────────────────────────────────────────
  Widget _buildCategoryFilters(FavoriteController controller, bool isDark) {
    final categories = [
      {'icon': Icons.all_inclusive, 'label': 'Tous'},
      {'icon': Icons.article_rounded, 'label': 'Articles'},
      {'icon': Icons.picture_as_pdf_rounded, 'label': 'PDFs'},
      {'icon': Icons.video_library_rounded, 'label': 'Vidéos'},
    ];

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Obx(() {
            final isSelected =
                controller.selectedCategory.value == cat['label'];
            return GestureDetector(
              onTap: () => controller.setCategory(cat['label'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : (isDark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.white),
                  borderRadius: BorderRadius.circular(25),
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
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: Row(
                  children: [
                    Icon(
                      cat['icon'] as IconData,
                      size: 18,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat['label'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                ? Colors.white60
                                : const Color(0xFF64748B)),
                      ),
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

  // ── SHIMMER LOADING ──────────────────────────────────────────
  Widget _buildShimmerLoading(bool isDark) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Shimmer.fromColors(
            baseColor: isDark ? Colors.white10 : Colors.grey.shade200,
            highlightColor: isDark ? Colors.white24 : Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          childCount: 5,
        ),
      ),
    );
  }

  // ── ERROR STATE ──────────────────────────────────────────────
  Widget _buildErrorState(FavoriteController controller, bool isDark) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: isDark ? Colors.white24 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur de connexion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: controller.fetchFavorites,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── EMPTY STATE ──────────────────────────────────────────────
  Widget _buildEmptyState(bool isDark) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 48,
                color: isDark ? Colors.white24 : const Color(0xFFCBD5E1),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Aucun favori',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Appuyez sur ❤️ pour sauvegarder\nvos posts préférés',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Get.back(), // Retour au feed
              icon: const Icon(Icons.explore_rounded),
              label: const Text('Découvrir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FAVORITE CARD WIDGET ─────────────────────────────────────

class _FavoriteCard extends StatelessWidget {
  final FavoriteItem favorite;
  final bool isDark;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteCard({
    required this.favorite,
    required this.isDark,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelect,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
              : null,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Checkbox en mode sélection
              if (isSelectionMode)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6366F1)
                            : (isDark ? Colors.white30 : Colors.grey.shade300),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),

              // Image thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: favorite.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: favorite.thumbnailUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (_, __, ___) => _buildPlaceholderIcon(),
                      )
                    : _buildPlaceholderIcon(),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color:
                            _getCategoryColor().withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        favorite.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _getCategoryColor(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      favorite.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Date & Source
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color:
                              isDark ? Colors.white : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(favorite.savedAt),
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                isDark ? Colors.white : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              if (!isSelectionMode)
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_rounded),
                      color: const Color(0xFFEF4444),
                      iconSize: 20,
                      onPressed: onRemove,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      width: 80,
      height: 80,
      color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF1F5F9),
      child: Icon(
        _getCategoryIcon(),
        size: 28,
        color: isDark ? Colors.white24 : const Color(0xFFCBD5E1),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (favorite.category.toLowerCase()) {
      case 'article':
        return const Color(0xFF6366F1);
      case 'pdf':
        return const Color(0xFFEF4444);
      case 'vidéo':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF10B981);
    }
  }

  IconData _getCategoryIcon() {
    switch (favorite.category.toLowerCase()) {
      case 'article':
        return Icons.article_rounded;
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'vidéo':
        return Icons.video_library_rounded;
      default:
        return Icons.bookmark_rounded;
    }
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
