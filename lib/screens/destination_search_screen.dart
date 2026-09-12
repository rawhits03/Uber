import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'ride_selection_screen.dart';

class DestinationSearchScreen extends StatefulWidget {
  final AppState state;
  const DestinationSearchScreen({super.key, required this.state});

  @override
  State<DestinationSearchScreen> createState() => _DestinationSearchScreenState();
}

class _DestinationSearchScreenState extends State<DestinationSearchScreen> {
  late final TextEditingController _pickupController;
  late final TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _pickupController = TextEditingController(text: widget.state.pickup);
    _destinationController = TextEditingController(text: widget.state.destination);
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RideScaffold(
      title: 'Where are you going?',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pickup', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                TextField(controller: _pickupController),
                const SizedBox(height: 16),
                Text('Destination', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                TextField(
                  controller: _destinationController,
                  decoration: const InputDecoration(hintText: 'Enter your destination'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saved places', style: Theme.of(context).textTheme.titleMedium),
                const Divider(height: 20),
                ...widget.state.savedPlaces.map(
                  (place) => PlaceRow(
                    icon: place == 'Home' ? Icons.home_outlined : Icons.work_outline,
                    label: place,
                    onTap: () => setState(() => _destinationController.text = place),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent destinations', style: Theme.of(context).textTheme.titleMedium),
                const Divider(height: 20),
                ...widget.state.recentDestinations.map(
                  (place) => PlaceRow(
                    icon: Icons.history,
                    label: place,
                    onTap: () => setState(() => _destinationController.text = place),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Continue',
            onPressed: () {
              widget.state.setPickup(_pickupController.text.trim().isEmpty
                  ? 'Current location'
                  : _pickupController.text.trim());
              widget.state.setDestination(_destinationController.text.trim().isEmpty
                  ? 'Melbourne Central'
                  : _destinationController.text.trim());
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => RideSelectionScreen(state: widget.state)),
              );
            },
          ),
        ],
      ),
    );
  }
}
