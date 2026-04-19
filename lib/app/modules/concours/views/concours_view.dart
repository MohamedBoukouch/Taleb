import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/concours/controllers/concours_controller.dart';
import 'package:taleb/app/modules/concours/widgets/concours_widgets.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';

class ConcoursView extends StatelessWidget {
  const ConcoursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Use Get.find if registered via binding, Get.put otherwise
    final controller = Get.put(ConcoursController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Register FavoriteController if not already registered
    if (!Get.isRegistered<FavoriteController>()) {
      Get.put(FavoriteController());
    }

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F1117) : const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConcoursSearchBar(controller: controller, isDark: isDark),
            NiveauChips(controller: controller, isDark: isDark),
            DomaineChips(controller: controller, isDark: isDark),
            TypeFilters(controller: controller, isDark: isDark),
            ResultCount(controller: controller, isDark: isDark),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.concoursList.isEmpty) {
                  return ConcoursLoading(isDark: isDark);
                }

                if (controller.hasError.value) {
                  return ConcoursError(
                    controller: controller,
                    isDark: isDark,
                    onRetry: controller.fetchConcours,
                  );
                }

                if (controller.concoursList.isEmpty) {
                  return ConcoursEmpty(isDark: isDark);
                }

                return RefreshIndicator(
                  color: const Color(0xFF6366F1),
                  onRefresh: controller.refresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: controller.concoursList.length,
                    itemBuilder: (context, i) {
                      final concours = controller.concoursList[i];
                      return AnimatedConcoursCard(
                        concours: concours,
                        isDark: isDark,
                        index: i,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedConcoursCard extends StatelessWidget {
  final dynamic concours;
  final bool isDark;
  final int index;

  const AnimatedConcoursCard({
    Key? key,
    required this.concours,
    required this.isDark,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      // ✅ Cap animation delay so it doesn't get too slow for long lists
      duration: Duration(milliseconds: 250 + (index.clamp(0, 10) * 50)),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - v)),
          child: child,
        ),
      ),
      child: ConcoursCard(
        concours: concours,
        isDark: isDark,
      ),
    );
  }
}
