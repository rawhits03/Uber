import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'booking_confirmation_screen.dart';

class FareDetailsScreen extends StatelessWidget {
  final AppState state;
  const FareDetailsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final ride = state.selectedRide ?? state.rideOptions.first;

    return RideScaffold(
      title: 'Fare details',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated fare', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 6),
                      Text('\$${state.estimatedFare.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 26,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Icon(ride.icon, color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Why is the fare higher?',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                ...state.fareReasons.map(
                  (reason) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(reason.icon, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reason.title,
                                  style: Theme.of(context).textTheme.titleMedium),
                              Text(reason.description,
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Typical fare  \$${state.typicalFareLow.toStringAsFixed(0)}–${state.typicalFareHigh.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text('Your options', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Book now – \$${state.estimatedFare.toStringAsFixed(2)}',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => BookingConfirmationScreen(state: state)),
            ),
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'Wait & check again',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'You can check again later if demand decreases.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
