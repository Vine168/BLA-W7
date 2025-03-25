import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    // Fetch past preferences once during initialization
    _pastPreferences = repository.getPastPreferences();
  }
  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
    // Only process if the new preference is different
    if (_currentPreference != pref) {
      // Update current preference
      _currentPreference = pref;

      // Update history
      _addPreference(pref);

      notifyListeners();
    }
  }

  void _addPreference(RidePreference preference) {
    // Remove duplicates
    _pastPreferences.removeWhere((p) => p == preference);
    // Add to the beginning
    _pastPreferences.insert(0, preference);
    // Persist to repository
    repository.addPreference(preference);
  }

  // History is returned from newest to oldest
  List<RidePreference> get preferencesHistory => _pastPreferences.reversed.toList();
}