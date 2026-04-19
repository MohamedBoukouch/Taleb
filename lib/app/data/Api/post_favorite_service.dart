import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostFavoriteService {
  static const _baseUrl = 'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1';
  static const _anonKey = 'sb_publishable_QmMr4fDlu9L9CwuBPn7mkA_lEGDC5YE';

  static Map<String, String> get _headers => {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation',
      };

  Future<Set<String>> fetchFavoritedIds() async {
    final uri = Uri.parse('$_baseUrl/post_favorites?select=post_id');
    debugPrint('Fetching post favorite IDs: $uri');
    final response = await http
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e['post_id'] as String).toSet();
    }
    return {};
  }

  Future<void> addFavorite(String postId) async {
    final uri = Uri.parse('$_baseUrl/post_favorites');
    final response = await http
        .post(uri, headers: _headers, body: jsonEncode({'post_id': postId}))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> removeFavorite(String postId) async {
    final uri = Uri.parse('$_baseUrl/post_favorites?post_id=eq.$postId');
    final response = await http
        .delete(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}
