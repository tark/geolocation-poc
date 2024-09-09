import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final LatLng location;
  final String name;
  final String imageUrl;
  final String audioUrl;
  bool hasShownPopup = false;

  Place({
    required this.location,
    required this.name,
    required this.imageUrl,
    required this.audioUrl,
  });
}
