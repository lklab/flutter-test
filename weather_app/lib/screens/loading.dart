import 'package:flutter/material.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';

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

    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    print(url);
    Network network = Network(url);
    var weatherData = await network.getJsonData();
    print(weatherData);
  }

  void fetchData() async {
    // Uri uri = Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    // http.Response response = await http.get(uri);

    // if(response.statusCode == 200) {
    //   String jsonData = response.body;
    //   var myJson = jsonDecode(jsonData);
    //   var description = myJson['weather'][0]['description'];
    //   var wind = myJson['wind']['speed'];
    //   var id = myJson['id'];
    //   print('description: $description\nwind: $wind\nid: $id');
    // }
    // else {
    //   print(response.statusCode);
    // }
  }
}
