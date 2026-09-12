import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'rating_screen.dart';

class TripCompletedScreen extends StatelessWidget {
  final AppState state;
  const TripCompletedScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return RideScaffold(
      title: 'Trip completed',
      showBack: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('\$${state.estimatedFare.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text('Melbourne Airport → ${state.destination}',
              style: Theme.of(context).textTheme.bodyMedium),
          const Divider(height: 32),
          Text('Driver', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(state.driverName, style: Theme.of(context).textTheme.titleMedium),
          Text('${state.driverRating} rating', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Rate your trip',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => RatingScreen(state: state)),
            ),
          ),
        ],
      ),
    );
  }
}
