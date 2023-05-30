import 'package:flutter/material.dart';
import 'widgets/quick_link_button.dart';



Widget quickLinksScreen(BuildContext context) {
  return Column(
    children: [
      QuickLinkButton(
        title: 'Webmail',
        icon: Icons.mail_outline_rounded,
        targetURL: 'https://student.fh-kiel.de/',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'Moodle',
        icon: Icons.public_outlined,
        targetURL: 'https://lms.fh-kiel.de/login/index.php',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'Mensa',
        icon: Icons.food_bank_outlined,
        targetURL: 'https://studentenwerk.sh/de/mensen-in-kiel?ort=1&mensa=5#mensaplan',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'QIS',
        icon: Icons.inventory_2_outlined,
        targetURL: 'https://qis.fh-kiel.de/qisserver/rds?state=user&type=0',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'Moduldatenbank',
        icon: Icons.dataset_outlined,
        targetURL: 'https://moduldatenbank.fh-kiel.de/de-DE',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'Modulanmeldung',
        icon: Icons.dataset_linked_outlined,
        targetURL: 'https://modulanmeldung.fh-kiel.de/',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'Bibliothek',
        icon: Icons.local_library_outlined,
        targetURL: 'https://www.fh-kiel.de/zentralbibliothek/',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'DFNCloud',
        icon: Icons.settings_system_daydream_outlined,
        targetURL: 'https://dfncloud.fh-kiel.de/login',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'IDA',
        icon: Icons.groups_outlined,
        targetURL: 'https://ida.fh-kiel.de/',
      ),
      const SizedBox(height: 10), //Spacing
      QuickLinkButton(
        title: 'FH Intern',
        icon: Icons.newspaper_rounded,
        targetURL: 'https://www.fh-kiel.de/fh-intern/',
      ),
      const SizedBox(height: 60), //Spacing zu Seitenende
      /// Quicklinks hier weiter hinzufügen
    ],
  );
}
