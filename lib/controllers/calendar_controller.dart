import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_controller.dart';

class CalendarController {
  Future<void> saveSelectedDays(List<DateTime> selectedDays) async {
    try {
      final userController = UserController();
      final currentUser = userController.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        await userRef.set({
          'availability': selectedDays.map((date) =>
              date.toIso8601String()).toList(),
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
            return selectedDaysStrings.map
              (DateTime.parse).toList();
          }
        }
      }
      return [];
    } catch (e) {
      // print('Fehler beim Abrufen der ausgewählten Tage: $e');
      return [];
    }
  }
}
