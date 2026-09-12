import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/shared_widgets.dart';

/// Feature #2 for Assessment 4: every toggle here writes straight into
/// [AppState] and, because MyApp listens to that state, changes are
/// reflected across the *entire app* immediately (text size, contrast).
class AccessibilitySettingsScreen extends StatelessWidget {
  final AppState state;
  const AccessibilitySettingsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Listen directly to AppState so the switches move immediately when
    // tapped, independent of when the parent MaterialApp happens to rebuild.
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) => _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return RideScaffold(
      title: 'Accessibility',
      subtitle: 'Personalise your ride experience',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            child: Column(
              children: [
                SettingToggleRow(
                  title: 'Large text',
                  description: 'Increase text size throughout the app',
                  value: state.largeText,
                  onChanged: state.toggleLargeText,
                ),
                const Divider(),
                SettingToggleRow(
                  title: 'High contrast',
                  description: 'Increase visual contrast',
                  value: state.highContrast,
                  onChanged: state.toggleHighContrast,
                ),
                const Divider(),
                SettingToggleRow(
                  title: 'Voice ride-status announcements',
                  description: 'Hear important ride updates',
                  value: state.voiceAnnouncements,
                  onChanged: state.toggleVoiceAnnouncements,
                ),
                const Divider(),
                SettingToggleRow(
                  title: 'Haptic feedback',
                  description: 'Receive vibration for key updates',
                  value: state.hapticFeedback,
                  onChanged: state.toggleHapticFeedback,
                ),
                const Divider(),
                SettingToggleRow(
                  title: 'Service animal',
                  description: 'Notify the driver before the trip',
                  value: state.serviceAnimal,
                  onChanged: state.toggleServiceAnimal,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Save preferences',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
