import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taleb/app/config/function/latex_parser.dart';
import 'package:taleb/app/data/Api/post_service.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';

class PostCard extends StatelessWidget {
  final PostData post;
  final HomeController homeController = Get.find();

  PostCard({Key? key, required this.post}) : super(key: key);

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
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
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return iso.substring(0, 10);
    }
  }

  void _share() {
    Share.share(
      '${post.title}\n\n${parseLatex(post.description)}',
      subject: post.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get or create FavoriteController
    final favCtrl = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0A66C2),
                        border: Border.all(
                            color: const Color(0xFFDDDDDD), width: 1),
                      ),
                      child: const Center(
                        child: Icon(Icons.school_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tawjihi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF191919),
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            post.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF666666)),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                _formatDate(post.createdAt),
                                style: const TextStyle(
                                    fontSize: 11, color: Color(0xFF999999)),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.public_rounded,
                                  size: 11, color: Color(0xFF999999)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // FAVORITE BUTTON - Concours Style

                    Obx(
                      () {
                        final isFav = favCtrl.isFavorited(post.id,
                            type: 'post'); // ✅ type param

                        return GestureDetector(
                          // ✅ Single source of truth — only FavoriteController
                          onTap: () => favCtrl.toggleFavorite(post.id, 'post'),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1.0, end: isFav ? 1.2 : 1.0),
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.elasticOut,
                            builder: (_, scale, child) =>
                                Transform.scale(scale: scale, child: child),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isFav
                                    ? const Color(0xFFEF4444).withOpacity(0.1)
                                    : const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isFav
                                      ? const Color(0xFFEF4444).withOpacity(0.5)
                                      : const Color(0xFFE5E7EB),
                                ),
                              ),
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 18,
                                color: isFav
                                    ? const Color(0xFFEF4444)
                                    : const Color(0xFFCBD5E1),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _LatexDescription(text: post.description),
              ),

              const SizedBox(height: 10),

              // MEDIA
              if (post.media.isNotEmpty) _MediaSection(media: post.media),

              const SizedBox(height: 8),

              // LIKE COUNT
              Obx(() {
                final liked = homeController.isLiked(post.id);
                final total = post.likesCount + (liked ? 1 : 0);
                if (total == 0) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0A66C2),
                        ),
                        child: const Icon(Icons.thumb_up_rounded,
                            color: Colors.white, size: 10),
                      ),
                      const SizedBox(width: 5),
                      Text('$total',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF666666))),
                    ],
                  ),
                );
              }),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 16, color: Color(0xFFE8E8E8)),
              ),

              // ACTIONS
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final liked = homeController.isLiked(post.id);
                        return _ActionBtn(
                          icon: liked
                              ? Icons.thumb_up_rounded
                              : Icons.thumb_up_alt_outlined,
                          label: "J'aime",
                          active: liked,
                          onTap: () => homeController.toggleLike(post.id),
                        );
                      }),
                    ),
                    Expanded(
                      child: _ActionBtn(
                        icon: Icons.reply_rounded,
                        label: 'Partager',
                        active: false,
                        mirror: true,
                        onTap: _share,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(height: 8, color: const Color(0xFFF3F2F0)),
      ],
    );
  }
}

// LATEX DESCRIPTION
class _LatexDescription extends StatefulWidget {
  final String text;
  const _LatexDescription({required this.text});

  @override
  State<_LatexDescription> createState() => _LatexDescriptionState();
}

class _LatexDescriptionState extends State<_LatexDescription> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final spans = parseLatexToSpans(widget.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: _expanded ? null : 3,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          text: TextSpan(children: spans),
        ),
        if (!_expanded)
          GestureDetector(
            onTap: () => setState(() => _expanded = true),
            child: const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                'voir plus',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// MEDIA SECTION
class _MediaSection extends StatefulWidget {
  final List<Map<String, String>> media;
  const _MediaSection({required this.media});

  @override
  State<_MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<_MediaSection> {
  int _page = 0;
  late final PageController _pc;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _openViewer(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) => _FullScreenViewer(
          media: widget.media,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.media.length;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 4 / 4,
          child: n == 1
              ? GestureDetector(
                  onTap: () => _openViewer(context, 0),
                  child: _buildImage(widget.media.first['url'] ?? ''),
                )
              : PageView.builder(
                  controller: _pc,
                  itemCount: n,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () => _openViewer(context, i),
                    child: _buildImage(widget.media[i]['url'] ?? ''),
                  ),
                ),
        ),
        if (n > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(n, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFF0A66C2)
                        : const Color(0xFFCCCCCC),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, __) => Container(
        color: const Color(0xFFF0F0F0),
        child: const Center(
          child: CircularProgressIndicator(
              strokeWidth: 2, color: Color(0xFF0A66C2)),
        ),
      ),
      errorWidget: (_, __, ___) => const ColoredBox(
        color: Color(0xFFF0F0F0),
        child: Center(
          child: Icon(Icons.broken_image_outlined,
              size: 36, color: Color(0xFFCCCCCC)),
        ),
      ),
    );
  }
}

// FULL SCREEN VIEWER
class _FullScreenViewer extends StatefulWidget {
  final List<Map<String, String>> media;
  final int initialIndex;

  const _FullScreenViewer({required this.media, required this.initialIndex});

  @override
  State<_FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<_FullScreenViewer> {
  late int _current;
  late final PageController _pc;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _pc = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.media.length;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pc,
            itemCount: n,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) {
              final url = widget.media[i]['url'] ?? '';
              return InteractiveViewer(
                minScale: 0.8,
                maxScale: 5.0,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    ),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white54,
                      size: 48,
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
          ),
          if (n > 1)
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_current + 1} / $n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ACTION BUTTON
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool mirror;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.mirror = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF0A66C2) : const Color(0xFF555555);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                alignment: Alignment.center,
                transform: mirror
                    ? (Matrix4.identity()..scale(-1.0, 1.0, 1.0))
                    : Matrix4.identity(),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
