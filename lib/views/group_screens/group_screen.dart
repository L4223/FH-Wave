import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/group_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/primary_button_with_icon.dart';
import '../widgets/buttons/secondary_button.dart';
import '../widgets/group_widgets/appbar.dart';
import '../widgets/group_widgets/group_list.dart';
import '../widgets/group_widgets/member_list.dart';
import '../widgets/group_widgets/popups.dart';

String selectedGroup = "";

final GroupController _groupController = GroupController();
final UserController _userController = UserController();
User? currentUser = _userController.currentUser;

class GroupsHome extends StatefulWidget {
  const GroupsHome({Key? key}) : super(key: key);

  @override
  State<GroupsHome> createState() => _GroupsHomeState();
}

class _GroupsHomeState extends State<GroupsHome> {
  bool _isRequestsEmpty = true;

  @override
  void initState() {
    checkGroupRequestEmpty();
    super.initState();
  }

  Future<void> checkGroupRequestEmpty() async {
    var isEmpty = await _groupController.isGroupRequestEmpty(currentUser!.uid);
    setState(() {
      _isRequestsEmpty = isEmpty;
    });
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AppColors.getFhwavePurpleGradientContainer(context),
        ListView(
          children: [
            TransparentAppbar(
              heading: "Gruppen",
              func: () => Navigator.pushNamed(context, "/home"),
            ),
            Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/request");
                        },
                        icon: _isRequestsEmpty
                            ? const Icon(Icons.local_post_office)
                            : const Icon(
                                Icons.local_post_office,
                                color: Colors.deepOrange,
                              )),
                    const SizedBox(
                      width: 28,
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  const GroupList(),
                  const SizedBox(
                    height: 100,
                  ),
                  PrimaryButtonWithIcon(
                      icon: Icons.group_add_rounded,
                      text: "Gruppe erstellen",
                      onTap: () => createGroupPopup(context))
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

//ignore: must_be_immutable
class GroupInfoScreen extends StatelessWidget {
  GroupInfoScreen(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.creatorId});

  String groupName;
  String groupId;
  String creatorId;

  final memberNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      AppColors.getFhwavePurpleGradientContainer(context),
      ListView(
        children: [
          Column(
            children: [
              TransparentAppbar(
                heading: groupName,
                func: () => Navigator.pushNamed(context, "/group"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    MemberList(
                      groupId: groupId,
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    groupButtons(context)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ]));
  }

  Widget groupButtons(BuildContext context) {
    //Wenn Nnutzer der Ersteller der Gruppe ist
    if (currentUser!.uid == creatorId) {
      return Column(children: [
        PrimaryButton(
            text: "Mitglied hinzufügen",
            onTap: () {
              addMemberPopup(context, groupId);
            }),
        const SizedBox(
          height: 10,
        ),
        SecondaryButton(
            text: "Gruppe auflösen",
            onTap: () {
              confirmPopup(
                  context,
                  Icons.warning_amber,
                  "Willst du die Gruppe wirklich auflösen?",
                  "Diese Aktion kann nicht Rückgängig gemacht werden.", () {
                _groupController.deleteGroup(groupId);
              });
            }),
      ]);
      //Wenn Nnutzer nicht der Ersteller der Gruppe ist
    } else {
      return PrimaryButton(
          text: "Gruppe verlassen",
          onTap: () {
            confirmPopup(
                context,
                Icons.warning_amber,
                "Willst du die Gruppe $groupName wirklich verlassen?",
                "Du kannst diese Aktion nicht rückgängig machen.", () {
              _groupController.leaveGroup(groupId, "currentUser");
            });
          });
    }
  }
}
