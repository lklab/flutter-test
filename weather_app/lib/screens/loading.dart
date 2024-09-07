import 'package:flutter/material.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const String apiKey = '';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    getLocation();
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
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    latitude = myLocation.latitude;
    longitude = myLocation.longitude;

    String weatherUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    Network weatherNetwork = Network(weatherUrl);
    var weatherData = await weatherNetwork.getJsonData();
    // print(weatherData);

    String airUrl = 'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey';
    Network airNetwork = Network(airUrl);
    var airData = await airNetwork.getJsonData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirData: airData,
      );
    }));
  }
}
