import 'package:flutter/material.dart';
import 'package:taleb/app/shared/publication.dart';

class ZoomSuggestion extends StatefulWidget {
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  final String id_publication;
  bool? forcomment = false;
  final int numberlike;
  final int numbercomment;
  final int is_favorit;
  final int is_liked;
  final String link;
  ZoomSuggestion({
    Key? key,
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
    required this.id_publication,
    required this.numberlike,
    required this.numbercomment,
    required this.is_favorit,
    required this.is_liked,
    required this.link,
  }) : super(key: key);

  @override
  State<ZoomSuggestion> createState() => _ZoomSuggestionState();
}

class _ZoomSuggestionState extends State<ZoomSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostCard(
        link: widget.link,
        is_liked: widget.is_liked,
        is_favorit: widget.is_favorit,
        numberlike: widget.numberlike,
        numbercomment: widget.numbercomment,
        id_publication: widget.id_publication,
        localisation: widget.localisation,
        timeAgo: widget.timeAgo,
        titel: widget.titel,
        description: widget.description,
        postImage: widget.postImage,
      ),
    );
  }
}
