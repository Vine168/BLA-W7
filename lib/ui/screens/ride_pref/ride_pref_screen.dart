import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_pref.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import '../../providers/rides_preferences_provider.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';
import '../../widgets/display/bla_error.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  void onRidePrefSelected(BuildContext context, RidePreference newPreference) {
    Provider.of<RidesPreferencesProvider>(context, listen: false)
        .setCurrentPreference(newPreference);
    Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(const RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RidesPreferencesProvider>(context);
    final currentRidePreference = provider.currentPreference;

    return Stack(
      children: [
        const BlaBackground(),
        Column(
          children: [
            const SizedBox(height: BlaSpacings.m),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 100),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: (newPreference) =>
                        onRidePrefSelected(context, newPreference),
                  ),
                  const SizedBox(height: BlaSpacings.m),
                  SizedBox(
                    height: 200,
                    child: _buildPastPreferences(provider),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPastPreferences(RidesPreferencesProvider provider) {
    if (provider.pastPreferences.isLoading) {
      return const BlaError(message: 'Loading...');
    } else if (provider.pastPreferences.hasError) {
      return const BlaError(message: 'No connection. Try later');
    } else {
      final pastPreferences = provider.preferencesHistory;
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: pastPreferences.length,
        itemBuilder: (ctx, index) => RidePrefHistoryTile(
          ridePref: pastPreferences[index],
          onPressed: () =>
              onRidePrefSelected(ctx, pastPreferences[index]),
        ),
      );
    }
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}