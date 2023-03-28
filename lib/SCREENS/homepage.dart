import 'package:flutter/material.dart';
import 'package:flutter_test_app/CONSTANTS/future.dart';
import 'package:flutter_test_app/SCREENS/login.dart';
import 'package:flutter_test_app/SCREENS/userlist.dart';
import 'package:flutter_test_app/SCREENS/weather.dart';
import '../CONSTANTS/willpopup.dart';
import 'Map_View.dart';

import 'package:geolocator/geolocator.dart';
import '../widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

late Position _currentPosition;
String _geoLocation = '';
var latitude;
var longitude;

class _HomepageState extends State<Homepage> {
  bool serviceEnabled = false;
  late LocationPermission permission;
  @override
  void initState() {
    permission_handler();
    _getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: Drawer(
          elevation: 10.0,
          child: new ListView(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey.shade500),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            // color: Colors.grey.shade500,
                            iconSize: 30,
                            icon: Icon(Icons.close),
                          ),
                        ),
                        CircleAvatar(
                          child: Text('', style: TextStyle(fontSize: 30)),
                          radius: 30.0,
                        ),
                        Text(
                          'gs_currentUser',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ])),
              ListTile(
                leading: Image.asset('assets/icons/user.webp',
                    width: 55, height: 40),
                title: new Text('Users ist'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AppUser()))
                },
              )
            ],
          )),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            if (latitude != null && longitude != null)
              card(
                  "User Location",
                  MapView(
                    latitude: double.parse(latitude.toString()),
                    longitude: double.parse(longitude.toString()),
                  ),
                  Colors.blue[800],
                  this.context,
                  'map.jpg'),
            if (latitude != null && longitude != null)
              card(
                  "User Weather",
                  WeatherApp(
                    latitude: double.parse(latitude.toString()),
                    longitude: double.parse(longitude.toString()),
                  ),
                  Colors.blue[800],
                  this.context,
                  'weather.png'),
            card(
                "Users", AppUser(), Colors.blue[800], this.context, 'user.webp')
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _currentPosition = position;
      // _geoLocation = "${position.latitude},${position.longitude}";
      latitude = position.latitude;
      longitude = position.longitude;
      print('LAT' + latitude.toString());
      print('LONG' + longitude.toString());
      update_latlong(UserID, latitude, longitude).then((value) {
        print('UPDATE RESULT$value');
      });
    });
  }

  void permission_handler() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled() ?? false;
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
