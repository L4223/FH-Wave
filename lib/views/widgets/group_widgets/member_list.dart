import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../controllers/group_controller.dart';

class MemberList extends StatelessWidget {
  final String groupId;
  final GroupController groupController = GroupController();

  MemberList({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 70,
          child: const Text(
            "Mitglieder",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minHeight: 300,
            maxHeight: 300,
          ),
          child: FutureBuilder<List<String>>(
            future: groupController.getMemberNames(groupId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.fhwaveNeutral200, // Farbe des Strichs
                    thickness: 1, // Dicke des Strichs
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var memberName = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        memberName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      onTap: () {
                        // print(memberName);
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
