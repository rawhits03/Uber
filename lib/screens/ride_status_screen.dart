import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'trip_completed_screen.dart';

class RideStatusScreen extends StatelessWidget {
  final AppState state;
  const RideStatusScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return RideScaffold(
      title: 'Driver has arrived',
      subtitle: 'Your driver is waiting at the pickup point',
      showBack: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text('Driver has arrived',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Look for the vehicle at your pickup point.',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Divider(height: 28),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 10, color: Colors.deepPurple),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.destination,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Pickup • 12:08 PM',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.red),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('245 Collins Street',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Drop-off • 12:15 PM',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(state.driverName, style: Theme.of(context).textTheme.titleMedium),
          Text('${state.driverVehicle}\n${state.driverPlate}',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'I have arrived',
            onPressed: () {
              state.markTripCompleted();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => TripCompletedScreen(state: state)),
              );
            },
          ),
        ],
      ),
    );
  }
}
