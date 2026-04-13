import 'package:taleb/app/data/model/PostMedia.dart';
import 'package:taleb/app/modules/home/widgets/post_card.dart';

class PostModel {
  final String id;
  final String authorName;
  final String authorSubtitle;
  final String publishedAt;
  final String category;
  final String description;
  final List<PostMedia> media;
  final int likes;
  final String? externalLink;

  const PostModel({
    required this.id,
    required this.authorName,
    required this.authorSubtitle,
    required this.publishedAt,
    required this.category,
    required this.description,
    required this.media,
    required this.likes,
    this.externalLink,
  });
}
