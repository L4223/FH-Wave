import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/group_controller.dart';
import '../controllers/user_controller.dart';
import '../views/widgets/group_widgets/group_buttons.dart';
import 'request_screen.dart';
import 'widgets/group_widgets/group_list.dart';

List<String> dropdownItems = [
  'Semester Gruppe',
  'Arbeits Gruppe',
  'Nachhilfe Gruppe',
  'Modul Gruppe',
]; // Liste der Dropdown-Elemente

String selectedGroup = "";

final GroupController _groupController = GroupController();
final UserController _userController = UserController();
User? currentUser = _userController.currentUser;

class GroupCreationScreen extends StatefulWidget {
  const GroupCreationScreen({
    super.key,
  });

  @override
  GroupCreationScreenState createState() => GroupCreationScreenState();
}

class GroupCreationScreenState extends State<GroupCreationScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _memberNameController = TextEditingController();

  void createGroup() {
    setState(() {
      var groupName = _groupNameController.text.trim();
      var creatorId = currentUser?.uid;
      _groupController.createGroup(groupName, creatorId!);
    });
  }

  void addMember(String uid) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text('Gruppe erstellen'),
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
          child: ListView(
            children: [
              TextField(
                controller: _groupNameController,
                decoration: const InputDecoration(
                  labelText: 'Gruppenname',
                ),
              ),
              const SizedBox(height: 16.0),
              funcButton(
                  context, "Gruppe erstellen", Icons.groups, createGroup),
              TextField(
                controller: _memberNameController,
                decoration: const InputDecoration(
                  labelText: 'Nutzername',
                ),
              ),
              funcButton(
                  context,
                  "Member hinzufügen",
                  Icons.group_add,
                  () => _groupController.addGroupRequest(
                      selectedGroup, _memberNameController.text)),
              GroupList(
                  selectedGroup: selectedGroup,
                  onGroupSelected: handleGroupSelected)
            ],
          ),
        ));
  }

  void handleGroupSelected(String group) {
    setState(() {
      selectedGroup = group;
    });
  }
}
