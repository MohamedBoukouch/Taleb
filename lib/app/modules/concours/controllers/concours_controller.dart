import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Api/concours_service.dart';
import 'package:taleb/app/data/model/concours_model.dart';

class ConcoursController extends GetxController {
  final ConcoursService _service = ConcoursService();

  // Observable states
  final RxList<Concours> concours = <Concours>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Filters
  final RxString searchQuery = ''.obs;
  final RxString selectedNiveau = 'Tous'.obs;
  final Rx<ConcoursType?> selectedType = Rx<ConcoursType?>(null);
  final RxString selectedDomaine = 'Tous'.obs;

  // Lists for filters
  final List<String> niveaux = [
    'Tous',
    'Bac',
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

  @override
  void onInit() {
    super.onInit();
    fetchConcours();

    // Auto-refresh when filters change
    ever(searchQuery, (_) => fetchConcours());
    ever(selectedNiveau, (_) => fetchConcours());
    ever(selectedType, (_) => fetchConcours());
    ever(selectedDomaine, (_) => fetchConcours());
  }

  Future<void> fetchConcours() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await _service.fetchConcours(
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        niveau: selectedNiveau.value,
        type: selectedType.value,
        domaine: selectedDomaine.value,
      );

      concours.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      debugPrint('Error fetching concours: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setSearch(String value) => searchQuery.value = value;
  void setNiveau(String value) => selectedNiveau.value = value;
  void setType(ConcoursType? value) => selectedType.value = value;
  void setDomaine(String value) => selectedDomaine.value = value;

  void clearFilters() {
    searchQuery.value = '';
    selectedNiveau.value = 'Tous';
    selectedType.value = null;
    selectedDomaine.value = 'Tous';
  }
}
