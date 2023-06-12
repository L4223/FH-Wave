import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/building_plan.dart';

class BuildingPlanWidget extends StatelessWidget {
  const BuildingPlanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isFetchingPosition = true;
  late Position _currentPosition;
  String _currentAddress = '';
  Building? selectedBuilding;
  List<Building> buildingList = [
    Building(name: 'C12', address: 'Grenzstraße 3, 24149 Kiel'),
    Building(name: 'C13', address: 'Fachhochschule Kiel Informatik und'
        ' Elektrotechnik'),
    Building(name: 'C33', address: 'Heikendorfer Weg 37, 24149 Kiel'),
    Building(name: 'C34', address: 'Heikendorfer Weg 35, 24149 Kiel'),
    Building(name: 'C14', address: 'Grenzstrasse 17, 24149 Kiel'),
    Building(name: 'C15', address: 'Grenzstraße 14, 24149 Kiel'),
    Building(name: 'C11', address: 'Hochspannungs- und Blitzlabor der FH Kiel,'
        ' 24149 Kiel'),
    Building(name: 'C32', address: 'Moorblöcken 1a , 24149 Kiel'),
    Building(name: 'C06', address: 'Schwentinestrasse 7, 24149 Kiel'),
    Building(name: 'C20', address: 'Schwentinestrasse 24, 24149 Kiel'),
    Building(name: 'C22', address: 'Luisenstrasse 25, 24149 Kiel'),
    Building(name: 'C21', address: 'Eichenbergskamp 8, 24149 Kiel'),
    Building(name: 'C22', address: 'Luisenstrasse 25, 24149 Kiel'),
    Building(name: 'C08', address: 'Luisenstrasse , 24149 Kiel'),
    Building(name: 'C02', address: 'Sokratesplatz 6, 24149 Kiel'),
    Building(name: 'C01', address: 'Sokratesplatz 1, 24149 Kiel'),
    Building(name: 'C19', address: 'Sokratesplatz 4, 24149 Kiel'),
    Building(name: 'C03', address: 'Sokratesplatz 1, 24149 Kiel'),
    Building(name: 'C05', address: 'Schwentinestrasse 13, 24149 Kiel'),
    Building(name: 'C31', address: 'Luisenstrasse 25, 24149 Kiel'), //ergänzen
    Building(name: 'C04', address: 'Luisenstrasse 25, 24149 Kiel'), //ergänzen
    Building(name: 'C18', address: 'Zulassungsstelle FH Kiel, 24149 Kiel'),
    // Rest of the building list
  ];
  List<Building> filteredBuildingList = [];
  bool isDataLoading = true;
  String mapStyle = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    loadMapStyle();
  }

  void requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    if (permissionStatus == LocationPermission.denied ||
        permissionStatus == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services.'),
      ));
    } else {
      getCurrentLocation();
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
      } else {
        throw Exception('No address found.');
      }
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        isDataLoading = false;
      });
    }
  }

  void openMaps() async {
    if (selectedBuilding != null) {
      final destination = Uri.encodeComponent(selectedBuilding!.address);
      final url = 'https://www.google.com/maps/dir/?api=1&origin=$_currentAddress&destination=$destination&dir_action=navigate';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        debugPrint('Could not launch $url');
      }
    }
  }


  void loadMapStyle() async {
    try {
      final String style = await DefaultAssetBundle.of(context).loadString('assets/mapStyle.json');
      setState(() {
        mapStyle = style;
      });
    } catch (e) {
      debugPrint('Failed to load map style: $e');
    }
  }

  void getCurrentLocation() async {
    try {
      setState(() {
        isFetchingPosition = true;
      });

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });

      getAddressFromCoordinates();
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        isFetchingPosition = false;
      });
    }
  }

  void filterBuildingList(String query) {
    final lowercaseQuery = query.toLowerCase();
    setState(() {
      filteredBuildingList = buildingList.where((building) {
        final lowercaseName = building.name.toLowerCase();
        return lowercaseName.contains(lowercaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: 345,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                filterBuildingList(value);
              },
            ),
          ),
        ),

        Container(
    width: 345,
    height: 352,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [

    ],
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: isDataLoading
    ? Center(
    child: CircularProgressIndicator(),
    )
        : GoogleMap(
    initialCameraPosition: CameraPosition(
    target: LatLng(
    _currentPosition.latitude,
    _currentPosition.longitude,
    ),
    zoom: 11.0,
    ),
    ),
    ),
    ),
        Flexible(
          fit: FlexFit.tight,
          child: isDataLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: filteredBuildingList.length,
            itemBuilder: (context, index) {
              final building = filteredBuildingList[index];
              return ListTile(
                title: Text(building.name),
                subtitle: Text(building.address),
                onTap: () {
                  setState(() {
                    selectedBuilding = building;
                    searchController.text = building.name; // Set the search text to the selected building name
                  });
                },
              );
            },
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Address: $_currentAddress'),
        ),
        ElevatedButton(
          onPressed: openMaps,
          child: const Text('Open Maps'),
        ),
      ],
    );
  }
}
