import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_colors.dart';
import '../../../controllers/dark_mode_controller.dart';
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
  var creatorId = currentUser?.uid;

  _groupController.createGroup(groupName, creatorId!).then((groupId) {
    Navigator.of(context).pop();
    _groupController.closeKeyboard(context);
    feedbackPopup(
        context,
        Icons.check,
        "Gruppe erfolgreich erstellt!",
        "Aktuallisiere die Seite falls deine Gruppe nicht sichtbar ist.",
        () {});

    addMemberPopup(context, groupId);
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
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView(
            children: [
              groupNameInputField(),
              // memberInputField(),
              const Text(
                "Nachdem du die Gruppe erstellt hast, "
                "kannst du Mitglieder hinzufügen",
                style: TextStyle(color: AppColors.fhwaveNeutral200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
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
  final dialogKey = GlobalKey<State>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        key: dialogKey,
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
                  PrimaryButton(
                    text: "Hinzufügen",
                    onTap: () async {
                      var names = memberTextController.text.split(", ");

                      var checkMembers =
                          await _groupController.checkMembersExist(names);

                      var checkIsAlreadyMember = "";
                      checkIsAlreadyMember = await _groupController
                          .checkUserIsMemberOrHasRequest(names, groupId);

                      var duplicate =
                          _groupController.checkDuplicateName(names);

                      if (duplicate == "" &&
                          checkMembers == "" &&
                          checkIsAlreadyMember == "") {
                        _groupController.addGroupRequestList(names, groupId);

                        Navigator.of(dialogKey.currentContext!).pop();

                        feedbackPopup(
                          dialogKey.currentContext!,
                          Icons.check,
                          "Mitglied/er erfolgreich hinzugefügt.",
                          "Diese Nutzer bekommen jetzt eine Beitritts-Anfrage.",
                          () {
                            // Callback-Funktion nach dem Feedback-Popup
                          },
                        );
                      } else if (checkMembers != "") {
                        feedbackPopup(
                          dialogKey.currentContext!,
                          Icons.warning_amber,
                          "Fehler beim Hinzufügen der Mitglieder",
                          "Der Nutzer $checkMembers existiert nicht.",
                          () => Navigator.pop(dialogKey.currentContext!),
                        );
                      } else if (checkIsAlreadyMember != "") {
                        feedbackPopup(
                          dialogKey.currentContext!,
                          Icons.warning_amber,
                          "Fehler beim Hinzufügen der Mitglieder",
                          "Der Nutzer $checkIsAlreadyMember ist bereits "
                              "Mitglied oder hat schon eine Anfrage.",
                          () => Navigator.pop(dialogKey.currentContext!),
                        );
                      } else {
                        feedbackPopup(
                          dialogKey.currentContext!,
                          Icons.warning_amber,
                          "Fehler beim Hinzufügen der Mitglieder",
                          "Der Name $duplicate ist doppelt.",
                          () => Navigator.pop(dialogKey.currentContext!),
                        );
                      }
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
                                Navigator.pop(context);

                                // Navigator.pop(context);
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const GroupsHome()));
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
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          backgroundColor:
              controller.isDarkMode ? AppColors.fhwaveNeutral400 : Colors.white,
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
    });
  }
}
