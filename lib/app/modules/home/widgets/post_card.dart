// lib/widgets/post_card_widget.dart
//
// pubspec.yaml dependencies:
//   cached_network_image: ^3.3.1
//   video_player: ^2.8.6
//   share_plus: ^9.0.0
//   url_launcher: ^6.2.5

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

// ─────────────────────────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────────────────────────

enum PostMediaType { image, video }

class PostMedia {
  final String url;
  final PostMediaType type;
  final String? thumbnailUrl; // required when type == video

  const PostMedia({
    required this.url,
    required this.type,
    this.thumbnailUrl,
  });
}

class PostModel {
  final String id;
  final String authorName;
  final String authorSubtitle;
  final String? authorAvatarUrl;
  final String publishedAt;
  // Description can contain plain URLs — they will be auto-detected and made tappable.
  // Example: "Inscrivez-vous ici : https://marcoconcours.com/register"
  final String description;
  final List<PostMedia> media;
  final int likes;
  final String category;

  const PostModel({
    required this.id,
    required this.authorName,
    required this.authorSubtitle,
    this.authorAvatarUrl,
    required this.publishedAt,
    required this.description,
    this.media = const [],
    this.likes = 0,
    required this.category,
  });
}

// ─────────────────────────────────────────────────────────────────
// URL PARSER  — splits text into plain/link segments
// ─────────────────────────────────────────────────────────────────

class _Segment {
  final String text;
  final bool isLink;
  const _Segment(this.text, {this.isLink = false});
}

List<_Segment> _parseSegments(String text) {
  final urlRegex = RegExp(
    r'https?://[^\s]+',
    caseSensitive: false,
  );
  final segments = <_Segment>[];
  int cursor = 0;
  for (final match in urlRegex.allMatches(text)) {
    if (match.start > cursor) {
      segments.add(_Segment(text.substring(cursor, match.start)));
    }
    segments.add(_Segment(match.group(0)!, isLink: true));
    cursor = match.end;
  }
  if (cursor < text.length) {
    segments.add(_Segment(text.substring(cursor)));
  }
  return segments;
}

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ─────────────────────────────────────────────────────────────────
// RICH DESCRIPTION  — plain text + tappable blue links
// ─────────────────────────────────────────────────────────────────

class _RichDescription extends StatefulWidget {
  final String text;
  const _RichDescription({required this.text});

  @override
  State<_RichDescription> createState() => _RichDescriptionState();
}

class _RichDescriptionState extends State<_RichDescription> {
  bool _expanded = false;
  static const _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    final segments = _parseSegments(widget.text);

