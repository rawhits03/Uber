import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'driver_tracking_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final AppState state;
  const BookingConfirmationScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final ride = state.selectedRide ?? state.rideOptions.first;

    return RideScaffold(
      title: 'Confirm your ride',
      subtitle: 'Review your trip before booking',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row(context, 'Pickup', state.pickup),
                const Divider(height: 24),
                _row(context, 'Destination', state.destination),
                const Divider(height: 24),
                _row(context, ride.name, '${ride.seats} seats',
                    trailing: '\$${state.estimatedFare.toStringAsFixed(2)}'),
                const Divider(height: 24),
                _row(context, 'Payment', state.paymentMethod),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fare transparency',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Price includes current demand conditions.',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Confirm Ride',
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => DriverTrackingScreen(state: state)),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String title, String subtitle, {String? trailing}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        if (trailing != null)
          Text(trailing, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
