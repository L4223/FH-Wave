import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../app_colors.dart';
import '../controllers/appointment_controller.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/user_controller.dart';
import 'widgets/group_widgets/appbar.dart';

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

  bool hasGroups = false;

  @override
  void initState() {
    super.initState();
    checkGroupRequestEmpty();
    fetchUserGroups();
  }

  void fetchUserGroups() async {
    var groupDocs = await groupController.getUserGroups(currentUser!.uid);

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
        final colorValue = data['color'] as int;
        final color = Color(colorValue);
        final isAllDay = data['isAllDay'] as bool;

        return Meeting(title, startTime, endTime, color, isAllDay);
      }).toList();

      setState(() {
        _meetings = meetings;
      });
    } catch (error) {
      //print("Fehler beim Abrufen der Termine: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AppColors.getFhwaveYellowGradientContainer(context),
        ListView(
          children: [
            TransparentAppbar(heading: "Termin", route: "/home"),
            Container(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SfCalendar(
                        todayHighlightColor: AppColors.black,
                        cellBorderColor: AppColors.transparent,
                        selectionDecoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black,
                            width: 1.0,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        view: CalendarView.month,
                        headerStyle: const CalendarHeaderStyle(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                            // fontFamily: 'Roboto-bold',
                          ),
                        ),
                        appointmentTextStyle: const TextStyle(
                          fontSize: 14,
                          // fontFamily: 'Roboto',
                        ),
                        dataSource: MeetingDataSource(_meetings),
                        monthViewSettings: const MonthViewSettings(
                          showAgenda: true,
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment,
                        ),
                      ),
                    ),
                  ),
                  groupActions()
                  // Text(currentUser!.uid),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }

  Future<void> checkGroupRequestEmpty() async {
    var status = await groupController.userHasGroups();
    setState(() {
      hasGroups = status;
    });
  }

  Widget groupActions() {
    if (hasGroups) {
      return Column(
        children: [
          GroupNameDropdown(groupNames: groupNames),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyPopup(groupId: groupId),
            ),
          ),
        ],
      );
    } else {
      return const Text("Bitte trete vorher einer Gruppe bei.");
    }
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

  static Meeting fromInputData(
      String name, String description, String date, String time) {
    final startTime = DateTime.parse('$date $time');
    final endTime = startTime.add(const Duration(hours: 1));
    const Color color = Colors.blue;

    return Meeting(name, startTime, endTime, color, false);
  }

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class GroupNameDropdown extends StatefulWidget {
  final List<String> groupNames;

  const GroupNameDropdown({Key? key, required this.groupNames})
      : super(key: key);

  @override
  State<GroupNameDropdown> createState() => _GroupNameDropdownState();
}

class _GroupNameDropdownState extends State<GroupNameDropdown> {
  String dropdownValue = '';
  String groupId = '';

  Future<void> getGroupId(String selectedGroupName) async {
    final selectedGroupId =
        await groupController.getGroupIdFromGroupName(selectedGroupName);
    setState(() {
      groupId = selectedGroupId;
    });
    if (!mounted) return;
    _fetchMeetings(groupId);
  }

  void _fetchMeetings(String groupId) {
    var screenState =
        context.findAncestorStateOfType<_GroupCalendarScreenState>()!;
    screenState._fetchMeetings(groupId);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groupNames.isEmpty) {
      return const Text('Keine Gruppennamen vorhanden');
    }

    if (!widget.groupNames.contains(dropdownValue)) {
      dropdownValue = widget.groupNames.first;
    }

    getGroupId(dropdownValue);

    return Column(
      children: [
        SizedBox(
          width: 200,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: AppColors.fhwaveYellow500),
            underline: Container(
              height: 2,
              color: AppColors.black,
            ),
            alignment: Alignment.center,
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
              getGroupId(value!);
            },
            items: widget.groupNames.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    value,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        //Text('Ausgewählter Name: $dropdownValue'),
        //Text('groupId:$groupId')
      ],
    );
  }
}

class MyPopup extends StatefulWidget {
  final String groupId;

  const MyPopup({super.key, required this.groupId});

  @override
  MyPopupState createState() => MyPopupState();
}

class MyPopupState extends State<MyPopup> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int duration = 1; // Standarddauer des Termins in Stunden

  void resetFields() {
    nameTextController.text = '';
    descriptionTextController.text = '';
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    duration = 1;
  }

  void createAppointment() {
    final name = nameTextController.text;

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    final endTime = dateTime.add(Duration(hours: duration));
    // Berechnen der Endzeit basierend auf der Dauer

    final newMeeting = Meeting(name, dateTime, endTime, Colors.blue, false);

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
      backgroundColor: AppColors.black,
      child: const Icon(Icons.add),
      onPressed: () {
        resetFields();
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
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
                        decoration:
                            const InputDecoration(labelText: 'Beschreibung'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Datum'),
                              Text(
                                DateFormat('dd.MM.yyyy').format(selectedDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: const Text('Ändern'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Uhrzeit'),
                              Text(
                                selectedTime.format(context),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );

                              if (pickedTime != null) {
                                setState(() {
                                  selectedTime = pickedTime;
                                });
                              }
                            },
                            child: const Text('Ändern'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Dauer (Stunden)'),
                              Text(
                                '$duration Stunde${duration != 1 ? 'n' : ''}',
                                // Anzeigen der ausgewählten Anzahl von Stunden
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Slider(
                              min: 1,
                              max: 8,
                              value: duration.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  duration = newValue.toInt();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Abbrechen'),
                    ),
                    ElevatedButton(
                      onPressed: createAppointment,
                      child: const Text('Erstellen'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