    final spans = <TextSpan>[];
    for (final seg in segments) {
      if (seg.isLink) {
        final url = seg.text;
        spans.add(
          TextSpan(
            text: url,
            style: const TextStyle(
              color: Color(0xFF0A66C2),
              decoration: TextDecoration.underline,
              fontSize: 14,
              height: 1.55,
            ),
            recognizer: TapGestureRecognizer()..onTap = () => _openUrl(url),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: seg.text,
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: _expanded ? null : _maxLines,
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

// ─────────────────────────────────────────────────────────────────
// VIDEO TILE
// ─────────────────────────────────────────────────────────────────

class _VideoTile extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  const _VideoTile({required this.videoUrl, this.thumbnailUrl});

  @override
  State<_VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<_VideoTile> {
  late final VideoPlayerController _ctrl;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _ctrl = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) setState(() => _ready = true);
      });
    _ctrl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() => setState(() {
        _ctrl.value.isPlaying ? _ctrl.pause() : _ctrl.play();
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_ready)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _ctrl.value.size.width,
                  height: _ctrl.value.size.height,
                  child: VideoPlayer(_ctrl),
                ),
              ),
            )
          else if (widget.thumbnailUrl != null)
            CachedNetworkImage(
              imageUrl: widget.thumbnailUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          else
            const ColoredBox(color: Color(0xFFF0F0F0)),

          // Play overlay
          if (!_ctrl.value.isPlaying)
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.48),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 30),
            ),

          // Progress bar
          if (_ready)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                _ctrl,
                allowScrubbing: true,
                padding: EdgeInsets.zero,
                colors: const VideoProgressColors(
                  playedColor: Color(0xFF0A66C2),
                  bufferedColor: Colors.white38,
                  backgroundColor: Colors.black26,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// MEDIA GALLERY
// ─────────────────────────────────────────────────────────────────

class _MediaGallery extends StatefulWidget {
  final List<PostMedia> media;
  const _MediaGallery({required this.media});

  @override
  State<_MediaGallery> createState() => _MediaGalleryState();
}

class _MediaGalleryState extends State<_MediaGallery> {
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

  Widget _tile(PostMedia m) {
    if (m.type == PostMediaType.video) {
      return _VideoTile(videoUrl: m.url, thumbnailUrl: m.thumbnailUrl);
    }
    return CachedNetworkImage(
      imageUrl: m.url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, __) => const ColoredBox(color: Color(0xFFF0F0F0)),
      errorWidget: (_, __, ___) => const ColoredBox(
        color: Color(0xFFF0F0F0),
        child: Center(
          child: Icon(Icons.broken_image_outlined,
              size: 36, color: Color(0xFFCCCCCC)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.media.length;
    if (n == 0) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: n == 1
              ? _tile(widget.media.first)
              : PageView.builder(
                  controller: _pc,
                  itemCount: n,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (_, i) => _tile(widget.media[i]),
                ),
        ),

        // Dots — only when multiple media
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
}

// ─────────────────────────────────────────────────────────────────
// POST CARD
// ─────────────────────────────────────────────────────────────────

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({Key? key, required this.post, this.onTap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _liked = false;

  int get _totalLikes => widget.post.likes + (_liked ? 1 : 0);

  String get _initials {
    final parts = widget.post.authorName.trim().split(' ');
    return parts.length >= 2
        ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
        : widget.post.authorName.substring(0, 2).toUpperCase();
  }

  void _share() {
    final p = widget.post;
    // Extract URLs from description and append them cleanly
    final urlRegex = RegExp(r'https?://[^\s]+', caseSensitive: false);
    final urls =
        urlRegex.allMatches(p.description).map((m) => m.group(0)!).join('\n');
    final body = p.description + (urls.isNotEmpty ? '\n\n$urls' : '');
    Share.share(body, subject: p.authorName);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── HEADER ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFFDDDDDD), width: 1),
                        ),
                        child: ClipOval(
                          child: p.authorAvatarUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: p.authorAvatarUrl!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: const Color(0xFF0A66C2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _initials,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Name / subtitle / date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.authorName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191919),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              p.authorSubtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF666666)),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  p.publishedAt,
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

                      // Category pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3FB),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          p.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A66C2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ── DESCRIPTION (with auto-linked URLs) ───────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _RichDescription(text: p.description),
                ),

                const SizedBox(height: 10),

                // ── MEDIA GALLERY ─────────────────────────────────────────
                if (p.media.isNotEmpty) _MediaGallery(media: p.media),

                const SizedBox(height: 8),

                // ── LIKE COUNT ────────────────────────────────────────────
                if (_totalLikes > 0)
                  Padding(
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
                        Text(
                          '$_totalLikes',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF666666)),
                        ),
                      ],
                    ),
                  ),

                // ── DIVIDER ───────────────────────────────────────────────
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 16, color: Color(0xFFE8E8E8)),
                ),

                // ── ACTIONS: LIKE + SHARE only ────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionBtn(
                          icon: _liked
                              ? Icons.thumb_up_rounded
                              : Icons.thumb_up_alt_outlined,
                          label: "J'aime",
                          active: _liked,
                          onTap: () => setState(() => _liked = !_liked),
                        ),
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

          // LinkedIn-style gray gap between cards
          Container(height: 8, color: const Color(0xFFF3F2F0)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// ACTION BUTTON
// ─────────────────────────────────────────────────────────────────

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
