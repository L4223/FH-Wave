import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controllers/calendar_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/user_controller.dart';

GroupController groupController = GroupController();
UserController userController = UserController();
MyCalendarController calendarController = MyCalendarController();

User? currentUser = userController.currentUser;

//TODO Liste mit Gruppennamen befüllen
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class GroupCalendarScreen extends StatefulWidget {
  const GroupCalendarScreen({Key? key}) : super(key: key);

  @override
  State<GroupCalendarScreen> createState() => _GroupCalendarScreenState();
}

class _GroupCalendarScreenState extends State<GroupCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 300,
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(_getDataSource()),
            // by default the month appointment display mode set as Indicator, we can
            // change the display mode as appointment using the appointment display
            // mode property
            monthViewSettings: const MonthViewSettings(
                // showAgenda: true,
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ),
        DropdownButtonExample(),
        MyPopup(),
        Text(currentUser!.uid)
      ],
    ));
  }

  List<Meeting> _getDataSource() {
    final meetings = <Meeting>[];
    final today = DateTime.now();
    var startTime = DateTime(today.year, today.month, today.day, 9);
    final endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false),
    );
    startTime = DateTime(today.year, today.month, 5, 9);
    meetings.add(
        Meeting("Klausur", startTime, endTime, const Color(0xFFf2c232), false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
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

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
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
    return ElevatedButton(
      child: const Text('Popup öffnen'),
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
                            DateTime.parse('1969-07-20 20:18:04Z'));
                      },
                      child: const Text("Termin erstellen"))
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
