// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locations/app/controllers/map_controller.dart';

class LocationMaps extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LocationMaps({super.key});

  MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: mapController.coordinates.value,
          tilt: 15,
          zoom: 5,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: mapController.coordinates.value,
                zoom: 5,
                tilt: 15,
              ),
            ),
          );
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: mapController.coordinates.value,
                zoom: 5,
                tilt: 15,
              ),
            ),
          );
        },
        markers: {
          Marker(
            markerId: const MarkerId("Initial"),
            position: mapController.coordinates.value,
          ),
        },
      ),
    );
  }
}