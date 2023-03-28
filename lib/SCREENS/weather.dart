import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../MODELS/weather_model.dart';

class WeatherApp extends StatefulWidget {
  final double? latitude, longitude;
  const WeatherApp({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late double lat;
  late double long;
  late Future<Weather> _futureWeather;

  @override
  void initState() {
    super.initState();
    lat = widget.latitude!;
    long = widget.longitude!;
    if (lat != null && long != null) _futureWeather = Weather.fetch(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: weather.bg,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: weather.weatherIcon,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather.temperature.toString()}°C',
                          style: TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                          weather.iconUrl,
                          cacheWidth: 1000,
                          cacheHeight: 1000,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Feels Like ${weather.feelsLike.toString()}°C',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      weather.description,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weather.locationName,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   'Last Updated in:${weather.last_updated}}',
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Sunrise: ${weather.sunrise}}',
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     Text(
                    //       'Sunset: ${weather.sunset}}',
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      color: Colors.lightBlue.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Wind',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Pressure',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.lightBlue.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${weather.wind}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${weather.pressure}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${weather.humidity}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.lightBlue.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.wind,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.alarm,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            Icon(
                              FontAwesomeIcons.droplet,
                              size: 30.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
