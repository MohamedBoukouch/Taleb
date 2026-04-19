import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/concours_service.dart';
import 'package:taleb/app/data/api/concours_service.dart' hide ConcoursService;
import 'package:taleb/app/data/model/concours_model.dart';

class ConcoursController extends GetxController {
  final ConcoursService _service = ConcoursService();

  // Observable states
  final RxList<Concours> concoursList = <Concours>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Filters
  final RxString searchQuery = ''.obs;
  final RxString selectedNiveau = 'Tous'.obs;
  final Rx<ConcoursType?> selectedType = Rx<ConcoursType?>(null);
  final RxString selectedDomaine = 'Tous'.obs;

  // ✅ niveaux must match DB values (case-insensitive via ilike, but display matters)
  final List<String> niveaux = [
    'Tous',
    'Bac+2',
    'Bac+3',
    'Bac+4',
    'Bac+5',
  ];

  final List<String> domaines = [
    'Tous',
    'Informatique',
    'Médecine',
    'Finance',
    'Éducation',
    'Agriculture',
    'Génie Civil',
    'Électricité',
    'Mécanique',
    'Droit',
    'Commerce',
  ];

  // ✅ Type options matching your actual DB values
  final List<ConcoursType?> typeOptions = [
    null, // = Tous
    ConcoursType.cycle,
    ConcoursType.master,
    ConcoursType.licence,
    ConcoursType.doctorat,
  ];

  @override
  void onInit() {
    super.onInit();
    fetchConcours();

    // ✅ Debounce only for search text
    debounce(
      searchQuery,
      (_) => fetchConcours(),
      time: const Duration(milliseconds: 500),
    );

    // ✅ Immediate reaction for filter changes
    ever(selectedNiveau, (_) => fetchConcours());
    ever(selectedType, (_) => fetchConcours());
    ever(selectedDomaine, (_) => fetchConcours());
  }

  Future<void> fetchConcours() async {
    // ✅ Prevent simultaneous calls
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await _service.fetchConcours(
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        niveau: selectedNiveau.value == 'Tous' ? null : selectedNiveau.value,
        type: selectedType.value,
        domaine: selectedDomaine.value == 'Tous' ? null : selectedDomaine.value,
      );

      concoursList.assignAll(result);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = _friendlyError(e.toString());
      debugPrint('ConcoursController error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String _friendlyError(String raw) {
    if (raw.contains('Unauthorized')) {
      return 'Erreur d\'authentification. Vérifiez votre clé API.';
    } else if (raw.contains('Network')) {
      return 'Pas de connexion internet.';
    } else if (raw.contains('Table not found')) {
      return 'Table introuvable dans la base de données.';
    }
    return 'Une erreur est survenue. Réessayez.';
  }

  void setSearch(String value) => searchQuery.value = value.trim();
  void setNiveau(String value) => selectedNiveau.value = value;
  void setType(ConcoursType? value) => selectedType.value = value;
  void setDomaine(String value) => selectedDomaine.value = value;

  void clearFilters() {
    searchQuery.value = '';
    selectedNiveau.value = 'Tous';
    selectedType.value = null;
    selectedDomaine.value = 'Tous';
    // No need to call fetchConcours() — `ever` listeners will trigger it
  }

  Future<void> refresh() => fetchConcours();
}
