import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostData {
  final String id;
  final String title;
  final String description;
  final String niveau;
  final int likesCount;
  final int sharesCount;
  final List<Map<String, String>> media;
  final String createdAt;

  const PostData({
    required this.id,
    required this.title,
    required this.description,
    required this.niveau,
    required this.likesCount,
    required this.sharesCount,
    required this.media,
    required this.createdAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    final rawMedia = json['media'] as List<dynamic>? ?? [];
    return PostData(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      niveau: json['niveau'] as String? ?? '',
      likesCount: json['likes_count'] as int? ?? 0,
      sharesCount: json['shares_count'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      media: rawMedia
          .map((e) => {
                'url': (e['url'] as String? ?? ''),
                'type': (e['type'] as String? ?? 'image'),
              })
          .toList(),
    );
  }
}

class PostService {
  // ✅ Your real Supabase project URL and anon key
  static const _baseUrl =
      'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1/posts';

  // 🔑 Go to: Supabase Dashboard → Settings → API → anon public key
  static const _anonKey = 'sb_publishable_QmMr4fDlu9L9CwuBPn7mkA_lEGDC5YE';

  static Map<String, String> get _headers => {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation',
      };

  Future<List<PostData>> fetchPosts() async {
    final uri = Uri.parse('$_baseUrl?order=created_at.desc');
    final response = await http.get(uri, headers: _headers);

    debugPrint('fetchPosts status: ${response.statusCode}');
    debugPrint('fetchPosts body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => PostData.fromJson(e)).toList();
    } else {
      throw Exception(
        'Failed to load posts: ${response.statusCode}\n${response.body}',
      );
    }
  }

  Future<void> likePost(String postId) async {
    try {
      final getUri = Uri.parse('$_baseUrl?id=eq.$postId&select=likes_count');
      final getRes = await http.get(getUri, headers: _headers);
      if (getRes.statusCode != 200) return;

      final List data = jsonDecode(getRes.body);
      if (data.isEmpty) return;
      final current = data[0]['likes_count'] as int? ?? 0;

      final patchUri = Uri.parse('$_baseUrl?id=eq.$postId');
      await http.patch(
        patchUri,
        headers: _headers,
        body: jsonEncode({'likes_count': current + 1}),
      );
    } catch (e) {
      debugPrint('likePost error: $e');
    }
  }
}
