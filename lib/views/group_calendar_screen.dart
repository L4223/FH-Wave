import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../app_colors.dart';
import '../controllers/appointment_controller.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/user_controller.dart';

GroupController groupController = GroupController();
UserController userController = UserController();
AppointmentController appointmentController = AppointmentController();
MyCalendarController calendarController = MyCalendarController();

User? currentUser = userController.currentUser;

class GroupCalendarScreen extends StatefulWidget {
  const GroupCalendarScreen({Key? key}) : super(key: key);

  @override
  State<GroupCalendarScreen> createState() => _GroupCalendarScreenState();
}

class _GroupCalendarScreenState extends State<GroupCalendarScreen> {
  List<String> groupNames = [];

  @override
  void initState() {
    super.initState();
    fetchUserGroups();
  }

  Future<void> fetchUserGroups() async {
    List<DocumentSnapshot> groupDocs =
        await groupController.getUserGroups(currentUser!.uid);

    setState(() {
      groupNames =
          groupDocs.map((doc) => doc['groupName'] as String).toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              headerStyle: CalendarHeaderStyle(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Helvetica-Bold',
                ),
              ),
              appointmentTextStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Helvetica',
              ),
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            ),
          ),
          DropdownButtonExample(groupNames: groupNames),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: MyPopup(),
            ),
          ),
          Text(currentUser!.uid),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final meetings = <Meeting>[];
    final today = DateTime.now();
    var startTime = DateTime(today.year, today.month, today.day, 9);
    final endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting('Conference', startTime, endTime, AppColors.fhwaveBlue500, false),
    );
    startTime = DateTime(today.year, today.month, 5, 9);
    meetings.add(Meeting(
        "Klausur", startTime, endTime, AppColors.fhwaveGreen500, false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class DropdownButtonExample extends StatefulWidget {
  final List<String> groupNames;

  const DropdownButtonExample({Key? key, required this.groupNames})
      : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    if (widget.groupNames.isEmpty) {
      return Text('Keine Gruppennamen vorhanden');
    }

    if (!widget.groupNames.contains(dropdownValue)) {
      dropdownValue = widget.groupNames.first;
    }

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: AppColors.fhwavePurple500),
      underline: Container(
        height: 2,
        color: AppColors.fhwavePurple500,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.groupNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MyPopup extends StatefulWidget {
  @override
  _MyPopupState createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController timeTextController = TextEditingController();

  @override
  void dispose() {
    nameTextController.dispose();
    descriptionTextController.dispose();
    dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Neuer Termin'),
              content: Column(
                children: [
                  TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: descriptionTextController,
                    decoration:
                        const InputDecoration(labelText: 'Beschreibung'),
                  ),
                  TextField(
                    controller: dateTextController,
                    decoration: const InputDecoration(labelText: 'Datum'),
                  ),
                  TextField(
                    controller: timeTextController,
                    decoration: const InputDecoration(labelText: 'Uhrzeit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      calendarController.craeteNewAppointment(
                        "9PuKNCIq7rgQ36EvLJbh",
                        "Fortnite",
                        "Battlepass lvl 100",
                        DateTime.parse('1969-07-20 20:18:04Z'),
                      );
                    },
                    child: const Text("Termin erstellen"),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Schließen'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
