import 'package:fh_wave/views/widgets/buttons/secondary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../app_colors.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/user_controller.dart';
import 'widgets/buttons/primary_button.dart';

GroupController groupController = GroupController();
UserController userController = UserController();

User? currentUser = userController.currentUser;

//TODO Liste mit Gruppennamen befüllen
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class GroupCalendarScreen extends StatefulWidget {
  const GroupCalendarScreen({Key? key}) : super(key: key);

  @override
  State<GroupCalendarScreen> createState() => _GroupCalendarScreenState();
}

class _GroupCalendarScreenState extends State<GroupCalendarScreen> {
  MyCalendarController calendarController = MyCalendarController();

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
            appointmentTextStyle: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.fhwaveBlue800),
            monthViewSettings: const MonthViewSettings(
              // showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          ),
        ),
        const DropdownButtonExample(),
        MyPopup(),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const When2Meet()),
            );
          },
          child: const Text('When2Meet'),
        ),
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

  String get date =>
      "$eventName - ${from.day}.${from.month}.${from.year} - ${to.day}.${to.month}.${to.year}";

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

  MyCalendarController calendarController = MyCalendarController();

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

bool meetSelection = false;

class When2Meet extends StatefulWidget {
  const When2Meet({Key? key}) : super(key: key);

  @override
  State<When2Meet> createState() => _When2MeetState();
}

class _When2MeetState extends State<When2Meet> {
  MyCalendarController calendarController = MyCalendarController();

  final meetings = <Meeting>[];
  var day1;
  var day2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AppColors.getFhwaveBlueGradientContainer(context),
        ListView(children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
                child: Placeholder(),
              ),
              SfCalendar(
                onTap: (day) {
                  if (meetSelection) {
                    day1ToDay2(day);
                  }
                },
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
              const SizedBox(
                height: 50,
              ),
              when2MeetButton(),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: meetings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(meetings[index].date),
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      ],
    ));
  }

  Widget when2MeetButton() {
    if (!meetSelection) {
      return Column(
        children: [
          SizedBox(
            height: 35,
          ),
          PrimaryButton(
              text: "When2Meet",
              onTap: () {
                setState(() {
                  meetSelection = !meetSelection;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          SecondaryButton(
              text: "Auswertung",
              onTap: () {
                setState(() {});
              })
        ],
      );
    } else {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Du kannst jetzt auswählen, wann du Zeit hast."),
          ),
          PrimaryButton(
              text: "Auswahl abgeben",
              onTap: () {
                setState(() {
                  meetSelection = !meetSelection;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          SecondaryButton(
              text: "Auswahl zurücksetzen",
              onTap: () {
                setState(meetings.clear);
              }),
        ],
      );
    }
  }

  void day1ToDay2(CalendarTapDetails day) {
    if (day1 != null) {
      day2 = day.date;

      setState(() {
        meetings.add(
            Meeting("When2Meet", day1, day2, AppColors.fhwaveBlue600, false));

        day1 = null;
        day2 = null;
      });
    } else {
      day1 = day.date;
    }
  }

  List<Meeting> _getDataSource() {
    //
    // final today = DateTime.now();
    // var startTime = DateTime(today.year, today.month, today.day, 9);
    // final endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(
    //   Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false),
    // );
    //
    // startTime = DateTime(today.year, today.month, 20, 9);
    // meetings.add(
    //     Meeting("Klausur", startTime, endTime, const Color(0xFFf2c232), false));
    return meetings;
  }
}
