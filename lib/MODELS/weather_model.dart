import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../CONSTANTS/weather_constants.dart';

class Weather {
  final String locationName;
  final String iconUrl;
  final double temperature;
  final String description;
  final AssetImage bg;
  Icon weatherIcon;
  String sunrise;
  String sunset;
  String last_updated;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double wind;

  Weather({
    required this.locationName,
    required this.iconUrl,
    required this.temperature,
    required this.description,
    required this.bg,
    required this.weatherIcon,
    required this.sunrise,
    required this.sunset,
    required this.last_updated,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final iconCode = weather['icon'];
    final iconUrl = 'https://openweathermap.org/img/w/$iconCode.png';
    final temperature = main['temp'];
    final description = weather['description'];
    final locationName = json['name'];
    final condition = json['weather'][0]['id'];
    final feelsLike = main['feels_like'];
    final pressure = main['pressure'];
    final humidity = main['humidity'];
    final wind = json['wind']['speed'];
    var sr = json['sys']['sunrise'];
    var ss = json['sys']['sunset'];
    var lu = json['dt'];
    var last_updated = DateTime.fromMillisecondsSinceEpoch(lu).toString();
    var sunrise = DateTime.fromMillisecondsSinceEpoch(sr).toString();
    var sunset = DateTime.fromMillisecondsSinceEpoch(ss).toString();

    if (condition < 600) {
      return Weather(
          locationName: locationName,
          iconUrl: iconUrl,
          temperature: temperature,
          description: description,
          bg: AssetImage('assets/icons/cloud.png'),
          weatherIcon: kCloudIcon,
          feelsLike: feelsLike,
          humidity: humidity,
          last_updated: last_updated,
          pressure: pressure,
          sunrise: sunrise,
          sunset: sunset,
          wind: wind);
    } else {
      var now = new DateTime.now();

      if (now.hour >= 17) {
        return Weather(
            locationName: locationName,
            iconUrl: iconUrl,
            temperature: temperature,
            description: description,
            bg: AssetImage('assets/icons/night.png'),
            weatherIcon: kMoonIcon,
            feelsLike: feelsLike,
            humidity: humidity,
            last_updated: last_updated,
            pressure: pressure,
            sunrise: sunrise,
            sunset: sunset,
            wind: wind);
      } else {
        return Weather(
            locationName: locationName,
            iconUrl: iconUrl,
            temperature: temperature,
            description: description,
            bg: AssetImage('assets/icons/sunny.png'),
            weatherIcon: kSunIcon,
            feelsLike: feelsLike,
            humidity: humidity,
            last_updated: last_updated,
            pressure: pressure,
            sunrise: sunrise,
            sunset: sunset,
            wind: wind);
      }
    }
  }
  static Future<Weather> fetch(double latitude, double longitude) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=21d6e175e99da7893408f2c0d5f60fdc';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
