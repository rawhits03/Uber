import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'destination_search_screen.dart';
import 'accessibility_settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState state;
  const HomeScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Uber Accessible'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MapCanvas(
                height: 320,
                child: Stack(
                  children: const [
                    Positioned(left: 60, top: 40, child: MapDot()),
                    Positioned(right: 50, bottom: 60, child: MapPin()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Where to?', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => _goToSearch(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).inputDecorationTheme.fillColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 18),
                            const SizedBox(width: 10),
                            Text('Search destination',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _goToSearch(context),
                            icon: const Icon(Icons.home_outlined, size: 18),
                            label: const Text('Home'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _goToSearch(context),
                            icon: const Icon(Icons.work_outline, size: 18),
                            label: const Text('Work'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(Icons.accessible,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Accessibility', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 2),
                          Text('Make the app work for you',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AccessibilitySettingsScreen(state: state),
                        ),
                      ),
                      child: const Text('ACCESS'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DestinationSearchScreen(state: state)),
    );
  }
}
