import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestAppointmentController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> acceptAppointmentRequest
      (String groupId, String requestId) async {
    try {
      // Firestore-Referenz für das Gruppenmitglied
      DocumentReference memberRef = FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .collection('members')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      // Anfrage aus der appointment_requests-Liste entfernen
      await memberRef.update({
        'appointment_requests': FieldValue.arrayRemove([requestId]),
      });

      // Anfrage zur appointments-Liste hinzufügen
      await memberRef.update({
        'appointments': FieldValue.arrayUnion([requestId]),
      });
    } catch (e) {
      // print('Fehler beim Bestätigen der Terminanfrage: $e');
    }
  }

  Future<void> declineAppointmentRequest
      (String groupId, String requestId) async {
    try {
      // Firestore-Referenz für das Gruppenmitglied
      DocumentReference memberRef = FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .collection('members')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      // Anfrage aus der appointment_requests-Liste entfernen
      await memberRef.update({
        'appointment_requests': FieldValue.arrayRemove([requestId]),
      });
    } catch (e) {
      // print('Fehler beim Ablehnen der Terminanfrage: $e');
    }
  }

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