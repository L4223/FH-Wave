import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/group_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/group_widgets/appbar.dart';

final UserController _userController = UserController();
final GroupController _groupController = GroupController();
User? currentUser = _userController.currentUser;
String uid = currentUser!.uid;

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AppColors.getFhwaveBlueGradientContainer(context),
        ListView(
          children: [
            TransparentAppbar(
              heading: "Einladungen",
              route: "/group",
            ),
            SizedBox(
              height: 400,
              child: FutureBuilder<List<String>>(
                future: _groupController.getGroupNamesFromRequests(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Fehler beim Laden der Daten'),
                    );
                  } else {
                    var groupNames = snapshot.data!;

                    if (groupNames.isEmpty) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_post_office,
                            size: 50,
                          ),
                          Text(
                            "Du hast zurzeit keine Einladungen.",
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: groupNames.length,
                        itemBuilder: (context, index) {
                          var groupName = groupNames[index];
                          return ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                    child: Text("Einladung von $groupName")),
                                IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _groupController
                                        .deleteGroupRequest(
                                            currentUser!.uid, groupName)
                                        .then((value) => setState(() {}));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () {
                                    _groupController
                                        .acceptInvite(
                                            groupName, currentUser!.uid)
                                        .then((value) => setState(() {}));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}
