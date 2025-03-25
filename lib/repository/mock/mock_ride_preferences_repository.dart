// import 'dart:convert';
import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride_pref.dart';
import '../ride_preferences_repository.dart';

class MockRidePreferencesRepository extends RidePreferencesRepository {
  List<RidePreference> _allPreferences = fakeRidePrefs;

  MockRidePreferencesRepository();

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Simulate a 2-second delay
    await Future.delayed(const Duration(seconds: 2));
    return _allPreferences;
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    // Simulate a 2-second delay
    await Future.delayed(const Duration(seconds: 2));
    if (!_allPreferences.contains(preference)) {
      _allPreferences.insert(0, preference);
    }
  }
}