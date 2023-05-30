import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../controllers/group_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../group_screens/group_screen.dart';

class GroupList extends StatefulWidget {
  final String selectedGroup;
  final ValueChanged<String> onGroupSelected;

  const GroupList(
      {super.key, required this.selectedGroup, required this.onGroupSelected});

  @override
  GroupListState createState() => GroupListState();
}

class GroupListState extends State<GroupList> {
  final GroupController _groupController = GroupController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    var currentUser = _userController.currentUser;

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Deine Gruppen"),
        Container(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 300,
          ),
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: _groupController.getUserGroups(currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("...");
              } else if (snapshot.hasError) {
                return const Text('Fehler beim Laden der Gruppen');
              } else {
                var groups = snapshot.data!;

                if (groups.isEmpty) {
                  return const Text('Keine Gruppen vorhanden');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    var groupDoc = groups[index];
                    var isSelected = selectedGroup == groupDoc['groupId'];

                    return ListTile(
                      title: Text(
                        groupDoc['groupName'],
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedGroup = groupDoc['groupId'];
                        });
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
