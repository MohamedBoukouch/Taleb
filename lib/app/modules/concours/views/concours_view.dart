import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/concours/controllers/concours_controller.dart';
import 'package:taleb/app/modules/concours/widgets/concours_widgets.dart';

class ConcoursView extends StatelessWidget {
  const ConcoursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConcoursController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F1117) : const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            ConcoursSearchBar(controller: controller, isDark: isDark),

            // Niveau Filter
            NiveauChips(controller: controller, isDark: isDark),

            // Domaine Filter (Spécialité)
            DomaineChips(controller: controller, isDark: isDark),

            // Type Filter
            TypeFilters(controller: controller, isDark: isDark),

            // Result Count
            ResultCount(controller: controller, isDark: isDark),

            // List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ConcoursLoading(isDark: isDark);
                }

                if (controller.hasError.value) {
                  return ConcoursError(controller: controller, isDark: isDark);
                }

                if (controller.concours.isEmpty) {
                  return ConcoursEmpty(isDark: isDark);
                }

                return RefreshIndicator(
                  color: const Color(0xFF6366F1),
                  onRefresh: controller.fetchConcours,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: controller.concours.length,
                    itemBuilder: (context, i) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + i * 60),
                        curve: Curves.easeOutCubic,
                        builder: (_, v, child) => Opacity(
                          opacity: v,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - v)),
                            child: child,
                          ),
                        ),
                        child: ConcoursCard(
                          concours: controller.concours[i],
                          isDark: isDark,
                        ),
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
