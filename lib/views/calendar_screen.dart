import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendar_controller.dart';
import 'appointment_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();

  void setSelectedDays(List<DateTime> selectedDays) {
    // Diese Methode bleibt leer, da sie im State gesetzt wird
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  final MyCalendarController _calendarController = MyCalendarController();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    widget.setSelectedDays(_selectedDays);
    // Übergabe der initialen ausgewählten Tage an die übergeordnete Klasse
  }

  void setSelectedDays(List<DateTime> selectedDays) {
    setState(() {
      _selectedDays = selectedDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender'),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            selectedDayPredicate: (day) {
              return _selectedDays
                  .any((selectedDay) => isSameDay(selectedDay, day));
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (_selectedDays.contains(selectedDay)) {
                  _selectedDays
                      .remove(selectedDay); // Tag aus der Liste entfernen
                } else {
                  _selectedDays.add(selectedDay); // Tag zur Liste hinzufügen
                }

                _calendarController.saveSelectedDays(_selectedDays);
                _focusedDay = focusedDay; // Fokussierten Tag aktualisieren
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestAppointmentScreen()),
              );
            },
            child: const Text('Termin anfragen'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedDays.length,
              itemBuilder: (context, index) {
                final selectedDay = _selectedDays[index];
                return ListTile(
                  title: Text(selectedDay.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
