import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../app_colors.dart';
import '../controllers/dark_mode_controller.dart';
import '../models/building_plan.dart';
import 'widgets/auto_complete_widget.dart';
import 'widgets/buttons/primary_button_with_icon.dart';

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
    Building(
        name: 'C13',
        address: 'Fachhochschule Kiel Informatik und'
            ' Elektrotechnik'),
    Building(name: 'C33', address: 'Heikendorfer Weg 37, 24149 Kiel'),
    Building(name: 'C34', address: 'Heikendorfer Weg 35, 24149 Kiel'),
    Building(name: 'C14', address: 'Grenzstrasse 17, 24149 Kiel'),
    Building(name: 'C15', address: 'Grenzstraße 14, 24149 Kiel'),
    Building(
        name: 'C11',
        address: 'Hochspannungs- und Blitzlabor der FH Kiel,'
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

  void setSelectedBuilding(Building newSelectedBuilding) {
    setState(() {
      selectedBuilding = newSelectedBuilding;
    });
  }

  void requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    if (permissionStatus == LocationPermission.denied ||
        permissionStatus == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(''
            'Location services are disabled. Please enable the services.'),
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
          _currentAddress = '${address.street}, ${address.postalCode} '
              '${address.locality}';
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
      final origin = Uri.encodeComponent(_currentAddress);
      final url =
          'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&dir_action=navigate';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        debugPrint('Could not launch $url');
      }
    }
  }

  void loadMapStyle() async {
    try {
      final style = await DefaultAssetBundle.of(context)
          .loadString('assets/mapStyle.json');
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
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 345,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoCompleteInput(
                  buildingOptions: buildingList,
                  handleSelect: setSelectedBuilding,
                ),
              ),
            ),
            selectedBuilding != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:
                        Text('Ausgewähltes Gebäude: ${selectedBuilding!.name}'),
                  )
                : const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Aktuell ist kein Gebäude ausgewählt."),
                  ),
            Center(
              child: Container(
                width: 345,
                height: 352,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: isDataLoading
                      ? Center(
                          child: Image.asset(
                            controller.isDarkMode
                                ? "assets/fhwave-loading-weiss.gif"
                                : "assets/fhwave-loading-schwarz.gif",
                            gaplessPlayback: true,
                            width: 60.0,
                          ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      Text(_currentAddress,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.fhwaveNeutral400,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            PrimaryButtonWithIcon(
              icon: Icons.map,
              text: "Navigiere mich",
              onTap: openMaps,
            ),
          ],
        ),
      );
    });
  }
}
