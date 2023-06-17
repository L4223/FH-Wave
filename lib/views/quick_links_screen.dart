import 'package:flutter/material.dart';
import 'widgets/buttons/quick_link_button.dart';

Widget quickLinksScreen(BuildContext context) {
  return const Column(
    children: [
      QuickLinkButton(
        text: 'Webmail',
        icon: Icons.mail_outline_rounded,
        url: 'https://student.fh-kiel.de/',
      ),
      SizedBox(height: 10.0),
      //Spacing
      QuickLinkButton(
        text: 'Moodle',
        icon: Icons.public_outlined,
        url: 'https://lms.fh-kiel.de/login/index.php',
      ),
      SizedBox(height: 10.0),
      QuickLinkButton(
        text: 'Mensa',
        icon: Icons.food_bank_outlined,
        url:
            'https://studentenwerk.sh/de/mensen-in-kiel?ort=1&mensa=5#mensaplan',
      ),
      SizedBox(height: 10.0),
      QuickLinkButton(
        text: 'QIS',
        icon: Icons.inventory_2_outlined,
        url: 'https://qis.fh-kiel.de/qisserver/rds?state=user&type=0',
      ),
      SizedBox(height: 10.0),
      QuickLinkButton(
        text: 'Moduldatenbank',
        icon: Icons.dataset_outlined,
        url: 'https://moduldatenbank.fh-kiel.de/de-DE',
      ),
      SizedBox(height: 10.0),

      QuickLinkButton(
        text: 'Modulanmeldung',
        icon: Icons.dataset_linked_outlined,
        url: 'https://modulanmeldung.fh-kiel.de/',
      ),
      SizedBox(height: 10.0), //Spacing
      QuickLinkButton(
        text: 'Bibliothek',
        icon: Icons.local_library_outlined,
        url: 'https://www.fh-kiel.de/zentralbibliothek/',
      ),
      SizedBox(height: 10.0), //Spacing
      QuickLinkButton(
        text: 'DFNCloud',
        icon: Icons.settings_system_daydream_outlined,
        url: 'https://dfncloud.fh-kiel.de/login',
      ),
      SizedBox(height: 10.0), //Spacing
      QuickLinkButton(
        text: 'IDW',
        icon: Icons.groups_outlined,
        url: 'https://ida.fh-kiel.de/',
      ),
      SizedBox(height: 10.0), //Spacing
      QuickLinkButton(
        text: 'FH Intern',
        icon: Icons.newspaper_rounded,
        url: 'https://www.fh-kiel.de/fh-intern/',
      ),
      SizedBox(height: 60.0), //Spacing zu Seitenende
      /// Quicklinks hier weiter hinzufügen
    ],
  );
}
