import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:taleb/app/data/Api/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _service = FavoriteService();

  // Observables
  final RxList<FavoriteItem> favorites = <FavoriteItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString selectedCategory = 'Tous'.obs;
  final RxBool isSelectionMode = false.obs;
  final RxSet<String> selectedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final result = await _service.fetchFavorites();
      favorites.value = result.cast<FavoriteItem>();
    } catch (e) {
      hasError.value = true;
      debugPrint('Error fetching favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    // Filtrer localement ou refetch avec filtre
  }

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedIds.clear();
    }
  }

  void toggleSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeFavorite(id);
      favorites.removeWhere((f) => f.id == id);
      Get.snackbar(
        'Supprimé',
        'Retiré des favoris',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer');
    }
  }

  Future<void> deleteSelected() async {
    if (selectedIds.isEmpty) return;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirmer'),
        content: Text('Supprimer ${selectedIds.length} favoris ?'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Annuler')),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      for (final id in selectedIds.toList()) {
        await removeFavorite(id);
      }
      toggleSelectionMode();
    }
  }

  void openPost(String postId) {
    // Navigation vers le détail du post
    // Get.to(() => PostDetailView(postId: postId));
  }
}

// Model
class FavoriteItem {
  final String id;
  final String postId;
  final String title;
  final String category;
  final String? thumbnailUrl;
  final DateTime savedAt;

  FavoriteItem({
    required this.id,
    required this.postId,
    required this.title,
    required this.category,
    this.thumbnailUrl,
    required this.savedAt,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      title: json['posts']['title'] as String? ?? 'Sans titre',
      category: json['posts']['category'] as String? ?? 'Article',
      thumbnailUrl: json['posts']['thumbnail_url'] as String?,
      savedAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
