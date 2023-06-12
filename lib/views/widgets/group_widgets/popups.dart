import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../controllers/group_controller.dart';
import '../../group_screens/group_screen.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

void closeKeyboard(BuildContext context) {
  var currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

final groupNameTextController = TextEditingController();
final memberTextController = TextEditingController();
final GroupController _groupController = GroupController();
String groupName = "";

Widget nameInputField() {
  return TextFormField(
    onChanged: (text) {
      groupNameTextController.text = text;
    },
    maxLength: 20,
    decoration: const InputDecoration(
      labelText: "Name",
      labelStyle: TextStyle(
        color: AppColors.fhwaveNeutral400,
      ),
      // helperText: 'Helper text',
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.fhwaveBlue400),
      ),
    ),
  );
}

Future<void> createGroup(BuildContext context, String memberNames) async {
  var groupName = groupNameTextController.text.trim();
  var creatorId = currentUser?.uid;

  _groupController.createGroup(groupName, creatorId!).then(
      (groupId) => _groupController.addGroupRequestList(memberNames, groupId));

  // String groupId = await _groupController.getGroupIdFromGroupName(groupName);
  memberTextController.clear();
  Navigator.of(context).pop();
  closeKeyboard(context);
  feedbackPopup(
      context,
      Icons.check,
      "Gruppe erfolgreich erstellt!",
      "Du kannst dir jetzt die Mitglieder anschauen "
          "oder die Gruppe wieder auflösen.");
}

void createGroupPopup(BuildContext context) {
  Widget memberInputField() {
    return TextFormField(
      controller: memberTextController,
      maxLength: 20,
      decoration: const InputDecoration(
        labelText: "Mitglieder",
        labelStyle: TextStyle(
          color: AppColors.fhwaveNeutral400,
        ),
        // helperText: 'Helper text',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.fhwaveBlue400),
        ),
      ),
    );
  }

  // void createNameList(String namesString) {
  //   List<String> nameList = namesString.split(',').map((name) {
  //     return name.trim();
  //   }).toList();
  //
  //   nameList.forEach((userName) {
  //     _groupController.addGroupRequest(userName);
  //   });
  // }

  // void addGroupRequest(String userName) {
  //   // Hier wird die Logik für die Verarbeitung der Gruppenanfrage für den jeweiligen Benutzernamen ausgeführt
  //   print('Gruppenanfrage hinzugefügt für: $userName');
  // }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Text('Gruppe erstellen'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              nameInputField(),
              memberInputField(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecondaryButton(
                    text: "Abbrechen",
                    onTap: () => Navigator.of(context).pop(),
                    width: 130,
                  ),
                  PrimaryButton(
                    text: "Erstellen",
                    onTap: () {
                      createGroup(context, memberTextController.text);
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
  );
}

void addMemberPopup(BuildContext context, String groupId) {
  Widget memberInputField() {
    return TextFormField(
      controller: memberTextController,
      maxLength: 20,
      decoration: const InputDecoration(
        labelText: "Mitglieder",
        labelStyle: TextStyle(
          color: AppColors.fhwaveNeutral400,
        ),
        // helperText: 'Helper text',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.fhwaveBlue400),
        ),
      ),
    );
  }

  // void createNameList(String namesString) {
  //   List<String> nameList = namesString.split(',').map((name) {
  //     return name.trim();
  //   }).toList();
  //
  //   nameList.forEach((userName) {
  //     _groupController.addGroupRequest(userName);
  //   });
  // }

  // void addGroupRequest(String userName) {
  //   // Hier wird die Logik für die Verarbeitung der Gruppenanfrage für den jeweiligen Benutzernamen ausgeführt
  //   print('Gruppenanfrage hinzugefügt für: $userName');
  // }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Text('Mitglieder hinzufügen'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              memberInputField(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecondaryButton(
                    text: "Abbrechen",
                    onTap: () => Navigator.of(context).pop(),
                    width: 130,
                  ),
                  PrimaryButton(
                    text: "Hinzufügen",
                    onTap: () {
                      _groupController.addGroupRequestList(
                          memberTextController.text, groupId);
                      memberTextController.clear();
                      Navigator.pop(context);
                      feedbackPopup(
                          context,
                          Icons.check,
                          "Mitglied/er erfolgreich hinzugefügt, diese",
                          "Nutzer bekommen jetzt eine Beitritts-Anfrage.");
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
  );
}

void feedbackPopup(
    BuildContext context, IconData icon, String heading, String text) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            // title: const Text('Gruppe erstellen'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // smallRoundButton(context, () {
                //   Navigator.of(context).pop();
                // }, "Abbrechen"),
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
                    style: const TextStyle(color: AppColors.fhwaveNeutral200),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                      text: "Weiter",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GroupsHome()));
                      }),
                ],
              ),
            ),
          ));
}

void confirmPopup(BuildContext context, IconData icon, String heading,
    String text, VoidCallback func) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            // title: const Text('Gruppe erstellen'),
            content: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // smallRoundButton(context, () {
                //   Navigator.of(context).pop();
                // }, "Abbrechen"),
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
                      style: const TextStyle(color: AppColors.fhwaveNeutral200),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GroupsHome()));
                        },
                        width: 130,
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
}
