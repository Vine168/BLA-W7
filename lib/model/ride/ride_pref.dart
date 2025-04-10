import '../location/locations.dart';

///
/// This model describes a ride preference.
/// A ride preference consists of the selection of a departure + arrival + a date and a number of passenger
///
class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  const RidePreference(
      {required this.departure,
      required this.departureDate,
      required this.arrival,
      required this.requestedSeats});

  @override
  String toString() {
    return 'RidePref(departure: ${departure.name}, '
        'departureDate: ${departureDate.toIso8601String()}, '
        'arrival: ${arrival.name}, '
        'requestedSeats: $requestedSeats)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RidePreference &&
          runtimeType == other.runtimeType &&
          departure == other.departure &&
          departureDate == other.departureDate &&
          arrival == other.arrival &&
          requestedSeats == other.requestedSeats;

  @override
  int get hashCode =>
      departure.hashCode ^
      departureDate.hashCode ^
      arrival.hashCode ^
      requestedSeats.hashCode;
}
