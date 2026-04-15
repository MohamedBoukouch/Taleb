import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taleb/app/data/model/concours_model.dart';
import 'package:taleb/app/modules/concours/views/concours_view.dart';

class ConcoursService {
  static const _baseUrl =
      'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1/concourses';
  static const _anonKey = 'sb_publishable_QmMr4fDlu9L9CwuBPn7mkA_lEGDC5YE';

  static Map<String, String> get _headers => {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
      };

  Future<List<Concours>> fetchConcours({
    String? search,
    String? niveau,
    ConcoursType? type,
    String? domaine,
  }) async {
    // Construire l'URL avec filtres
    final queryParams = <String, String>{
      'order': 'created_at.desc',
    };

    if (search != null && search.isNotEmpty) {
      queryParams['title'] = 'ilike.*$search*';
    }

    if (niveau != null && niveau != 'Tous') {
      queryParams['niveau'] = 'eq.${niveau.toLowerCase()}';
    }

    if (type != null) {
      queryParams['type'] = 'eq.${type.name}';
    }

    if (domaine != null && domaine != 'Tous') {
      queryParams['domaine'] = 'eq.${domaine.toLowerCase()}';
    }

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);

    debugPrint('Fetching: $uri');

    final response = await http.get(uri, headers: _headers);

    debugPrint('fetchConcours status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Concours.fromJson(e)).toList();
    } else {
      throw Exception(
        'Failed to load concours: ${response.statusCode}\n${response.body}',
      );
    }
  }
}
