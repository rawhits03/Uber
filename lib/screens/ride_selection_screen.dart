import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'fare_details_screen.dart';

class RideSelectionScreen extends StatefulWidget {
  final AppState state;
  const RideSelectionScreen({super.key, required this.state});

  @override
  State<RideSelectionScreen> createState() => _RideSelectionScreenState();
}

class _RideSelectionScreenState extends State<RideSelectionScreen> {
  RideOption? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.state.selectedRide ?? widget.state.rideOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return RideScaffold(
      title: 'Choose a ride',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MapCanvas(
            height: 200,
            child: Stack(
              children: const [
                Positioned(left: 50, top: 30, child: MapDot()),
                Positioned(right: 40, bottom: 30, child: MapPin()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...widget.state.rideOptions.map((ride) {
            final isSelected = _selected?.name == ride.name;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _selected = ride),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).dividerColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(ride.icon, size: 28),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ride.name, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 2),
                            Text('${ride.seats} seats • ${ride.eta}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Text(
                        '\$${ride.minFare.toStringAsFixed(0)}–${ride.maxFare.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'View fare details',
            onPressed: () {
              if (_selected == null) return;
              widget.state.selectRide(_selected!);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FareDetailsScreen(state: widget.state)),
              );
            },
          ),
        ],
      ),
    );
  }
}
