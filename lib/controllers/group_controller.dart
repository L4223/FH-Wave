import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GroupController {
  Future<void> createGroup(String groupName, String creatorId) async {
    try {
      //Gruppe erstellen
      final groupRef = firestore.collection('groups').doc();
      final groupId = groupRef.id;
      await groupRef.set({
        'groupId': groupId,
        'groupName': groupName,
        'creatorId': creatorId,
        'members': FieldValue.arrayUnion([creatorId]),
      });

      //Gruppe zu Creator hinzufügen
      final userRef = firestore.collection('users').doc(creatorId);
      await userRef.update({
        'groups': FieldValue.arrayUnion([groupId]),
      });

      //Creator zu Gruppe hinzufügen
      addMemberToGroup(groupId, creatorId);
    } catch (e) {
      // print('Fehler beim Erstellen der Gruppe: $e');
    }
  }

  Future<void> addGroupRequest(String groupId, String userName) async {
    try {
      var uid = await getUserIdFromUsername(userName);

      final userRef = firestore.collection('users').doc(uid);
      await userRef.update({
        'group_requests': FieldValue.arrayUnion([groupId]),
      });
    } catch (e) {
      // print('Fehler beim Hinzufügen eines Members: $e');
    }
  }

  Future<void> addMemberToGroup(String groupId, String uid) async {
    try {
      //Group bekommt Uid hinzugefügt
      final groupRef = firestore.collection('groups').doc(groupId);
      await groupRef.update({
        'members': FieldValue.arrayUnion([uid]),
      });

      //User bekommt GroupId hinzugefügt
      final userRef = firestore.collection('users').doc(uid);
      await userRef.update({
        'groups': FieldValue.arrayUnion([groupId]),
      });
    } catch (e) {
      // print('Fehler beim Hinzufügen eines Members: $e');
    }
  }

  Future<void> acceptInvite(String groupName, String uid) async {
    var groupId = await getGroupIdFromGroupName(groupName);

    //GroupId aus Requests löschen
    final userRef = firestore.collection('users').doc(uid);
    await userRef.update({
      'group_requests': FieldValue.arrayRemove([groupId]),
    });

    addMemberToGroup(groupId, uid);
  }

  //Noch nicht benutzt (coming soon)
  Future<List<String>> getMemberNames(String groupId) async {
    DocumentReference groupRef =
        FirebaseFirestore.instance.collection('groups').doc(groupId);

    //Alle Daten aus Gruppe speichern
    var groupSnapshot = await groupRef.get();
    //Daten aus Gruppe/Members speichern
    List<dynamic>? memberIDs =
        (groupSnapshot.data() as Map<String, dynamic>)['members'];

    // UserNames suchen & speichern
    var memberNames = <String>[];
    if (memberIDs != null) {
      for (var memberID in memberIDs) {
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(memberID);

        var userSnapshot = await userRef.get();
        //Gefundene Daten in Liste speichern
        String? userName =
            (userSnapshot.data() as Map<String, dynamic>)['name'];
        if (userName != null) {
          memberNames.add(userName);
        }
      }
    }
    return memberNames;
  }

  Future<List<String>> getGroupNamesFromRequests(String uid) async {
    var groupNames = <String>[];

    try {
      // Firestore-Referenz für den Benutzer
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Benutzerdaten auslesen
      var userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        List<dynamic> groupRequests = userSnapshot.get('group_requests') ?? [];

        // Firestore-Referenz für die Gruppen
        CollectionReference groupsRef =
            FirebaseFirestore.instance.collection('groups');

        // Gruppennamen abrufen
        var groupsSnapshot = await groupsRef.get();
        var groupDocs = groupsSnapshot.docs;

        // Gruppennamen mit den vorhandenen group_requests vergleichen
        for (String groupId in groupRequests) {
          QueryDocumentSnapshot? groupDoc =
              groupDocs.firstWhere((doc) => doc.id == groupId);
          String groupName = groupDoc.get('groupName');
          groupNames.add(groupName);
        }
      }
    } catch (e) {
      // print('Fehler beim Abrufen der Gruppennamen: $e');
    }

    return groupNames;
  }

  Future<List<DocumentSnapshot>> getUserGroups(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .where('members', arrayContains: uid)
        .get();
    List<DocumentSnapshot> groupDocs = querySnapshot.docs;
    return groupDocs;
  }

  Future<String> getUserIdFromUsername(String userName) async {
    try {
      // Benutzerdokument abrufen, das den angegebenen Benutzernamen enthält
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('userName', isEqualTo: userName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Das erste gefundene Benutzerdokument zurückgeben
        final DocumentSnapshot userDoc = querySnapshot.docs[0];
        return userDoc.id;
      } else {
        // print(
        //'Benutzer mit dem angegebenen Benutzernamen wurde nicht gefunden');
        return "Nothing found";
      }
    } catch (error) {
      // print('Fehler beim Abrufen der Benutzerdaten: $error');
      return "Nothing found";
    }
  }

  Future<String> getGroupIdFromGroupName(String groupName) async {
    try {
      // Benutzerdokument abrufen, das den angegebenen Benutzernamen enthält
      final QuerySnapshot querySnapshot = await firestore
          .collection('groups')
          .where('groupName', isEqualTo: groupName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Das erste gefundene Benutzerdokument zurückgeben
        final DocumentSnapshot groupDoc = querySnapshot.docs[0];
        return groupDoc.id;
      } else {
        // print(
        //'Benutzer mit dem angegebenen Benutzernamen wurde nicht gefunden');
        return "Nothing found";
      }
    } catch (error) {
      // print('Fehler beim Abrufen der Benutzerdaten: $error');
      return "Nothing found";
    }
  }
}
