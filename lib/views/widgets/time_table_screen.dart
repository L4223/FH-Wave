import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../controllers/dark_mode_controller.dart';
import '../../controllers/time_table.dart';
import '../../models/time_table.dart';
import 'group_widgets/appbar.dart';


class TimeTablePage extends StatefulWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {

  Time_Table_Controller controller_chart = Time_Table_Controller();

  Model_Chart modelChart = Model_Chart();

  //Erstelle Variabblen des Typen Post
  late Future<Post> groupOne;
  late Future<Post> groupTwo;
  late Future<Post> groupThree;

  //Initialisiere die Variablen des Typen Posts und fülle sie mit Daten
  @override
  void initState() {
    super.initState();
    groupOne = controller_chart.fetchPost(1);
    groupTwo = controller_chart.fetchPost(2);
    groupThree = controller_chart.fetchPost(3);
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
      appBar: AppBar(
        title: Text("Auswertung"),
      ),
      body: Container(
        child: PageView(
          controller: controller,
          onPageChanged: (int index) {
            setState(() {
              _activePage = index;
              print("Aktuelle Seite: Gruppe ${_activePage + 1}");
            });
          },
          // Erstelle die verschiedenen drei Seiten
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
    );
  }
}


// class TimeTableItem {
//   final int id;
//   final int block1;
//   final int block2;
//   final int block3;
//   final int block4;
//   final int block5;
//   final List<int> blockStart;
//
//   TimeTableItem({
//     required this.id,
//     required this.block1,
//     required this.block2,
//     required this.block3,
//     required this.block4,
//     required this.block5,
//     required this.blockStart,
//   });
//
//   factory TimeTableItem.fromJson(Map<String, dynamic> json) {
//     return TimeTableItem(
//       id: json['id'],
//       block1: json['Block_1'],
//       block2: json['Block_2'],
//       block3: json['Block_3'],
//       block4: json['Block_4'],
//       block5: json['Block_5'],
//       blockStart: List<int>.from(json['Block_start']),
//     );
//   }
// }
//
// // ignore: must_be_immutable
// class TimeTablePage extends StatelessWidget {
//   String jsonText = '''
//   [
//     {
//       "id": 1,
//       "Block_1": 24,
//       "Block_2": 15,
//       "Block_3": 14,
//       "Block_4": 1,
//       "Block_5": 10,
//       "Block_start": [
//         1,
//         2,
//         3,
//         4,
//         24,
//         5,
//         9,
//         1
//       ]
//     }
//   ]
//   ''';
//
//   TimeTablePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> jsonData = jsonDecode(jsonText);
//
//     var timeTableItems = jsonData.map((dynamic item) {
//       return TimeTableItem.fromJson(item);
//     }).toList();
//
//     final chartData = createChartData(timeTableItems);
//     return Consumer<DarkModeController>(builder: (context, controller, _) {
//       return Scaffold(
//         // appBar: AppBar(
//         //   title: const Text("Stundenplan"),
//         //   backgroundColor: AppColors.fhwaveGreen500,
//         // ),
//         body: Stack(
//           children: [
//             AppColors.getFhwaveGreenGradientContainer(context),
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 70,
//                 ),
//                 TransparentAppbar(
//                   heading: "Stundenplan",
//                   route: "/home",
//                 ),
//                 AspectRatio(
//                   aspectRatio: 1,
//                   child: PieChart(
//                     dataMap: chartData,
//                     animationDuration: const Duration(milliseconds: 800),
//                     chartLegendSpacing: 32,
//                     chartRadius: MediaQuery
//                         .of(context)
//                         .size
//                         .width / 2.7,
//                     initialAngleInDegree: 0,
//                     chartType: ChartType.ring,
//                     ringStrokeWidth: 32,
//                     legendOptions: const LegendOptions(
//                       showLegendsInRow: true,
//                       legendPosition: LegendPosition.bottom,
//                       showLegends: true,
//                       legendTextStyle:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                     ),
//                     chartValuesOptions: const ChartValuesOptions(
//                       showChartValues: false,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                     height: 100,
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width - 50,
//                     child: Center(
//                       child: Text(
//                         "Das ist der Frühaufsteherplan!",
//                         style: TextStyle(
//                             fontSize: 24,
//                             color: controller.isDarkMode ?
//                             AppColors.white : AppColors.black,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//                 Flexible(
//                   child: SvgPicture.asset(
//                     'assets/fruehaufsteher.svg',
//                     width: 200,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Map<String, double> createChartData(List<TimeTableItem> scheduleItems) {
//     final chartData = <String, double>{};
//     final totalBlocks = scheduleItems.length * 5; // Assuming there are 5 blocks
//     // per item
//
//     final blockCounts = <String, int>{
//       '08:30': 0,
//       '10:15': 0,
//       '12:45': 0,
//       '14:30': 0,
//       '16:15': 0,
//     };
//
//     for (final item in scheduleItems) {
//
//       blockCounts['08:30'] = item.block1;
//       blockCounts['10:15'] = item.block2;
//       blockCounts['12:45'] = item.block3;
//       blockCounts['14:30'] = item.block4;
//       blockCounts['16:15'] = item.block5;
//     }
//
//     for (final block in blockCounts.keys) {
//       final count = blockCounts[block]!;
//       final share = count / totalBlocks;
//       chartData[block] = share;
//     }
//
//     return chartData;
//   }
// }
