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
  List<Meeting> _meetings = [];
  String groupId = '';

  @override
  void initState() {
    super.initState();
    fetchUserGroups();
  }

  void fetchUserGroups() async {
    List<DocumentSnapshot> groupDocs =
    await groupController.getUserGroups(currentUser!.uid);

    setState(() {
      groupNames =
          groupDocs.map((doc) => doc['groupName'] as String).toSet().toList();
    });

    if (groupNames.isNotEmpty) {
      _fetchMeetings(groupNames[0]);
    }
  }

  void _fetchMeetings(String groupId) {
    setState(() {
      this.groupId = groupId;
    });
    fetchMeetings(groupId);
  }

  Future<void> fetchMeetings(String groupId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .collection('appointments')
          .get();

      final meetings = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final startTime = (data['startTime'] as Timestamp).toDate();
        final endTime = (data['endTime'] as Timestamp).toDate();
        final title = data['title'] as String;
        final colorValue = data['color'] as int; // Änderung hier
        final color = Color(colorValue); // Änderung hier
        final isAllDay = data['isAllDay'] as bool;

        return Meeting(title, startTime, endTime, color, isAllDay);
      }).toList();

      setState(() {
        _meetings = meetings;
      });
    } catch (error) {
      print("Fehler beim Abrufen der Termine: $error");
    }
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
              dataSource: MeetingDataSource(_meetings),
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
              child: MyPopup(groupId: groupId),
            ),
          ),
          Text(currentUser!.uid),
        ],
      ),
    );
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
  static Meeting fromInputData(String name, String description, String date, String time) {
    final DateTime startTime = DateTime.parse(date + ' ' + time);
    final DateTime endTime = startTime.add(Duration(hours: 1));
    final Color color = Colors.blue; // Farbe anpassen

    return Meeting(name, startTime, endTime, color, false);
  }
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
  String groupId = '';


  Future<void> getGroupId() async {
    final String selectedGroupId = await groupController.getGroupIdFromGroupName(dropdownValue);
    setState(() {
      groupId = selectedGroupId;
    });
    _GroupCalendarScreenState screenState = context.findAncestorStateOfType<_GroupCalendarScreenState>()!;
    screenState._fetchMeetings(groupId);
  }


  @override
  Widget build(BuildContext context) {
    if (widget.groupNames.isEmpty) {
      return Text('Keine Gruppennamen vorhanden');
    }

    if (!widget.groupNames.contains(dropdownValue)) {
      dropdownValue = widget.groupNames.first;
    }

    return Column(
      children: [
        DropdownButton<String>(
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
            getGroupId();
          },
          items: widget.groupNames.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text('Ausgewählter Name: $dropdownValue'),
        Text('groupId:$groupId' )
      ],
    );
  }
}

class MyPopup extends StatefulWidget {
  final String groupId;

  MyPopup({required this.groupId});

  @override
  _MyPopupState createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void createAppointment() {
    final String name = nameTextController.text;
    final String description = descriptionTextController.text;

    final DateTime dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final Meeting newMeeting = Meeting(name, dateTime, dateTime, Colors.blue, false);

    appointmentController.createAppointment(widget.groupId, newMeeting);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    descriptionTextController.dispose();
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: descriptionTextController,
                    decoration: const InputDecoration(labelText: 'Beschreibung'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Datum auswählen'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );

                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: const Text('Uhrzeit auswählen'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: createAppointment,
                  child: const Text('Termin erstellen'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}
