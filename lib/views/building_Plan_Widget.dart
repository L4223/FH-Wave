import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fh_wave/models/building_plan.dart';

import '../models/building_plan.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  late Position _currentPosition;
  String _currentAddress = '';
  Building? selectedBuilding;
  List<Building> buildingList =   [
  Building(name: 'C12', address:'Grenzstraße 3, 24149 Kiel'),
  Building(name: 'C13', address:'Fachhochschule Kiel Informatik und Elektrotechnik'),
  Building(name: 'C33', address:'Heikendorfer Weg 37, 24149 Kiel'),
  Building(name: 'C34', address:'Heikendorfer Weg 35, 24149 Kiel'),
  Building(name: 'C14', address:'Grenzstrasse 17, 24149 Kiel'),
  Building(name: 'C15', address:'Grenzstraße 14, 24149 Kiel'),
  Building(name: 'C11', address:'Hochspannungs- und Blitzlabor der FH Kiel, 24149 Kiel'),
  Building(name: 'C32', address:'Moorblöcken 1a , 24149 Kiel'),
  Building(name: 'C06', address:'Schwentinestrasse 7, 24149 Kiel'),
  Building(name: 'C20', address:'Schwentinestrasse 24, 24149 Kiel'),
  Building(name: 'C22', address:'Luisenstrasse 25, 24149 Kiel'),
  Building(name: 'C21', address:'Eichenbergskamp 8, 24149 Kiel'),
  Building(name: 'C22', address:'Luisenstrasse 25, 24149 Kiel'),
  Building(name: 'C08', address:'Luisenstrasse , 24149 Kiel'),
  Building(name: 'C02', address:'Sokratesplatz 6, 24149 Kiel'),
  Building(name: 'C01', address:'Sokratesplatz 1, 24149 Kiel'),
  Building(name: 'C19', address:'Sokratesplatz 4, 24149 Kiel'),
  Building(name: 'C03', address:'Sokratesplatz 1, 24149 Kiel'),
  Building(name: 'C05', address:'Schwentinestrasse 13, 24149 Kiel'),
  Building(name: 'C31', address:'Luisenstrasse 25, 24149 Kiel'), //ergänzen
  Building(name: 'C04', address:'Luisenstrasse 25, 24149 Kiel'), //ergänzen
  Building(name: 'C18', address:'Zulassungsstelle FH Kiel, 24149 Kiel'),

  ];

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      getCurrentLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services'),
      ));
    }
  }

  void getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });

      getAddressFromCoordinates();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> getAddressFromCoordinates() async {
    try {
      final addresses = await placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

      if (addresses.isNotEmpty) {
        final address = addresses.first;
        setState(() {
          _currentAddress = '${address.street}, ${address.postalCode} ${address.locality}';
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void openMaps() async {
    if (selectedBuilding != null) {
      final url = 'https://www.google.com/maps/dir/?api=1&origin=$_currentAddress&destination=${Uri.encodeComponent(selectedBuilding!.address)}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        debugPrint('Could not launch $url');
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
      _currentPosition.latitude,
      _currentPosition.longitude,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator & Google Maps App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentPosition != null
                ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                ),
                zoom: 11.0,
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Address: $_currentAddress'),
          ),
          DropdownButton<Building>(
            value: selectedBuilding,
            onChanged: (newValue) {
              setState(() {
                selectedBuilding = newValue;
              });
            },
            items: buildingList.map((building) {
              return DropdownMenuItem<Building>(
                value: building,
                child: Text(building.name),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: openMaps,
            child: const Text('Open Maps'),
          ),
        ],
      ),
    );
  }
}
