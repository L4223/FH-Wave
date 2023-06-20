import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_colors.dart';
import '../controllers/dark_mode_controller.dart';
import '../controllers/time_table.dart';
import '../pdf_viewer.dart';
import '../views/widgets/buttons/primary_button_with_icon.dart';




class ModelChart {
  TimeTableController timeTableController = TimeTableController();


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

  late String asset;
  late String statement;




  Widget getPie(dynamic group) {
    //muss die Daten aus der API laden
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return FutureBuilder<Post>(
          future: group,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (timeTableController
                      .getStatementNumber(snapshot.data!.mostBlock1) ==
                  2) {
                asset = 'assets/fruehaufsteher.svg';
                statement = 'Das ist ein Frühaufsteherplan!';
              } else {
                asset = 'assets/ausgeglichen.svg';
                statement = 'Das ist ein ausgeglichener Stundenplan!';
              }
              // Scrollable Widget erstellt,
              // falls der Text zu lang wird für ein Fenster
              return SingleChildScrollView(
                child: Column(children: [
                  Text(
                    'Deine Startzeiten',
                    style: TextStyle(
                        fontSize: 25,
                        color: controller.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Erstellung des PieChart mit Infos
                  // aus der BlockStart Liste der Api
                  PieChart(
                    dataMap: <String, double>{
                      timeTableController
                              .getBlock(snapshot.data!.blockStart[0]):
                          snapshot.data!.blockStart[3].toDouble(),
                      timeTableController
                              .getBlock(snapshot.data!.blockStart[1]):
                          snapshot.data!.blockStart[4].toDouble(),
                      timeTableController
                              .getBlock(snapshot.data!.blockStart[2]):
                          snapshot.data!.blockStart[5].toDouble(),
                      timeTableController
                              .getBlock(snapshot.data!.blockStart[3]):
                          snapshot.data!.blockStart[6].toDouble(),
                    },
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: true,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendTextStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                  SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Center(
                        child: Text(
                          statement,
                          style: TextStyle(
                              fontSize: 24,
                              color: controller.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )),

                  SvgPicture.asset(
                    asset,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButtonWithIcon(
                      icon: Icons.calendar_month,
                      text: "Stundenplan Gruppe ${snapshot.data!.id}",
                    onTap: ()

                      => Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(

                      builder: (_) => PDFViewerFromUrl(
                        url: 'https://www.fh-kiel.de/fileadmin/data/iue/studium/stundenplan_sommersemester/4_ming_${snapshot.data!.id}.pdf',
                      ),
                    ),
                  ),
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
