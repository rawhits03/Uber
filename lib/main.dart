import 'package:flutter/material.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(UberAccessibleApp());
}

/// Root widget. Wrapping [MaterialApp] in an [AnimatedBuilder] listening to
/// [AppState] means that whenever accessibility settings change anywhere in
/// the app, the theme (built by [AppTheme.build]) is recalculated and every
/// screen re-themes live — this is "Feature 2" for Assessment 4.
class UberAccessibleApp extends StatefulWidget {
  UberAccessibleApp({super.key});

  final AppState state = AppState();

  @override
  State<UberAccessibleApp> createState() => _UberAccessibleAppState();
}

class _UberAccessibleAppState extends State<UberAccessibleApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.state,
      builder: (context, _) {
        return MaterialApp(
          title: 'Uber Accessible',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(widget.state),
          home: HomeScreen(state: widget.state),
        );
      },
    );
  }
}
