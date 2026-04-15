import 'package:flutter/material.dart';

enum ConcoursType { public, private, international, regional }

class Concours {
  final String id;
  final String title;
  final String? organisme;
  final String niveau;
  final ConcoursType type;
  final String domaine;
  final DateTime? deadline;
  final String? wilaya;
  final int? postes;
  final String url;
  final DateTime createdAt;
  final bool isFavorite;

  const Concours({
    required this.id,
    required this.title,
    this.organisme,
    required this.niveau,
    required this.type,
    required this.domaine,
    this.deadline,
    this.wilaya,
    this.postes,
    required this.url,
    required this.createdAt,
    this.isFavorite = false,
  });

  factory Concours.fromJson(Map<String, dynamic> json) {
    // Parse type
    ConcoursType parseType(String? t) {
      switch (t?.toLowerCase()) {
        case 'private':
          return ConcoursType.private;
        case 'international':
          return ConcoursType.international;
        case 'regional':
          return ConcoursType.regional;
        case 'public':
        default:
          return ConcoursType.public;
      }
    }

    // Parse deadline (si tu ajoutes ce champ plus tard dans Supabase)
    DateTime? parseDeadline(dynamic d) {
      if (d == null) return null;
      if (d is String) {
        try {
          return DateTime.parse(d);
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    return Concours(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      organisme: json['organisme'] as String?,
      niveau: (json['niveau'] as String? ?? 'bac').toLowerCase(),
      type: parseType(json['type'] as String?),
      domaine: (json['domaine'] as String? ?? 'général').toLowerCase(),
      deadline: parseDeadline(json['deadline']),
      wilaya: json['wilaya'] as String?,
      postes: json['postes'] as int?,
      url: json['url'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  // Helper pour couleur par domaine
  Color get domaineColor {
    final colors = {
      'informatique': const Color(0xFF1565C0),
      'médecine': const Color(0xFF1A6B4A),
      'finance': const Color(0xFF00695C),
      'éducation': const Color(0xFF6A1B9A),
      'agriculture': const Color(0xFF558B2F),
      'génie civil': const Color(0xFF5D4037),
      'électricité': const Color(0xFFF57C00),
      'mécanique': const Color(0xFF455A64),
      'droit': const Color(0xFFAD1457),
      'commerce': const Color(0xFF00838F),
    };
    return colors[domaine.toLowerCase()] ?? const Color(0xFF6366F1);
  }

  String get logoInitial {
    if (title.isEmpty) return '?';
    final words = title.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return title.substring(0, min(2, title.length)).toUpperCase();
  }

  static int min(int a, int b) => a < b ? a : b;
}
