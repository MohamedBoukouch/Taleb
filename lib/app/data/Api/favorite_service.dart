import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  static const _baseUrl = 'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1';
  static const _anonKey = 'sb_publishable_QmMr4fDlu9L9CwuBPn7mkA_lEGDC5YE';

  static Map<String, String> get _headers => {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
      };

  /// Récupérer tous les favoris de l'utilisateur
  Future<List<FavoriteModel>> fetchFavorites() async {
    final uri = Uri.parse(
      '$_baseUrl/favorites?select=*,posts(title,category,thumbnail_url)&order=created_at.desc',
    );

    final response = await http.get(uri, headers: _headers);

    debugPrint('fetchFavorites status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => FavoriteModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load favorites: ${response.statusCode}');
    }
  }

  /// Ajouter un favori
  Future<void> addFavorite(String postId) async {
    final uri = Uri.parse('$_baseUrl/favorites');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({'post_id': postId}),
    );

    debugPrint('addFavorite status: ${response.statusCode}');

    if (response.statusCode != 201) {
      throw Exception('Failed to add favorite: ${response.body}');
    }
  }

  /// Supprimer un favori par son ID (dans la table favorites)
  Future<void> removeFavorite(String favoriteId) async {
    final uri = Uri.parse('$_baseUrl/favorites?id=eq.$favoriteId');
    final response = await http.delete(uri, headers: _headers);

    if (response.statusCode != 204) {
      throw Exception('Failed to remove favorite');
    }
  }

  /// Supprimer un favori par post_id (plus pratique)
  Future<void> removeFavoriteByPostId(String postId) async {
    // D'abord récupérer l'ID du favori
    final uri = Uri.parse('$_baseUrl/favorites?post_id=eq.$postId&select=id');
    final getResponse = await http.get(uri, headers: _headers);

    if (getResponse.statusCode == 200) {
      final List<dynamic> data = jsonDecode(getResponse.body);
      if (data.isNotEmpty) {
        final favoriteId = data[0]['id'];
        await removeFavorite(favoriteId);
      }
    }
  }

  /// Vérifier si un post est favori
  Future<bool> isFavorite(String postId) async {
    final uri = Uri.parse('$_baseUrl/favorites?post_id=eq.$postId&select=id');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.isNotEmpty;
    }
    return false;
  }
}

/// Model pour les favoris
class FavoriteModel {
  final String id;
  final String postId;
  final String? title;
  final String? category;
  final String? thumbnailUrl;
  final DateTime createdAt;

  FavoriteModel({
    required this.id,
    required this.postId,
    this.title,
    this.category,
    this.thumbnailUrl,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    final postData = json['posts'] as Map<String, dynamic>?;

    return FavoriteModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      title: postData?['title'] as String?,
      category: postData?['category'] as String?,
      thumbnailUrl: postData?['thumbnail_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
