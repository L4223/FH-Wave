import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Position _currentPosition;

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
      // Berechtigung wurde nicht gewährt, behandeln Sie den Fall entsprechend
    }
  }

  void getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentPosition != null)
                Text('Latitude: ${_currentPosition.latitude}\n'
                    'Longitude: ${_currentPosition.longitude}')
              else
                Text('Berechtigung zur Standortbestimmung fehlt.'),
            ],
          ),
        ),
      ),
    );
  }
}


