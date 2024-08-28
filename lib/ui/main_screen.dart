import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocation_poc/util/util.dart';
import 'package:geolocation_poc/ui/common_widgets/texts.dart';
import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
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
      location: LatLng(-33.90508758118587, 151.18199288959056),
      name: "25 Devine St",
      imageUrl: "assets/images/25.jpeg",
    ),
    Place(
      location: LatLng(-33.90496069147935, 151.18175149080162),
      name: "17 Devine St",
      imageUrl: "assets/images/17.jpeg",
    ),
    Place(
      location: LatLng(-33.904907264178014, 151.18157982944055),
      name: "9 Devine St",
      imageUrl: "assets/images/25.jpeg",
    ),
    Place(
      location: LatLng(-33.9048271231632, 151.1814269435409),
      name: "1 Devine St",
      imageUrl: "assets/images/25.jpeg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    requestLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadCustomMarkers() async {
    _userMarkerIcon = await _createCircleMarker(40, Colors.blue);
    _placeMarkerIcon = await _createCircleMarker(40, Colors.red);
  }

  Future<BitmapDescriptor> _createCircleMarker(
      int diameter, Color color) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(diameter / 2, diameter / 2), diameter / 2, paint);
    final picture = recorder.endRecording();
    final image = await picture.toImage(diameter, diameter);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation POC'),
      ),
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
          const CircularProgressIndicator(),
          Vertical.big(),
          const Texts('Waiting for location permission...'),
          ElevatedButton(
            onPressed: requestLocationPermission,
            child: const Texts('Retry'),
          ),
        ],
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
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
      _currentPosition =
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
      _moveCameraToPosition(_currentPosition);
      _checkProximityToPlaces();
      setState(() {});
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
          markerId: MarkerId('user'),
          position: _currentPosition,
          icon: _userMarkerIcon!,
        ),
      );
    }

    for (var place in _places) {
      if (_placeMarkerIcon != null) {
        markers.add(
          Marker(
            markerId: MarkerId(place.location.toString()),
            position: place.location,
            icon: _placeMarkerIcon!,
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
      if (_calculateDistance(_currentPosition, place.location) < 10 &&
          !_modalShown) {
        _showPlaceDetails(place);
        _modalShown = true;
        break;
      } else if (_calculateDistance(_currentPosition, place.location) >= 10) {
        _modalShown = false;
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

  void _showPlaceDetails(Place place) {
    showBottomModal(
      context: context,
      builder: (context) {
        return Padding(
          padding: AppPadding.allNormal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(place.imageUrl),
              Vertical.medium(),
              Texts(
                place.name,
              ),
            ],
          ),
        );
      },
    );
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
