import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'ride_status_screen.dart';

class DriverTrackingScreen extends StatelessWidget {
  final AppState state;
  const DriverTrackingScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return RideScaffold(
      title: 'Your ride',
      showBack: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MapCanvas(
            height: 260,
            child: Stack(
              children: const [
                Positioned(left: 45, top: 30, child: MapDot(color: Colors.deepPurple)),
                Positioned(right: 40, bottom: 40, child: MapPin()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Driver arriving', style: Theme.of(context).textTheme.titleLarge),
          Text('${state.driverEtaMinutes}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.green)),
          const Divider(height: 28),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.driverName, style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      '${state.driverRating} rating • ${state.driverVehicle} • ${state.driverPlate}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(label: 'Contact Driver', onPressed: () {}),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SecondaryButton(
                  label: 'Cancel Ride',
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Simulate: Driver has arrived',
            onPressed: () {
              state.markDriverArrived();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => RideStatusScreen(state: state)),
              );
            },
          ),
        ],
      ),
    );
  }
}
