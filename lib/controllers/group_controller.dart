import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../views/group_calendar_screen.dart';

import 'user_controller.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class GroupController {
  Future<String> createGroup(String groupName, String creatorId) async {
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
      addMemberToGroup(groupId, creatorId).then((value) => {});
      return groupId;
      //
    } catch (e) {
      return "Error";
    }
  }

  void popupFeedback(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

  void addGroupRequestList(List<String> nameList, String groupId) {
    for (var userName in nameList) {
      addGroupRequest(groupId, userName);
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
    DocumentReference groupRef = firestore.collection('groups').doc(groupId);

    //Alle Daten aus Gruppe speichern
    var groupSnapshot = await groupRef.get();
    //Daten aus Gruppe/Members speichern
    List<dynamic>? memberIDs =
        (groupSnapshot.data() as Map<String, dynamic>)['members'];

    // UserNames suchen & speichern
    var memberNames = <String>[];
    if (memberIDs != null) {
      for (var memberID in memberIDs) {
        DocumentReference userRef = firestore.collection('users').doc(memberID);

        var userSnapshot = await userRef.get();
        //Gefundene Daten in Liste speichern
        String? userName =
            (userSnapshot.data() as Map<String, dynamic>)['userName'];
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
      DocumentReference userRef = firestore.collection('users').doc(uid);

      // Benutzerdaten auslesen
      var userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        List<dynamic> groupRequests = userSnapshot.get('group_requests') ?? [];

        // Firestore-Referenz für die Gruppen
        CollectionReference groupsRef = firestore.collection('groups');

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

  //Gibt alle Gruppendokumente in denen ein User Mitglied ist zurück
  Future<List<DocumentSnapshot>> getUserGroups(String uid) async {
    QuerySnapshot querySnapshot = await firestore
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

  Future<String?> getGroupCreator(String groupId) async {
    DocumentReference groupRef = firestore.collection('groups').doc(groupId);

    var groupSnapshot = await groupRef.get();
    var data = groupSnapshot.data() as Map<String, dynamic>?;

    var creatorId = data?['creatorId'];

    return creatorId?.toString();
  }

  void snackbarPopup(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> leaveGroup(String groupId, String name) async {
    var uid = "";

    //Gruppe verlassen
    if (name == "currentUser") {
      uid = currentUser!.uid;
      //Member aus Gruppe entfernen
    } else {
      await getUserIdFromUsername(name).then((id) => uid = id);
    }

    // Firestore-Instanz initialisieren
    try {
      // Gruppendokument in der Firestore-Sammlung "groups" abrufen
      DocumentSnapshot groupSnapshot =
          await firestore.collection('groups').doc(groupId).get();

      // Überprüfen, ob das Gruppendokument existiert
      if (groupSnapshot.exists) {
        // Gruppendaten abrufen
        var groupData = groupSnapshot.data() as Map<String, dynamic>;

        // Gruppenmitgliederliste abrufen
        var members = List<String>.from(groupData['members']);

        // UID aus der Gruppenmitgliederliste entfernen
        members.remove(uid);

        // Aktualisierte Gruppendaten speichern
        await firestore
            .collection('groups')
            .doc(groupId)
            .update({'members': members});
      }

      // Benutzerdokument in der Firestore-Sammlung "users" abrufen
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();

      // Überprüfen, ob das Benutzerdokument existiert
      if (userSnapshot.exists) {
        // Benutzerdaten abrufen
        var userData = userSnapshot.data() as Map<String, dynamic>;

        // Gruppenliste des Benutzers abrufen
        var groups = List<String>.from(userData['groups']);

        // GroupID aus der Gruppenliste entfernen
        groups.remove(groupId);

        // Aktualisierte Benutzerdaten speichern
        await firestore.collection('users').doc(uid).update({'groups': groups});
      }
    } catch (e) {
      // Fehlerbehandlung
      // print(
      //     'Fehler beim Entfernen der UID aus der Gruppe und der GroupID aus
      //     dem Benutzer: $e');
    }
  }

  //Funktion zum löschen einer Gruppe und allen Verbindungen dieser GroupID
  Future<void> deleteGroup(String groupId) async {
    try {
      // Delete the group document
      await firestore.collection('groups').doc(groupId).delete();

      // Get user documents
      QuerySnapshot userSnapshot = await firestore
          .collection('users')
          .where('groups', arrayContains: groupId)
          .get();

      // Remove the GroupID from each user document
      for (DocumentSnapshot doc in userSnapshot.docs) {
        var uid = doc.id;

        // Check if the user document exists and the groups field is not null
        if (doc.exists && doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>?;

          var groups = (data?['groups'] ?? []) as List<dynamic>?;

          // Remove the GroupID from the groups list if it's not null
          if (groups != null) {
            var updatedGroups = List<dynamic>.from(groups);
            updatedGroups.remove(groupId);

            // Save the updated user data
            await firestore
                .collection('users')
                .doc(uid)
                .update({'groups': updatedGroups});
          }
        }
      }
    } catch (e) {
      // Error handling
      // print(
      //     'Error deleting the group and removing the
      //     GroupID from user data: $e');
    }
  }

  Future<void> deleteGroupRequest(String uid, String groupName) async {
    try {
      // Document-Referenz für den Benutzer erstellen
      DocumentReference userRef = firestore.collection('users').doc(uid);

      var groupId = await getGroupIdFromGroupName(groupName);

      // Update ausführen, um die Gruppenanfrage zu entfernen
      await userRef.update({
        'group_requests': FieldValue.arrayRemove([groupId])
      });
    } catch (e) {
      // Fehlerbehandlung
      // print('Fehler beim Löschen der Gruppenanfrage: $e');
    }
  }

  Future<bool> isGroupRequestEmpty(String uid) async {
    try {
      // Document-Referenz für den Benutzer erstellen
      DocumentReference userRef = firestore.collection('users').doc(uid);

      // Benutzer-Dokument abrufen
      var userSnapshot = await userRef.get();

      // Überprüfen, ob der Benutzer existiert und das group_requests-Array hat
      if (userSnapshot.exists && userSnapshot.data() is Map<String, dynamic>) {
        var userData = userSnapshot.data() as Map<String, dynamic>;

        // Überprüfen, ob der group_requests-Array leer ist
        if (userData.containsKey('group_requests')) {
          var groupRequests = userData['group_requests'] as List<dynamic>?;
          return groupRequests?.isEmpty ?? true;
        }
      }
    } catch (e) {
      // Fehlerbehandlung
      // print('Fehler beim Überprüfen des Gruppenantrags: $e');
    }

    return true; // Annahme: Wenn der Benutzer oder das group_requests-Array
    // nicht vorhanden ist, wird es als leer betrachtet
  }

  String checkDuplicateName(List<String> names) {
    var uniqueNames = <String>{};
    var duplicateNames = <String>{};

    for (var name in names) {
      if (!uniqueNames.add(name)) {
        duplicateNames.add(name);
      }
    }

    if (duplicateNames.isEmpty) {
      return "";
    } else {
      return duplicateNames.first;
    }
  }

  void closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<String> checkMembersExist(List<String> addedMembers) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    var name = "";

    for (var member in addedMembers) {
      var snapshot =
          await usersCollection.where('userName', isEqualTo: member).get();

      if (snapshot.docs.isEmpty) {
        name = member;
        break;
      }
    }

    return name;
  }

  Future<String> checkUserIsMemberOrHasRequest(
      List<String> userNames, String groupId) async {
    for (var userName in userNames) {
      var uid = await getUserIdFromUsername(userName);

      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        final List<dynamic> groupRequests = userSnapshot.get('group_requests');
        if (groupRequests.contains(groupId)) {
          return userName;
        }

        final List<dynamic> groups = userSnapshot.get('groups');
        if (groups.contains(groupId)) {
          return userName;
        }
      }
    }

    return "";
  Future<bool> userHasGroups() async {
    var userController = UserController();
    var groupController = GroupController();
    var currentUser = userController.currentUser;

    var status = await groupController.getUserGroups(currentUser!.uid);

    if (status.isEmpty) {
      return false;
    }
    return true;
  }
}
