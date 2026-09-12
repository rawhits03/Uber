import 'package:flutter/material.dart';

/// A lightweight stand-in for a live map (matches the grid-street look of
/// the Figma prototype) so the UI can be demoed without a Maps API key.
class MapCanvas extends StatelessWidget {
  final double height;
  final Widget? child;

  const MapCanvas({super.key, this.height = 240, this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE9E9E9);
    final line = isDark ? const Color(0xFF333333) : const Color(0xFFCFCFCF);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(color: base),
            Positioned(
              top: height * 0.35,
              left: 0,
              right: 0,
              child: Container(height: 2, color: line),
            ),
            Positioned(
              left: 40,
              top: 0,
              bottom: 0,
              child: Container(width: 2, color: line),
            ),
            if (child != null) Positioned.fill(child: child!),
          ],
        ),
      ),
    );
  }
}

/// A dot marker for "current location" / pickup points on [MapCanvas].
class MapDot extends StatelessWidget {
  final Color color;
  const MapDot({super.key, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
    );
  }
}

/// A pin marker for destination points on [MapCanvas].
class MapPin extends StatelessWidget {
  final Color color;
  const MapPin({super.key, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.location_on, color: color, size: 32);
  }
}

/// Standard page scaffold: back arrow + title, consistent padding.
class RideScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget body;
  final bool showBack;
  final EdgeInsetsGeometry padding;

  const RideScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
    this.showBack = true,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 20),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showBack,
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: padding,
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A rounded content card matching the Figma "white card" style.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: padding, child: child),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

/// A labelled row with a leading icon — used for saved/recent places.
class PlaceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const PlaceRow({super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).textTheme.bodyMedium?.color),
            const SizedBox(width: 12),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

/// An accessibility-setting row with a title, description and switch.
class SettingToggleRow extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingToggleRow({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
