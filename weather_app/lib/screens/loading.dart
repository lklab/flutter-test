import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Get my location'),
        ),
      ),
    );
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    try {
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      print(position);
    }
    catch(e) {
      print('There was a problem with the internet connection.');
    }
  }

  void fetchData() async {
    Uri uri = Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    http.Response response = await http.get(uri);

    if(response.statusCode == 200) {
      String jsonData = response.body;
      var myJson = jsonDecode(jsonData);
      var description = myJson['weather'][0]['description'];
      var wind = myJson['wind']['speed'];
      var id = myJson['id'];
      print('description: $description\nwind: $wind\nid: $id');
    }
  }
}
