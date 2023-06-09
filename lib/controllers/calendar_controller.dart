import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_controller.dart';

class MyCalendarController {
  Future<void> saveSelectedDays(List<DateTime> selectedDays) async {
    try {
      final userController = UserController();
      final currentUser = userController.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        await userRef.set({
          'availability':
          selectedDays.map((date) => date.toIso8601String()).toList(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      // print('Fehler beim Speichern der ausgewählten Tage: $e');
    }
  }

  Future<List<DateTime>> getSelectedDays() async {
    try {
      final userController = UserController();
      final currentUser = userController.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        final doc = await userRef.get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('availability')) {
            final selectedDaysStrings = List<String>.from(data['availability']);
            return selectedDaysStrings.map(DateTime.parse).toList();
          }
        }
      }
      return [];
    } catch (e) {
      // print('Fehler beim Abrufen der ausgewählten Tage: $e');
      return [];
    }
  }

  Future<void> craeteNewAppointment(String groupId, String name, String desc,
      DateTime dateTime) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      //Appointment in Gruppe erstellen
      final groupRef = firestore.collection('groups').doc(groupId);
      final appointRef = groupRef.collection('appointments').doc();
      await appointRef.set({
        'name': name,
        'desc': desc,
        'dateTime': dateTime,
      });
    } catch (e) {
      print(e);
    }
  }

  List<DateTime> findCommonTime(List<List<DateTime>> timeRanges) {
    // Überprüfen, ob mindestens zwei Zeitbereiche vorhanden sind
    if (timeRanges.length < 2) {
      throw ArgumentError(
          'Es müssen mindestens zwei Zeitbereiche angegeben werden.');
    }

    // Sortieren der Zeitbereiche nach dem Startzeitpunkt
    timeRanges.sort((a, b) => a[0].compareTo(b[0]));

    // Den Startzeitpunkt des ersten Zeitbereichs als Basis verwenden
    List<DateTime> commonTimes = List.from(timeRanges[0]);

    // Iterieren über die restlichen Zeitbereiche
    for (int i = 1; i < timeRanges.length; i++) {
      List<DateTime> currentRange = timeRanges[i];

      // Überprüfen, ob sich die aktuellen Zeitbereiche überschneiden
      if (commonTimes[1].isBefore(currentRange[0]) ||
          commonTimes[0].isAfter(currentRange[1])) {
        // Wenn keine Überschneidung besteht, gibt es keine gemeinsame Zeit
        return [];
      }

      // Aktualisieren des Startzeitpunkts des gemeinsamen Zeitbereichs
      commonTimes[0] = commonTimes[0].isBefore(currentRange[0])
          ? currentRange[0]
          : commonTimes[0];

      // Aktualisieren des Endzeitpunkts des gemeinsamen Zeitbereichs
      commonTimes[1] = commonTimes[1].isAfter(currentRange[1])
          ? currentRange[1]
          : commonTimes[1];
    }

    // Aufteilen des gemeinsamen Zeitbereichs in 3 gleich große Intervalle
    Duration interval = commonTimes[1].difference(commonTimes[0]);
    Duration step = interval ~/ 4;
    List<DateTime> result = [];

    // Generieren der 3 besten Zeitpunkte
    for (int i = 1; i <= 3; i++) {
      DateTime time = commonTimes[0].add(step * i);
      result.add(time);
    }

    return result;
  }

//TODO: Auswahl in DB Speichern und alle Auswahlen für Vergleich importieren

// void main() {
//   List<List<DateTime>> timeRanges = [
//     [DateTime(2023, 6, 8, 9, 0), DateTime(2023, 6, 8, 11, 0)],
//     [DateTime(2023, 6, 8, 10, 0), DateTime(2023, 6, 8, 13, 0)],
//     [DateTime(2023, 6, 8, 12, 0), DateTime(2023, 6, 8, 14, 0)]
//   ];
//
//   List<DateTime> commonTimes = findCommonTime(timeRanges);
//   if (commonTimes.isNotEmpty) {
//     print('Die besten Zeitpunkte sind:');
//     for (DateTime time in commonTimes) {
//       print(time);
//     }
//   } else {
//     print('Kein gemeinsamer Zeitbereich gefunden.');
//   }
// }
}
