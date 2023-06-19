import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/time_table.dart';
import '../../models/time_table.dart';
import 'group_widgets/appbar.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  TimeTableController controllerChart = TimeTableController();

  ModelChart modelChart = ModelChart();

  //Erstelle Variabblen des Typen Post
  late Future<Post> groupOne;
  late Future<Post> groupTwo;
  late Future<Post> groupThree;

  //Initialisiere die Variablen des Typen Posts und fülle sie mit Daten
  @override
  void initState() {
    super.initState();
    groupOne = controllerChart.fetchPost(1);
    groupTwo = controllerChart.fetchPost(2);
    groupThree = controllerChart.fetchPost(3);
  }

  //aktive Seite
  int _activePage = 0;

  //öffne Seite auf der Fo
  final controller = PageController(initialPage: (0));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Stundenplan"),
        //   backgroundColor: AppColors.fhwaveGreen500,
        // ),
        body: Stack(children: [
      AppColors.getFhwaveGreenGradientContainer(context),
      Padding(
        padding: const EdgeInsets.only(top: 220),
        // 你需要自己决定这个值，这个值应该大于或等于 TransparentAppbar 的高度
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
              if (kDebugMode) {
                print("Aktuelle Seite: Gruppe ${_activePage + 1}");
              }
            });
          },
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: modelChart.getPie(groupOne),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: modelChart.getPie(groupTwo),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                child: modelChart.getPie(groupThree)),
          ],
        ),
      ),
      Positioned(
        top: 70,
        child: TransparentAppbar(
          heading: "Gruppen",
          route: "/home",
        ),
      ),
    ]));
  }
}
