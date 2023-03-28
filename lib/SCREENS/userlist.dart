import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test_app/MODELS/weather_model.dart';
import 'Map_View.dart';
import 'weather.dart';

class AppUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Card(
                    child: ListTile(
                  leading: Text(document['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapView(
                                  latitude: double.parse(
                                      document['latitude'].toString()),
                                  longitude: double.parse(
                                      document['longitude'].toString()),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.lightBlue,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherApp(
                                  latitude: double.parse(
                                      document['latitude'].toString()),
                                  longitude: double.parse(
                                      document['longitude'].toString()),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.cloud_sharp,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                )),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
