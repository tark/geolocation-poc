import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/log.dart';
import 'common_widgets/texts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(0, 0);
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  Timer? _timer;
  var _permissionGranted = false;

  @override
  void initState() {
    _checkPermissions();
    // _timer = Timer.periodic(
    //   const Duration(
    //     seconds: 1,
    //   ),
    //   (t) {
    //     _getCurrentLocation();
    //   },
    // );

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Geolocation POC'),
      ),
      backgroundColor: Colors.blue,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 15,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          _getCurrentLocation();
        },
        markers: _markers,
        circles: _circles,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
      ),
    );
  }

  //
  Future<void> _checkPermissions() async {
    l('_checkPermissions');
    var status = await Permission.location.status;
    l('_checkPermissions', 'status: $status');
    if (!status.isGranted) {
      await Permission.location.request();
    }
    if (await Permission.location.isGranted) {
      setState(() => _permissionGranted = true);
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    l('_getCurrentLocation');
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentPosition = LatLng(position.latitude, position.longitude);
    _updateMarkerAndCircle(_currentPosition);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition, 19),
    );
  }

  void _updateMarkerAndCircle(LatLng position) {
    setState(() {
      _markers.clear();
      _circles.clear();
      // _markers.add(
      //   Marker(
      //     markerId: MarkerId('currentLocation'),
      //     position: position,
      //     draggable: true,
      //     onDragEnd: (newPosition) {
      //       _updateMarkerAndCircle(newPosition);
      //       _mapController?.animateCamera(
      //         CameraUpdate.newLatLng(newPosition),
      //       );
      //     },
      //   ),
      // );
      _circles.add(
        Circle(
          circleId: CircleId('currentLocationCircle'),
          center: position,
          radius: 2,
          fillColor: Colors.blue.withOpacity(0.5),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
    });
  }
}
