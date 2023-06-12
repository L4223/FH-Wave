import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../../../controllers/group_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../group_screens/group_screen.dart';

//Zeigt alle Gruppen eines Users an, in denen er Mitglied ist
class GroupList extends StatefulWidget {
  const GroupList({super.key});

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
        Container(
          alignment: Alignment.topLeft,
          height: 70,
          child: const Text(
            "Meine Gruppen",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minHeight: 300,
            maxHeight: 300,
          ),
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: _groupController.getUserGroups(currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Lade Gruppen...");
              } else if (snapshot.hasError) {
                return const Text('Fehler beim Laden der Gruppen');
              } else {
                var groups = snapshot.data!;

                if (groups.isEmpty) {
                  return const Text('Keine Gruppen vorhanden');
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.fhwaveNeutral200, // Farbe des Strichs
                    thickness: 1, // Dicke des Strichs
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    var groupDoc = groups[index];
                    // var isSelected = selectedGroup == groupDoc['groupId'];

                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              groupDoc['groupName'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        selectedGroup = groupDoc['groupId'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupInfoScreen(
                                    groupName: groupDoc["groupName"],
                                    groupId: groupDoc["groupId"],
                                    creatorId: groupDoc["creatorId"],
                                  )),
                        );
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

  Widget noGroupsFound() {
    return const Column(
      children: [
        Icon(Icons.group_off),
        Text("Keine Gruppen gefunden"),
        Text(
          "Erstelle zuerst eine Gruppe oder "
          "trete einer bestehenden Gruppe bei.",
          style: TextStyle(fontSize: 10, color: AppColors.fhwaveNeutral50),
        )
      ],
    );
  }
}
