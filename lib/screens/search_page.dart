import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage({this.updateUi});
  VoidCallback? updateUi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
        //backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration:  InputDecoration(
              label: Text('search a city'),
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () async {
                  WeatherService service = WeatherService();
                  WeatherModel? weather = await service.getWeather(cityName: cityName!);
                  Provider.of<WeatherProvider>(context,listen: false).cityName = cityName;

                  Navigator.pop(context);
                },

                  child: Icon(Icons.search),),
              hintText: 'Enter city',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            ),

            onSubmitted: (data) async {
              cityName = data;
              WeatherService service = WeatherService();
              WeatherModel? weather =
                  await service.getWeather(cityName: cityName!);

              Provider.of<WeatherProvider>(context,listen: false).weatherData = weather;
              Provider.of<WeatherProvider>(context,listen: false).cityName = cityName;

              Navigator.pop(context);
             
            },

          ),
        ),
      ),
    );
  }
}
