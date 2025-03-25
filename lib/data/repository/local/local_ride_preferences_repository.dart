import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/ride/ride_pref.dart';
import '../../dto/ride_preference_dto.dart';
import '../ride_preferences_repository.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    return prefsList.map((json) => RidePreferenceDto.fromJsonString(json)).toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    final currentPrefs = await getPastPreferences();
    
    // Remove duplicates
    currentPrefs.removeWhere((p) => p == preference);
    // Add new preference
    currentPrefs.insert(0, preference);
    
    // Save the updated list
    final prefsList = currentPrefs.map((pref) => RidePreferenceDto.toJsonString(pref)).toList();
    await prefs.setStringList(_preferencesKey, prefsList);
  }
}