import 'package:geolocator/geolocator.dart';

class MyLocation {

  double latitude = 0;
  double longitude = 0;

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    try {
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    }
    catch(e) {
      print('There was a problem with the internet connection.');
    }
  }

}
