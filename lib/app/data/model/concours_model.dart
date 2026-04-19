import 'package:flutter/material.dart';

// ✅ Fixed: enum values match your actual DB data ('Cycle', 'Master', etc.)
enum ConcoursType {
  cycle,
  master,
  licence,
  doctorat,
  other;

  static ConcoursType fromString(String? value) {
    if (value == null) return ConcoursType.other;
    switch (value.toLowerCase()) {
      case 'cycle':
        return ConcoursType.cycle;
      case 'master':
        return ConcoursType.master;
      case 'licence':
        return ConcoursType.licence;
      case 'doctorat':
        return ConcoursType.doctorat;
      default:
        return ConcoursType.other;
    }
  }

  String get displayName {
    switch (this) {
      case ConcoursType.cycle:
        return 'Cycle';
      case ConcoursType.master:
        return 'Master';
      case ConcoursType.licence:
        return 'Licence';
      case ConcoursType.doctorat:
        return 'Doctorat';
      case ConcoursType.other:
        return 'Autre';
    }
  }
}

class Concours {
  final String? id;
  final String title;
  final String niveau;
  final ConcoursType type;
  final String domaine;
  final String url;
  final DateTime? examDate;
  final DateTime createdAt;

  Concours({
    this.id,
    required this.title,
    required this.niveau,
    required this.type,
    required this.domaine,
    required this.url,
    this.examDate,
    required this.createdAt,
  });

  factory Concours.fromJson(Map<String, dynamic> json) {
    return Concours(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      niveau: json['niveau'] as String? ?? '',
      // ✅ Fixed: use fromString to safely parse type
      type: ConcoursType.fromString(json['type'] as String?),
      // ✅ Fixed: domaine can be null in your DB
      domaine: json['domaine'] as String? ?? 'Non spécifié',
      url: json['url'] as String? ?? '',
      examDate: json['exam_date'] != null
          ? DateTime.tryParse(json['exam_date'] as String)
          : null,
      // ✅ Fixed: created_at field name (snake_case from Supabase)
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'niveau': niveau,
      'type': type.name,
      'domaine': domaine,
      'url': url,
      'exam_date': examDate?.toIso8601String(),
    };
  }

  // ✅ Color based on domaine
  Color get domaineColor {
    switch (domaine.toLowerCase()) {
      case 'informatique':
        return const Color(0xFF6366F1);
      case 'médecine':
        return const Color(0xFFEF4444);
      case 'finance':
        return const Color(0xFFF59E0B);
      case 'éducation':
        return const Color(0xFF10B981);
      case 'agriculture':
        return const Color(0xFF84CC16);
      case 'génie civil':
        return const Color(0xFF8B5CF6);
      case 'électricité':
        return const Color(0xFFF97316);
      case 'mécanique':
        return const Color(0xFF06B6D4);
      case 'droit':
        return const Color(0xFFEC4899);
      case 'commerce':
        return const Color(0xFF14B8A6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  // ✅ Logo initial from title
  String get logoInitial {
    final words = title.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return title.isNotEmpty ? title.substring(0, 2).toUpperCase() : '??';
  }
}
