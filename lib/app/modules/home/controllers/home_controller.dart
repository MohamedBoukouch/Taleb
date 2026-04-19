import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/post_service.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';

class HomeController extends GetxController {
  final PostService _postService = PostService();

  final RxList<PostData> posts = <PostData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<String> likedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    _initNotifications();
    _initMessages();
    _initSliders();
  }

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

  Future<void> toggleLike(String postId) async {
    if (likedIds.contains(postId)) {
      likedIds.remove(postId);
    } else {
      likedIds.add(postId);
      await _postService.likePost(postId);
    }
  }

  bool isLiked(String postId) => likedIds.contains(postId);

  void _initNotifications() {}
  void _initMessages() {}
  void _initSliders() {}

  Future<void> activenotification() async {}
  Future<void> activemessages() async {}
  Future<void> FetchSlider() async {}
}
