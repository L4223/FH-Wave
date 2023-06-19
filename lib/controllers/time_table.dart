import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TimeTableController {
  //Statements die ausgegeben werden bei der Funktion getStatement
  List<List<String>> statements = [
    [
      "Das ist der Langschläfer Stundenplan.",
      "Der Kalender ist für alle geeignet.",
      "Das ist der Frühaufsteher Stundenplan."
    ],
    ["am seltesten", "gelegentlich", "öfter"],
    [
      "Das ist der Stundenplan für die FH-Besucher. "
          "Dieser Stundeplan hat am wenigsten Lücken.",
      "Dieser Stundenplan hat gelegentlich Lücken.",
      "Das ist der Stundeplan für die FH-Bewohner. "
          "Dieser Stundeplan hat am meisten Lücken."
    ]
  ];

  //Index für die Reihenfolge des Inputs
  final int less = 0;
  final int middle = 1;
  final int most = 2;

  Future<Post> fetchPost(dynamic group) async {
    try {
      // Laden der JSON-Datei aus den Assets
      var jsonString = await rootBundle.loadString('assets/json/stats.json');

      // JSON-Daten parsen
      var jsonData = jsonDecode(jsonString);

      // Zugriff auf die gewünschten Daten
      var stats = jsonData[group - 1];

      return Post.fromJson(stats);
    } catch (e) {
      throw Exception('Fehler beim Laden der JSON-Datei: $e');
    }
  }

// mit Webseite Laden
  // //Lade die API
  // Future<Post> fetchPost(group) async {
  //   final response = await http.get(Uri.parse(
  //       "https://safe-springs-76240.herokuapp.com/api/v1/stats$group"));
  //
  //   if (response.statusCode == 200) {
  //     return Post.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Seite konnte nicht geladen werden');
  //   }
  // }

  //Funktion um ein Statement zurückzubekommen
  String getStatement(String mostBlock1Str, int statementNr) {
    String statement;
    if (mostBlock1Str == "less") {
      statement = statements[statementNr][less];
    } else if (mostBlock1Str == "most") {
      statement = statements[statementNr][most];
    } else if (mostBlock1Str == "middle") {
      statement = statements[statementNr][middle];
    } else {
      return "";
    }
    return statement;
  }

  int getStatementNumber(String statement) {
    var number = 0;
    if (statement == "less") {
      number = less;
    } else if (statement == "most") {
      number = most;
    } else if (statement == "middle") {
      number = middle;
    }
    return number;
  }

  //Funktion um zu schauen ob die API einen Tag oder None übergeben hat
  String isDay(String day) {
    if (day == "None") {
      day = "keinem Tag";
    }
    return day;
  }

  //index für die Uhrzeiten des Blöcke
  final String block1 = "8:30";
  final String block2 = "10:15";
  final String block3 = "12:45";
  final String block4 = "14:30";
  final String block5 = "16:15";
  final String block6 = "18:00";

  //Funktion um die Uhrzeiten des jeweiligen Blocks zu erfragen
  String getBlock(int blockNr) {
    switch (blockNr) {
      case 1:
        {
          return block1;
        }
      case 2:
        {
          return block2;
        }
      case 3:
        {
          return block3;
        }
      case 4:
        {
          return block4;
        }
      case 5:
        {
          return block5;
        }
      default:
        {
          return "Uhrzeit konnte nicht ermittelt werden.";
        }
    }
  }
}

//Erstelle Klasse um die API-Daten in einer Liste abzubilden
class Post {
  final int id;
  final int block1;
  final int block2;
  final int block3;
  final int block4;
  final int block5;
  final List blockStart;
  final String mostBlock1;
  final String changeRoom;
  final String gaps;
  final int aveLastBlock;
  final String noClass;

  Post(
      {required this.id,
      required this.block1,
      required this.block2,
      required this.block3,
      required this.block4,
      required this.block5,
      required this.blockStart,
      required this.mostBlock1,
      required this.changeRoom,
      required this.gaps,
      required this.aveLastBlock,
      required this.noClass});

  //Mappe und erstelle die Klasse Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        block1: json['Block_1'],
        block2: json['Block_2'],
        block3: json['Block_3'],
        block4: json['Block_4'],
        block5: json['Block_5'],
        blockStart: json['Block_start'],
        mostBlock1: json['most_Block_1'],
        changeRoom: json['change_room'],
        gaps: json['gaps'],
        aveLastBlock: json['ave_last_block'],
        noClass: json['no_class']);
  }
}
