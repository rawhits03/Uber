import 'package:flutter/material.dart';

/// A ride option shown on the Ride Selection screen.
class RideOption {
  final String name;
  final int seats;
  final String eta;
  final double minFare;
  final double maxFare;
  final IconData icon;

  const RideOption({
    required this.name,
    required this.seats,
    required this.eta,
    required this.minFare,
    required this.maxFare,
    required this.icon,
  });

  double get typicalFare => (minFare + maxFare) / 2;
}

/// One reason shown on the Fare Transparency screen explaining a higher fare.
class FareReason {
  final String title;
  final String description;
  final IconData icon;

  const FareReason({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// A single "what went well" feedback chip on the Rating screen.
class FeedbackTag {
  final String label;
  bool selected;
  FeedbackTag(this.label, {this.selected = false});
}

/// App-wide state shared across every screen.
///
/// This is the backbone of the two headline features for Assessment 4:
///  1. The end-to-end booking flow (destination, ride choice, fare, and
///     booking details all live here and flow between screens).
///  2. Accessibility Settings — toggling large text / high contrast here
///     causes [AppTheme] to rebuild the *entire app's* look, live.
class AppState extends ChangeNotifier {
  // ---------------- Booking flow state ----------------
  String pickup = 'Current location';
  String destination = 'Melbourne Central';

  final List<String> savedPlaces = ['Home', 'Work'];
  final List<String> recentDestinations = ['Melbourne Airport', 'Docklands'];

  final List<RideOption> rideOptions = const [
    RideOption(
      name: 'UberX',
      seats: 4,
      eta: '3 min away',
      minFare: 24,
      maxFare: 28,
      icon: Icons.directions_car,
    ),
    RideOption(
      name: 'Comfort',
      seats: 4,
      eta: '5 min away',
      minFare: 29,
      maxFare: 34,
      icon: Icons.airline_seat_recline_extra,
    ),
    RideOption(
      name: 'Accessible Ride',
      seats: 4,
      eta: '6 min away',
      minFare: 31,
      maxFare: 36,
      icon: Icons.accessible,
    ),
  ];

  final List<FareReason> fareReasons = const [
    FareReason(
      title: 'High demand',
      description: 'More people are requesting rides now.',
      icon: Icons.trending_up,
    ),
    FareReason(
      title: 'Fewer drivers available',
      description: 'Lower driver supply in your area.',
      icon: Icons.person_outline,
    ),
    FareReason(
      title: 'Heavy traffic',
      description: 'Slower traffic increases the travel time.',
      icon: Icons.traffic,
    ),
  ];

  RideOption? selectedRide;
  double estimatedFare = 32.50;
  double typicalFareLow = 22;
  double typicalFareHigh = 27;
  String paymentMethod = 'Visa •••• 4521';

  final String driverName = 'Alex';
  final double driverRating = 4.92;
  final String driverVehicle = 'Toyota Camry';
  final String driverPlate = 'ABC 123';
  String driverEtaMinutes = '3 min';

  bool driverHasArrived = false;
  bool rideCompleted = false;

  // ---------------- Accessibility settings state ----------------
  bool largeText = true;
  bool highContrast = true;
  bool voiceAnnouncements = true;
  bool hapticFeedback = true;
  bool serviceAnimal = true;

  // ---------------- Rating screen state ----------------
  int starRating = 0;
  final List<FeedbackTag> feedbackTags = [
    FeedbackTag('Clean car'),
    FeedbackTag('Safe driving'),
    FeedbackTag('Friendly driver'),
    FeedbackTag('On time'),
  ];
  String additionalFeedback = '';

  // ---------------- Mutators ----------------

  void selectRide(RideOption ride) {
    selectedRide = ride;
    estimatedFare = ride.typicalFare + 4.5; // demo surge premium
    notifyListeners();
  }

  void setDestination(String value) {
    destination = value;
    notifyListeners();
  }

  void setPickup(String value) {
    pickup = value;
    notifyListeners();
  }

  void toggleLargeText(bool value) {
    largeText = value;
    notifyListeners();
  }

  void toggleHighContrast(bool value) {
    highContrast = value;
    notifyListeners();
  }

  void toggleVoiceAnnouncements(bool value) {
    voiceAnnouncements = value;
    notifyListeners();
  }

  void toggleHapticFeedback(bool value) {
    hapticFeedback = value;
    notifyListeners();
  }

  void toggleServiceAnimal(bool value) {
    serviceAnimal = value;
    notifyListeners();
  }

  void markDriverArrived() {
    driverHasArrived = true;
    notifyListeners();
  }

  void markTripCompleted() {
    rideCompleted = true;
    notifyListeners();
  }

  void setStarRating(int stars) {
    starRating = stars;
    notifyListeners();
  }

  void toggleFeedbackTag(FeedbackTag tag) {
    tag.selected = !tag.selected;
    notifyListeners();
  }

  void setAdditionalFeedback(String value) {
    additionalFeedback = value;
  }

  /// Resets the booking-specific fields so the demo can be replayed from
  /// the Home screen without restarting the app.
  void resetTrip() {
    selectedRide = null;
    driverHasArrived = false;
    rideCompleted = false;
    starRating = 0;
    additionalFeedback = '';
    for (final tag in feedbackTags) {
      tag.selected = false;
    }
    notifyListeners();
  }
}
