import 'package:get/get.dart';
import 'package:taleb/app/data/Api/post_service.dart';

class HomeController extends GetxController {
  final PostService _service = PostService();

  final RxList<PostData> posts = <PostData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<String> likedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    // ✅ Safe stubs — no longer call local server
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
      final result = await _service.fetchPosts();
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
      await _service.likePost(postId);
    }
  }

  bool isLiked(String postId) => likedIds.contains(postId);

  // ── Stubs (replace with real Supabase calls later) ───────────────────────

  void _initNotifications() {
    // TODO: replace with Supabase query when ready
    // was calling http://10.0.2.2:8000 — removed
  }

  void _initMessages() {
    // TODO: replace with Supabase query when ready
  }

  void _initSliders() {
    // TODO: replace with Supabase query when ready
  }

  // ── Keep these if other parts of your app call them ──────────────────────

  Future<void> activenotification() async {
    // Safe no-op until you wire up the real endpoint
  }

  Future<void> activemessages() async {
    // Safe no-op until you wire up the real endpoint
  }

  Future<void> FetchSlider() async {
    // Safe no-op until you wire up the real endpoint
  }
}
