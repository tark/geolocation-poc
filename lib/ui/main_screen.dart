import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocation_poc/ui/common_widgets/spinner.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';
import 'package:geolocation_poc/util/context_extensions.dart';
import 'package:geolocation_poc/util/util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'common_widgets/buttons.dart';
import 'common_widgets/texts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  Location location = Location();
  BitmapDescriptor? _userMarkerIcon;
  BitmapDescriptor? _placeMarkerIcon;
  bool _permissionGranted = false;
  bool _modalShown = false;

  final List<Place> _places = [
    Place(
      location: const LatLng(-33.90508758118587, 151.18199288959056),
      name: "25 Devine St",
      imageUrl: "assets/images/25.jpeg",
    ),
    Place(
      location: const LatLng(-33.90496069147935, 151.18175149080162),
      name: "17 Devine St",
      imageUrl: "assets/images/17.jpeg",
    ),
    Place(
      location: const LatLng(-33.904907264178014, 151.18157982944055),
      name: "9 Devine St",
      imageUrl: "assets/images/9.jpeg",
    ),
    Place(
      location: const LatLng(-33.9048271231632, 151.1814269435409),
      name: "1 Devine St",
      imageUrl: "assets/images/1.jpeg",
    ),
    if (kDebugMode)
      Place(
        location: const LatLng(37.4217007857818, -122.08408330273932),
        name: "Google B43",
        imageUrl: "assets/images/1.jpeg",
      ),
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    requestLocationPermission();
  }

  Future<void> _loadCustomMarkers() async {
    _userMarkerIcon = await _createCircleMarker(Colors.blue);
    _placeMarkerIcon = await _createCircleMarker(Colors.red);
  }

  Future<BitmapDescriptor> _createCircleMarker(Color color) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    const size = 70;
    const shadowOffset = 2.0;
    const shadowSigma = 3.0;

    const offsetX = size / 2;
    const offsetY = size / 2;
    const radius = size / 3;
    const radiusSmall = radius * 0.65;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, shadowSigma);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      const Offset(offsetX, offsetY + shadowOffset),
      radius,
      shadowPaint,
    );
    canvas.drawCircle(
      const Offset(offsetX, offsetY),
      radius,
      whitePaint,
    );
    canvas.drawCircle(
      const Offset(offsetX, offsetY),
      radiusSmall,
      paint,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _permissionGranted
          ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 15,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          _startLocationUpdates();
        },
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        markers: _buildMarkers(),
      )
          : _buildPermissionDeniedWidget(),
    );
  }

  Widget _buildPermissionDeniedWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spinner(
            color: context.secondary,
          ),
          const SizedBox(height: 16),
          Texts(
            'Waiting for location permission...',
            fontSize: AppSize.fontNormal,
            fontWeight: FontWeight.w500,
            color: context.secondary,
          ),
          const SizedBox(height: 16),
          Buttons(
            text: 'Retry',
            onPressed: requestLocationPermission,
            width: 200,
            buttonColor: context.cardBackground,
          ),
        ],
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return;
    }

    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        _permissionGranted = true;
      });
      _startLocationUpdates();
    } else {
      setState(() {
        _permissionGranted = false;
      });
    }
  }

  void _startLocationUpdates() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = LatLng(
          currentLocation.latitude ?? 0,
          currentLocation.longitude ?? 0,
        );
      });
      _moveCameraToPosition(_currentPosition);
      _checkProximityToPlaces();
    });
  }

  void _moveCameraToPosition(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    if (_userMarkerIcon != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position: _currentPosition,
          icon: _userMarkerIcon ?? BitmapDescriptor.defaultMarker,
        ),
      );
    }

    for (var place in _places) {
      if (_placeMarkerIcon != null) {
        markers.add(
          Marker(
            markerId: MarkerId(place.location.toString()),
            position: place.location,
            icon: _placeMarkerIcon ?? BitmapDescriptor.defaultMarker,
            onTap: () {
              _showPlaceDetails(place);
            },
          ),
        );
      }
    }

    return markers;
  }

  void _checkProximityToPlaces() {
    for (var place in _places) {
      if (_calculateDistance(_currentPosition, place.location) < 100 &&
          !_modalShown) {
        _showPlaceDetails(place);
        break;
      }
    }
  }

  double _calculateDistance(LatLng pos1, LatLng pos2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((pos2.latitude - pos1.latitude) * p) / 2 +
        cos(pos1.latitude * p) *
            cos(pos2.latitude * p) *
            (1 - cos((pos2.longitude - pos1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  Future<void> _showPlaceDetails(Place place) async {
    if (_modalShown) return;
    _modalShown = true;

    try {
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: AppPadding.allNormal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Texts(
                  place.name,
                  fontSize: AppSize.fontNormalBig,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(place.imageUrl),
                ),
              ],
            ),
          );
        },
        barrierColor: context.dialogBarrier.withOpacity(0.3),
      );
    } finally {
      setState(() {
        _modalShown = false;
      });
    }
  }
}

class Place {
  final LatLng location;
  final String name;
  final String imageUrl;

  Place({
    required this.location,
    required this.name,
    required this.imageUrl,
  });
}
