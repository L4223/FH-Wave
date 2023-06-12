import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../controllers/dark_mode_controller.dart';
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

void closeKeyboard(BuildContext context) {
  var currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

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
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Scaffold(
        body: Stack(children: [
          controller.isDarkMode
              ? AppColors.getFhwavePurpleGradientContainer(context)
              : AppColors.getFhwaveBlueGradientContainer(context),
          ListView(
            children: [
              TransparentAppbar(
                heading: "Gruppen",
                route: "/",
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/request");
                      },
                      icon: _isRequestsEmpty
                          ? const Icon(Icons.local_post_office)
                          : const Icon(
                              Icons.local_post_office,
                              color: Colors.deepOrange,
                            ))),
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
                        onTap: () {
                          createGroupPopup(context);
                        }),
                  ],
                ),
              )
            ],
          ),
        ]),
      );
    });
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

  void deleteGroup() {
    _groupController.deleteGroup(groupId);
    // .then((value) =>
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const GroupsHome())));
  }

  void leaveGroup() {
    _groupController.leaveGroup(groupId, currentUser!.uid);
    // .then((value) => Navigator.pop(context));
  }

  final memberNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Scaffold(
          body: Stack(children: [
        controller.isDarkMode
            ? AppColors.getFhwavePurpleGradientContainer(context)
            : AppColors.getFhwaveBlueGradientContainer(context),
        ListView(
          children: [
            Column(
              children: [
                TransparentAppbar(
                  heading: groupName,
                  route: "/group",
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
                      actionButtons(context)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ]));
    });
  }

  Widget actionButtons(BuildContext context) {
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
                  "Diese Aktion kann nicht Rückgängig gemacht werden.",
                  deleteGroup);
            }),
      ]);
    } else {
      return PrimaryButton(
          text: "Gruppe verlassen",
          onTap: () {
            confirmPopup(
                context,
                Icons.warning_amber,
                "Willst du die Gruppe $groupName wirklich verlassen?",
                "Du kannst diese Aktion nicht rückgängig machen.",
                leaveGroup);
          });
    }
  }
}
