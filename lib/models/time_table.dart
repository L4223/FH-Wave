import 'dart:convert';

class TimeTableItem {
  final int id;
  final int block1;
  final int block2;
  final int block3;
  final int block4;
  final int block5;
  final List<int> blockStart;
  final int gapsNumber;
  final int aveLastBlock;
  final String noClass;
  final String changeRoom;
  final String gaps;
  final String mostBlock1;

  TimeTableItem({
    required this.id,
    required this.block1,
    required this.block2,
    required this.block3,
    required this.block4,
    required this.block5,
    required this.blockStart,
    required this.gapsNumber,
    required this.aveLastBlock,
    required this.noClass,
    required this.changeRoom,
    required this.gaps,
    required this.mostBlock1,
  });

  factory TimeTableItem.fromJson(Map<String, dynamic> json) {
    return TimeTableItem(
      id: json['id'],
      block1: json['Block_1'],
      block2: json['Block_2'],
      block3: json['Block_3'],
      block4: json['Block_4'],
      block5: json['Block_5'],
      blockStart: List<int>.from(json['Block_start']),
      gapsNumber: json['gaps_number'],
      aveLastBlock: json['ave_last_block'],
      noClass: json['no_class'],
      changeRoom: json['change_room'],
      gaps: json['gaps'],
      mostBlock1: json['most_Block_1'],
    );
  }
}
List<TimeTableItem> parseSchedule(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed.map<TimeTableItem>(TimeTableItem.fromJson).
  toList();
}
