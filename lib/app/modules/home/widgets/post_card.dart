import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taleb/app/config/function/latex_parser.dart';
import 'package:taleb/app/data/Api/post_service.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';

class PostCard extends StatelessWidget {
  final PostData post;
  final HomeController controller = Get.find();

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
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HEADER ──────────────────────────────────────
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
                    const SizedBox(width: 10),
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

                    // ✅ BOUTON FAVORI (remplace le container niveau)
                    Obx(() {
                      final isFav = controller.isFavorite(post.id);
                      return GestureDetector(
                        onTap: () => controller.toggleFavorite(post.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: isFav
                                ? const Color(0xFFFEE2E2)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isFav
                                  ? const Color(0xFFEF4444)
                                  : const Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  key: ValueKey<bool>(isFav),
                                  size: 16,
                                  color: isFav
                                      ? const Color(0xFFEF4444)
                                      : const Color(0xFF9CA3AF),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFav ? 'Enregistré' : 'Favori',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isFav
                                      ? const Color(0xFFEF4444)
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── DESCRIPTION ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _LatexDescription(text: post.description),
              ),

              const SizedBox(height: 10),

              // ── MEDIA (4:5 ratio, full-screen on tap) ────────
              if (post.media.isNotEmpty) _MediaSection(media: post.media),

              const SizedBox(height: 8),

              // ── LIKE COUNT ───────────────────────────────────
              Obx(() {
                final liked = controller.isLiked(post.id);
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

              // ── ACTIONS ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final liked = controller.isLiked(post.id);
                        return _ActionBtn(
                          icon: liked
                              ? Icons.thumb_up_rounded
                              : Icons.thumb_up_alt_outlined,
                          label: "J'aime",
                          active: liked,
                          onTap: () => controller.toggleLike(post.id),
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

// ── LaTeX Description ─────────────────────────────────────────────────────────

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

// ── Media Section (4:5 ratio + full-screen viewer) ────────────────────────────

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
            strokeWidth: 2,
            color: Color(0xFF0A66C2),
          ),
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

// ── Full-Screen Viewer ────────────────────────────────────────────────────────

class _FullScreenViewer extends StatefulWidget {
  final List<Map<String, String>> media;
  final int initialIndex;

  const _FullScreenViewer({
    required this.media,
    required this.initialIndex,
  });

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
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
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
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
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
          if (n == 1 || _current == 0) const _ZoomHint(),
        ],
      ),
    );
  }
}

// ── Zoom Hint ────────────────────────────────────────────────────────────────

class _ZoomHint extends StatefulWidget {
  const _ZoomHint();

  @override
  State<_ZoomHint> createState() => _ZoomHintState();
}

class _ZoomHintState extends State<_ZoomHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: FadeTransition(
          opacity: _opacity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.zoom_in_rounded, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Pincez pour zoomer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Action Button ─────────────────────────────────────────────────────────────

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
