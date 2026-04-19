import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ConcoursFavoriteService {
  static const _baseUrl = 'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1';
  static const _anonKey = 'sb_publishable_QmMr4fDlu9L9CwuBPn7mkA_lEGDC5YE';

  static Map<String, String> get _headers => {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation',
      };

  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final uri = Uri.parse(
      '$_baseUrl/concours_favorites?select=id,concours_id,created_at,concourses(id,title,niveau,type,domaine,url,exam_date,created_at)&order=created_at.desc',
    );
    debugPrint('Fetching concours favorites: $uri');
    final response = await http
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }

  Future<void> addFavorite(String concoursId) async {
    final uri = Uri.parse('$_baseUrl/concours_favorites');
    final response = await http
        .post(uri,
            headers: _headers, body: jsonEncode({'concours_id': concoursId}))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    final uri = Uri.parse('$_baseUrl/concours_favorites?id=eq.$favoriteId');
    final response = await http
        .delete(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> removeFavoriteByConcoursId(String concoursId) async {
    final uri =
        Uri.parse('$_baseUrl/concours_favorites?concours_id=eq.$concoursId');
    final response = await http
        .delete(uri, headers: _headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  Future<Set<String>> fetchFavoritedIds() async {
    final uri = Uri.parse('$_baseUrl/concours_favorites?select=concours_id');
    final response = await http
        .get(uri, headers: _headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e['concours_id'] as String).toSet();
    }
    return {};
  }
}
