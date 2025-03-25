import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../../providers/rides_preferences_provider.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPreferencePressed(BuildContext context) async {
    final provider = Provider.of<RidesPreferencesProvider>(context, listen: false);
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: provider.currentPreference),
      ),
    );

    if (newPreference != null) {
      provider.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    // Placeholder for filter functionality
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider for changes
    final provider = Provider.of<RidesPreferencesProvider>(context);
    final currentPreference = provider.currentPreference;
    final RideFilter currentFilter = RideFilter();

    // Fetch matching rides
    final List<Ride> matchingRides = currentPreference != null
        ? RidesService.instance.getRidesFor(currentPreference, currentFilter)
        : [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search bar
            RidePrefBar(
              ridePreference: currentPreference ?? RidePreference(
                departure: Location(name: "Unknown", country: Country.unknown),
                departureDate: DateTime.now(),
                arrival: Location(name: "Unknown", country: Country.unknown),
                requestedSeats: 1,
              ),
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context),
              onFilterPressed: onFilterPressed,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}