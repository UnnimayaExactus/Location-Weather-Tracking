import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  final double? latitude, longitude;
  const MapView({Key? key, this.latitude, this.longitude}) : super(key: key);
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late double latitude;
  late double longitude;
  MapController controller = new MapController();
  @override
  void initState() {
    latitude = widget.latitude!;
    longitude = widget.longitude!;
    print('INSIDE MAP INIT');
    print(latitude.toString() + '...........');
    print(longitude.toString() + '...........');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.lightBlue,
        title: const Text("Map"),
      ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(center: LatLng(latitude, longitude), minZoom: 9.0),
        children: [
          TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayer(markers: [
            Marker(
                width: 45.0,
                height: 45.0,
                point: LatLng(latitude, longitude),
                builder: (context) => IconButton(
                    icon: const Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () {
                      print("Success");
                    }))
          ])
        ],
      ),
    );
  }
}
