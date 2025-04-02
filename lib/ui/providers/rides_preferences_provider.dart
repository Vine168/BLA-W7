import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../data/repository/ride_preferences_repository.dart';
import 'async_value.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    // Initialize pastPreferences as loading
    pastPreferences = AsyncValue.loading();
    _fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference != pref) {
      _currentPreference = pref;
      _addPreference(pref);
      notifyListeners();
    }
  }

  Future<void> _fetchPastPreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      List<RidePreference> past = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(past);
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  Future<void> _addPreference(RidePreference preference) async {
    // First approach: Call addPreference and fetch again
    await repository.addPreference(preference);
    await _fetchPastPreferences();
  }

  List<RidePreference> get preferencesHistory =>
      pastPreferences.data?.reversed.toList() ?? [];
}