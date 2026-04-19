import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/concours_favorite_service.dart';
import 'package:taleb/app/data/Api/post_favorite_service.dart';
import 'package:taleb/app/data/model/concours_model.dart';
import 'package:taleb/app/data/Api/post_service.dart';

class FavoriteController extends GetxController {
  final ConcoursFavoriteService _concoursService = ConcoursFavoriteService();
  final PostFavoriteService _postService = PostFavoriteService();

  // Full objects for the favorites page
  final RxList<Concours> favoriteConcours = <Concours>[].obs;
  final RxList<PostData> favoritePosts = <PostData>[].obs;
  final RxList<dynamic> filteredItems = <dynamic>[].obs;

  // ✅ Fast ID sets for isFavorited() checks — drives heart icons
  final RxSet<String> _favoritedConcoursIds = <String>{}.obs;
  final RxSet<String> _favoritedPostIds = <String>{}.obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedType = 'all'.obs;
  final RxBool isSelectionMode = false.obs;
  final RxSet<String> selectedIds = <String>{}.obs;

  final List<Map<String, dynamic>> typeOptions = [
    {'key': 'all', 'label': 'Tous', 'icon': Icons.grid_view_rounded},
    {'key': 'concours', 'label': 'Concours', 'icon': Icons.school_rounded},
    {'key': 'posts', 'label': 'Posts', 'icon': Icons.article_rounded},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
    ever(selectedType, (_) => _applyFilter());
  }

  // ── Fetch ──────────────────────────────────────────────────────────────

  Future<void> fetchFavorites() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      // ✅ Fetch both tables in parallel
      final results = await Future.wait([
        _concoursService.fetchFavoritedIds(),
        _postService.fetchFavoritedIds(),
      ]);

      final concoursIds = results[0]; // Set<String>
      final postIds = results[1]; // Set<String>

      // Update ID sets for instant heart icon response
      _favoritedConcoursIds.assignAll(concoursIds);
      _favoritedPostIds.assignAll(postIds);

      // Fetch full objects for the favorites list page
      if (concoursIds.isNotEmpty) {
        final raw = await _concoursService.fetchFavorites();
        // Extract nested concours objects from the join response
        favoriteConcours.assignAll(
          raw
              .where((e) => e['concourses'] != null)
              .map((e) =>
                  Concours.fromJson(e['concourses'] as Map<String, dynamic>))
              .toList(),
        );
      } else {
        favoriteConcours.clear();
      }

      // ✅ Fetch full post objects if you have a PostService.fetchPostsByIds
      // For now we store IDs only — add full fetch when needed
      favoritePosts.clear();

      _applyFilter();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = _friendlyError(e.toString());
      debugPrint('FavoriteController error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _applyFilter() {
    switch (selectedType.value) {
      case 'concours':
        filteredItems.assignAll(favoriteConcours);
        break;
      case 'posts':
        filteredItems.assignAll(favoritePosts);
        break;
      default:
        final mixed = <dynamic>[...favoriteConcours, ...favoritePosts];
        mixed.sort((a, b) {
          final aDate = a is Concours
              ? a.createdAt
              : DateTime.parse((a as PostData).createdAt);
          final bDate = b is Concours
              ? b.createdAt
              : DateTime.parse((b as PostData).createdAt);
          return bDate.compareTo(aDate);
        });
        filteredItems.assignAll(mixed);
    }
  }

  // ── isFavorited — used by heart icons ─────────────────────────────────

  /// Call with type: 'concours' or 'post'
  bool isFavorited(String id, {String type = 'concours'}) {
    if (type == 'post') return _favoritedPostIds.contains(id);
    return _favoritedConcoursIds.contains(id);
  }

  // ── toggleFavorite ─────────────────────────────────────────────────────

  Future<void> toggleFavorite(String id, String type) async {
    final isFav = isFavorited(id, type: type);

    // ✅ Optimistic update
    if (type == 'concours') {
      isFav ? _favoritedConcoursIds.remove(id) : _favoritedConcoursIds.add(id);
    } else {
      isFav ? _favoritedPostIds.remove(id) : _favoritedPostIds.add(id);
    }

    try {
      if (isFav) {
        if (type == 'concours') {
          await _concoursService.removeFavoriteByConcoursId(id);
          favoriteConcours.removeWhere((c) => c.id == id);
        } else {
          await _postService.removeFavorite(id);
          favoritePosts.removeWhere((p) => p.id == id);
        }
        _applyFilter();
        _showSnack('Retiré', 'Supprimé des favoris', Colors.black87);
      } else {
        if (type == 'concours') {
          await _concoursService.addFavorite(id);
        } else {
          await _postService.addFavorite(id);
        }
        // Refresh full list after add
        await fetchFavorites();
        _showSnack(
            'Ajouté', 'Sauvegardé dans vos favoris', const Color(0xFF6366F1));
      }
    } catch (e) {
      // ✅ Rollback on error
      if (type == 'concours') {
        isFav
            ? _favoritedConcoursIds.add(id)
            : _favoritedConcoursIds.remove(id);
      } else {
        isFav ? _favoritedPostIds.add(id) : _favoritedPostIds.remove(id);
      }
      _showSnack(
          'Erreur', 'Impossible de modifier les favoris', Colors.red.shade700);
      debugPrint('toggleFavorite error: $e');
    }
  }

  void _showSnack(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(12),
    );
  }

  // ── Bulk delete ────────────────────────────────────────────────────────

  Future<void> removeFromFavorites(dynamic item) async {
    if (item is Concours) {
      await toggleFavorite(item.id ?? '', 'concours');
    } else if (item is PostData) {
      await toggleFavorite(item.id, 'post');
    }
  }

  void toggleSelectionMode() {
    isSelectionMode.toggle();
    if (!isSelectionMode.value) selectedIds.clear();
  }

  void toggleSelection(String id) {
    selectedIds.contains(id) ? selectedIds.remove(id) : selectedIds.add(id);
  }

  Future<void> deleteSelected() async {
    for (final id in selectedIds.toList()) {
      final concours = favoriteConcours.firstWhereOrNull((c) => c.id == id);
      if (concours != null) {
        await removeFromFavorites(concours);
      } else {
        final post = favoritePosts.firstWhereOrNull((p) => p.id == id);
        if (post != null) await removeFromFavorites(post);
      }
    }
    selectedIds.clear();
    isSelectionMode.value = false;
  }

  void setFilter(String type) => selectedType.value = type;

  String _friendlyError(String raw) {
    if (raw.contains('Unauthorized')) return 'Erreur d\'authentification';
    if (raw.contains('Network')) return 'Pas de connexion internet';
    return 'Une erreur est survenue';
  }

  Future<void> refresh() => fetchFavorites();
}
