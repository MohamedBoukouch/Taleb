import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taleb/app/data/model/concours_model.dart';

class ConcoursService {
  // ✅ No trailing space
  static const _baseUrl =
      'https://uqluzscyuoynxwdkvpbj.supabase.co/rest/v1/concourses';

  // ✅ Replace with your FULL anon key from Supabase dashboard
  // Go to: Project Settings → API → Project API keys → anon public
  // It should look like: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.xxxxx.xxxxx
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
    // ✅ Build query params properly — no Uri.encodeComponent needed here,
    //    Uri.replace handles encoding automatically
    final queryParams = <String, String>{
      'order': 'created_at.desc',
    };

    if (search != null && search.isNotEmpty) {
      // ✅ ilike for case-insensitive search — no manual encoding
      queryParams['title'] = 'ilike.*$search*';
    }

    if (niveau != null && niveau != 'Tous') {
      // ✅ ilike so 'Bac+2' matches 'bac+2' in DB
      queryParams['niveau'] = 'ilike.$niveau';
    }

    if (type != null) {
      // ✅ Use displayName to match DB values ('Cycle', 'Master', etc.)
      queryParams['type'] = 'ilike.${type.displayName}';
    }

    if (domaine != null && domaine != 'Tous') {
      queryParams['domaine'] = 'ilike.$domaine';
    }

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    debugPrint('Fetching: $uri');

    try {
      final response = await http
          .get(uri, headers: _headers)
          .timeout(const Duration(seconds: 15));

      debugPrint('Status: ${response.statusCode}');
      if (kDebugMode) {
        final preview = response.body.length > 300
            ? response.body.substring(0, 300)
            : response.body;
        debugPrint('Response preview: $preview');
      }

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((e) => Concours.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Check your Supabase anon key and RLS policies');
      } else if (response.statusCode == 404) {
        throw Exception(
            'Table not found: Make sure table name is "concourses"');
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } on http.ClientException catch (e) {
      debugPrint('Network error: $e');
      throw Exception('Network error: $e');
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }
}
