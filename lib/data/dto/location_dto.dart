import 'dart:convert';
import '../../model/location/locations.dart';

class LocationDto {
  static Map<String, dynamic> toJson(Location model) {
    return {
      'name': model.name,
      'country': model.country.name,
    };
  }

  static Location fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: countryFromString(json['country']),
    );
  }

  static Country countryFromString(String value) {
    return Country.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Invalid country: $value'),
    );
  }

  static String toJsonString(Location model) {
    return jsonEncode(toJson(model));
  }

  static Location fromJsonString(String jsonString) {
    return fromJson(jsonDecode(jsonString));
  }
}