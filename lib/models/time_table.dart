import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../app_colors.dart';
import '../controllers/dark_mode_controller.dart';
import '../controllers/time_table.dart';

class Model_Chart {
  Time_Table_Controller timeTableController = Time_Table_Controller();

  //Farben des PieCharts
  final colorList = <Color>[
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
  ];

  //Index des Statements welches zurückgegeben werden soll
  final int mostBlock1Statement = 0;
  final int changeRoomStatement = 1;
  final int gapsStatement = 2;

  //Style des Textes
  final style = const TextStyle(fontSize: 25, height: 1.5);
  final textAlign = TextAlign.center;

  // Style der Legende
  final legendOptions = const LegendOptions(
    showLegendsInRow: false,
    legendPosition: LegendPosition.right,
    showLegends: true,
    legendShape: BoxShape.circle,
    legendTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );

  //Style der Inhaltoptionen des PieCharts
  final chartValueOptions = const ChartValuesOptions(
    showChartValueBackground: false,
    showChartValues: true,
    showChartValuesInPercentage: true,
    showChartValuesOutside: true,
    decimalPlaces: 0,
  );

  Widget getPie(group) {
    //muss die Daten aus der API laden
    return Consumer<DarkModeController>(builder: (context, controller, _)
    {
      return FutureBuilder<Post>(
          future: group,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Scrollable Widget erstellt, falls der Text zu lang wird für ein Fenster
              return SingleChildScrollView(
                child: Column(children: [
                  Text(
                    "Zu diesen Uhrzeiten solltest du an die FH kommen\n",
                    style: style,
                    textAlign: textAlign,
                  ),
                  // Erstellung des PieChart mit Infos aus der BlockStart Liste der Api
                  PieChart(
                    dataMap: <String, double>{
                      timeTableController.getBlock(
                          snapshot.data!.blockStart[0]):
                      snapshot.data!.blockStart[3].toDouble(),
                      timeTableController.getBlock(
                          snapshot.data!.blockStart[1]):
                      snapshot.data!.blockStart[4].toDouble(),
                      timeTableController.getBlock(
                          snapshot.data!.blockStart[2]):
                      snapshot.data!.blockStart[5].toDouble(),
                    },
                    chartType: ChartType.disc,
                    animationDuration: const Duration(seconds: 0),
                    baseChartColor: Colors.grey[300]!,
                    chartValuesOptions: chartValueOptions,
                    legendOptions: legendOptions,
                    colorList: colorList,
                    chartRadius: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                  ),
                  //Veranstaltungs-Anzahl in Block 1 und Statement
                ]),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          });
    });
  }
}



// import 'dart:convert';
//
// class TimeTableItem {
//   final int id;
//   final int block1;
//   final int block2;
//   final int block3;
//   final int block4;
//   final int block5;
//   final List<int> blockStart;
//   final int gapsNumber;
//   final int aveLastBlock;
//   final String noClass;
//   final String changeRoom;
//   final String gaps;
//   final String mostBlock1;
//
//   TimeTableItem({
//     required this.id,
//     required this.block1,
//     required this.block2,
//     required this.block3,
//     required this.block4,
//     required this.block5,
//     required this.blockStart,
//     required this.gapsNumber,
//     required this.aveLastBlock,
//     required this.noClass,
//     required this.changeRoom,
//     required this.gaps,
//     required this.mostBlock1,
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
//       gapsNumber: json['gaps_number'],
//       aveLastBlock: json['ave_last_block'],
//       noClass: json['no_class'],
//       changeRoom: json['change_room'],
//       gaps: json['gaps'],
//       mostBlock1: json['most_Block_1'],
//     );
//   }
// }
// List<TimeTableItem> parseSchedule(String json) {
//   final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
//   return parsed.map<TimeTableItem>(TimeTableItem.fromJson).
//   toList();
// }
