import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/transport_controller.dart';

class TransportView extends GetView<TransportController> {
  TransportView({Key? key}) : super(key: key);

  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransportView'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
