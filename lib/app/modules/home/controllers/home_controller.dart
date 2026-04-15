import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/post_service.dart';
import 'package:taleb/app/data/Api/favorite_service.dart'; // Nouveau

class HomeController extends GetxController {
  final PostService _postService = PostService();
  final FavoriteService _favoriteService = FavoriteService(); // Nouveau

  final RxList<PostData> posts = <PostData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<String> likedIds = <String>{}.obs;

  // ✅ NOUVEAU: Set pour stocker les IDs des posts favoris
  final RxSet<String> favoriteIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    fetchUserFavorites(); // ✅ Charger les favoris au démarrage
    _initNotifications();
    _initMessages();
    _initSliders();
  }

  // ── Posts ────────────────────────────────────────────────────────────────

  Future<void> fetchPosts() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final result = await _postService.fetchPosts();
      posts.assignAll(result);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // ── Likes ────────────────────────────────────────────────────────────────

  Future<void> toggleLike(String postId) async {
    if (likedIds.contains(postId)) {
      likedIds.remove(postId);
    } else {
      likedIds.add(postId);
      await _postService.likePost(postId);
    }
  }

  bool isLiked(String postId) => likedIds.contains(postId);

  // ── FAVORIS (NOUVEAU) ────────────────────────────────────────────────────

  /// Charge les favoris de l'utilisateur connecté
  Future<void> fetchUserFavorites() async {
    try {
      final favorites = await _favoriteService.fetchFavorites();
      // Extraire les post_id des favoris
      favoriteIds.assignAll(
        favorites.map((f) => f.postId).toSet(),
      );
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  /// Vérifie si un post est dans les favoris
  bool isFavorite(String postId) => favoriteIds.contains(postId);

  /// Ajoute/Retire un post des favoris
  Future<void> toggleFavorite(String postId) async {
    try {
      if (isFavorite(postId)) {
        // Retirer des favoris
        await _favoriteService.removeFavoriteByPostId(postId);
        favoriteIds.remove(postId);

        Get.snackbar(
          'Retiré',
          'Supprimé des favoris',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.all(12),
        );
      } else {
        // Ajouter aux favoris
        await _favoriteService.addFavorite(postId);
        favoriteIds.add(postId);

        Get.snackbar(
          'Ajouté',
          'Sauvegardé dans vos favoris',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF6366F1),
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.all(12),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de modifier les favoris',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    }
  }

  // ── Stubs ────────────────────────────────────────────────────────────────

  void _initNotifications() {}
  void _initMessages() {}
  void _initSliders() {}

  Future<void> activenotification() async {}
  Future<void> activemessages() async {}
  Future<void> FetchSlider() async {}
}
