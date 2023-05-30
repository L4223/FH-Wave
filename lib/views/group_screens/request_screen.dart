import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/group_controller.dart';
import '../../controllers/user_controller.dart';

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
      appBar: AppBar(
        title: const Text('Einladungen'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            Navigator.pushNamed(context, "/group").then((_) => setState(() {}));
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
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

            return ListView.builder(
              itemCount: groupNames.length,
              itemBuilder: (context, index) {
                var groupName = groupNames[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(groupName)),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          _groupController
                              .acceptInvite(groupName, currentUser!.uid)
                              .then((value) => setState(() {}));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
