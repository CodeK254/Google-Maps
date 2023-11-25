import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController{
  Geolocator geolocator = Geolocator();
  bool? locationOn;
  final coordinates = const LatLng(0, 0).obs;

  Future<LatLng> findLocation() async {
    locationOn = await Geolocator.isLocationServiceEnabled();

    if(!locationOn!){
      await Geolocator.openLocationSettings();
    }

    if(locationOn!){
      LocationPermission locationPermission = await Geolocator.checkPermission();

      if(locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever || locationPermission == LocationPermission.unableToDetermine){
        await Geolocator.requestPermission();
        locationPermission = await Geolocator.checkPermission();
      }

      if(locationPermission == LocationPermission.always || locationPermission == LocationPermission.whileInUse){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
        coordinates.value = LatLng(position.latitude, position.longitude);
        print("Latitude: ${position.latitude} Longitude: ${position.longitude}");
      }
    }

    return coordinates.value;
  }

  @override
  void onInit() async {
    await findLocation();
    super.onInit();
  }
}