import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';
import 'home_screen.dart';

class RatingScreen extends StatelessWidget {
  final AppState state;
  const RatingScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) => _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return RideScaffold(
      title: 'How was your trip?',
      subtitle: 'Your feedback helps improve the service.',
      showBack: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < state.starRating;
              return IconButton(
                iconSize: 32,
                onPressed: () => state.setStarRating(i + 1),
                icon: Icon(filled ? Icons.star : Icons.star_border, color: Colors.amber),
              );
            }),
          ),
          const SizedBox(height: 16),
          Text('What went well?', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: state.feedbackTags.map((tag) {
              return ChoiceChip(
                label: Text(tag.label),
                selected: tag.selected,
                onSelected: (_) => state.toggleFeedbackTag(tag),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text('Additional feedback', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          TextField(
            maxLines: 4,
            onChanged: state.setAdditionalFeedback,
            decoration: const InputDecoration(hintText: 'Write your feedback...'),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Submit',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thanks for your feedback!')),
              );
              state.resetTrip();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HomeScreen(state: state)),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
