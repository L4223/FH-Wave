import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserGroupIds(String userId) async {
    try {
      final userRef = firestore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        final groupIds = List<String>.from(userSnapshot.data()!['groups']);
        return groupIds;
      }
    } catch (e) {
      // print('Error getting user group ids: $e');
    }

    return [];
  }

  void requestAppointment(String groupId, String date) async {
    try {
      final groupRef = firestore.collection('groups').doc(groupId);
      final groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final memberIds = List<String>.from(groupSnapshot.data()!['members']);

        for (final memberId in memberIds) {
          final userRef = firestore.collection('users').doc(memberId);
          await userRef.update({
            'appointments': FieldValue.arrayUnion([date]),
          });
        }
      }
    } catch (e) {
      // print('Error requesting appointment: $e');
    }
  }

  Future<List<String>> getUserAppointments(String userId) async {
    try {
      final userRef = firestore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        final appointments =
            List<String>.from(userSnapshot.data()!['appointments']);
        return appointments;
      }
    } catch (e) {
      // print('Error getting user appointments: $e');
    }

    return [];
  }
}
