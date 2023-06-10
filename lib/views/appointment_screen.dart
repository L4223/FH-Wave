import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/appointment_controller.dart';
import 'request_screen.dart';

class RequestAppointmentScreen extends StatefulWidget {
  const RequestAppointmentScreen({super.key});

  @override
  RequestAppointmentScreenState createState() =>
      RequestAppointmentScreenState();
}

class RequestAppointmentScreenState extends State<RequestAppointmentScreen> {
  late DateTime selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final AppointmentController _controller = AppointmentController();
  List<String> _appointments = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _dateController.text = selectedDate.toString();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final appointments = await _controller.getUserAppointments(user.uid);
      setState(() {
        _appointments = appointments;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.toString();
      });
    }
  }

  void _requestAppointment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final groupIds = await _controller.getUserGroupIds(user.uid);
      final date = selectedDate.toString();

      for (final groupId in groupIds) {
        _controller.requestAppointment(groupId, date);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termin anfragen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_post_office),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                labelText: 'Datum des Treffens',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _requestAppointment,
              child: const Text('anfragen'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _appointments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_appointments[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
