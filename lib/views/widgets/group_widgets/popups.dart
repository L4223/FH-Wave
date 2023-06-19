import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../controllers/group_controller.dart';
import '../../group_screens/group_screen.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

final GroupController _groupController = GroupController();
final groupNameTextController = TextEditingController();
final memberTextController = TextEditingController();

String groupName = "";

Widget groupNameInputField() {
  return TextFormField(
    controller: groupNameTextController,
    cursorColor: AppColors.fhwavePurple500,
    maxLength: 20,
    decoration: const InputDecoration(
      labelText: "Name",
      labelStyle: TextStyle(
        color: AppColors.fhwaveNeutral400,
      ),
      // helperText: 'Helper text',
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.fhwavePurple500),
      ),
    ),
  );
}

Widget memberInputField() {
  return Column(
    children: [
      TextFormField(
        cursorColor: AppColors.fhwavePurple500,
        controller: memberTextController,
        decoration: const InputDecoration(
          labelText: "Mitglieder",
          labelStyle: TextStyle(
            color: AppColors.fhwaveNeutral400,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.fhwavePurple500),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Trenne die Namen mit einem ' , ' ",
        style: TextStyle(color: AppColors.fhwaveNeutral200),
        textAlign: TextAlign.center,
      ),
      const Text(
        "Beispiel: Max, Anna, Peter",
        style: TextStyle(color: AppColors.fhwaveNeutral200),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 50,
      ),
    ],
  );
}

//Gruppe erstellen, Tastatur schließen, Feedback
Future<void> createGroup(BuildContext context) async {
  var groupName = groupNameTextController.text.trim();
  var memberNames = memberTextController.text.trim().split(", ");
  var creatorId = currentUser?.uid;

  _groupController.createGroup(groupName, creatorId!).then((groupId) {
    _groupController.addGroupRequestList(memberNames, groupId);
    Navigator.of(context).pop();
    _groupController.closeKeyboard(context);

    feedbackPopup(context, Icons.check, "Gruppe erfolgreich erstellt!",
        "Aktuallisiere die Seite falls deine Gruppe nicht sichtbar ist.", () {
      // Navigator.pop(context);
      // Navigator.of(context, rootNavigator: true).pop();
    }
        //     {
        //
        //   // Navigator.pushNamed(context, "/home");
        //   // Navigator.pushReplacement(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //         builder: (context) => GroupInfoScreen(
        //   //             groupName: groupName,
        //   //             groupId: groupId,
        //   //             creatorId: creatorId)));
        // }
        );
  });
}

void createGroupPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Center(child: Text('Gruppe erstellen')),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView(
            children: [
              groupNameInputField(),
              memberInputField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecondaryButton(
                    text: "Abbrechen",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    width: 130,
                  ),
                  PrimaryButton(
                    text: "Erstellen",
                    onTap: () {
                      createGroup(context);
                    },
                    width: 130,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    memberTextController.clear();
    groupNameTextController.clear();
  });
}

void addMemberPopup(BuildContext context, String groupId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Center(child: Text('Mitglieder hinzufügen')),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView(
            children: [
              memberInputField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecondaryButton(
                    text: "Abbrechen",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    width: 130,
                  ),
                  // SizedBox(width: 10,),
                  PrimaryButton(
                    text: "Hinzufügen",
                    onTap: () async {
                      var names = memberTextController.text.split(", ");

                      var checkMembers =
                          await _groupController.checkMembersExist(names);

                      var checkIsAlreadyMember = await _groupController
                          .checkUserIsMemberOrHasRequest(names, groupId);

                      var duplicate =
                          _groupController.checkDuplicateName(names);

                      if (duplicate == "" &&
                          checkMembers == "" &&
                          checkIsAlreadyMember == "") {
                        _groupController.addGroupRequestList(names, groupId);
                        Navigator.of(context).pop();
                        feedbackPopup(
                            context,
                            Icons.check,
                            "Mitglied/er erfolgreich hinzugefügt, diese",
                            "Nutzer bekommen jetzt eine Beitritts-Anfrage.",
                            () {});
                      } else if (checkMembers != "") {
                        feedbackPopup(
                            context,
                            Icons.warning_amber,
                            "Fehler beim Hinzufügen der Mitglieder",
                            "Der Nutzer $checkMembers existiert nicht",
                            () => Navigator.pop(context));
                      } else if (checkIsAlreadyMember != "") {
                        feedbackPopup(
                            context,
                            Icons.warning_amber,
                            "Fehler beim Hinzufügen der Mitglieder",
                            "Der Nutzer $checkIsAlreadyMember ist bereits Mitglied oder hat schon eine Anfrage",
                            () => Navigator.pop(context));
                      } else {
                        feedbackPopup(
                            context,
                            Icons.warning_amber,
                            "Fehler beim Hinzufügen der Mitglieder",
                            "Der Name $duplicate ist doppelt",
                            () => Navigator.pop(context));
                      }
                      ;
                    },
                    width: 130,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    memberTextController.clear();
  });
}

void feedbackPopup(BuildContext context, IconData icon, String heading,
    String text, Function() func) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 50,
                        ),
                        Text(
                          heading,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.fhwaveNeutral200),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                            text: "Weiter",
                            onTap: () {
                              Navigator.pop(context);
                              func();
                            }),
                      ],
                    ),
                  ],
                )),
          ));
}

void confirmPopup(BuildContext context, IconData icon, String heading,
    String text, VoidCallback func) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 50,
                        ),
                        Text(
                          heading,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(text,
                            style: const TextStyle(
                                color: AppColors.fhwaveNeutral200),
                            textAlign: TextAlign.center),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SecondaryButton(
                              text: "Abbrechen",
                              onTap: () => Navigator.pop(context),
                              width: 130,
                            ),
                            PrimaryButton(
                              text: "Bestätigen",
                              onTap: () {
                                func();
                                // Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GroupsHome()));
                              },
                              width: 130,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ));
}

class BlurredDialog extends StatelessWidget {
  const BlurredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: SizedBox(
          width: 600.0,
          height: 350.0,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(
                "assets/fhwave-loading-standard.gif",
                gaplessPlayback: true,
                width: 80.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Center(
                child: Text("Ein Semesterprojekt\n    von AEM Team 9",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.fhwaveNeutral900)),
              ),
              const SizedBox(
                height: 50.0,
              ),
              PrimaryButton(
                text: 'Alles klar',
                width: 140,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text("Version 1.0.0 - fhwave",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fhwaveNeutral400)),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }
}
