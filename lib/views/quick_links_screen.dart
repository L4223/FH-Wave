import 'package:flutter/material.dart';

import 'template_screen.dart';
import 'widgets/quick_link_button.dart';

Widget quickLinksScreen(BuildContext context) {
  return Column(
    children: [
      QuickLinkButton(
        title: 'TEMPLATE',
        icon: Icons.mail_outline_rounded,
        targetPage: TemplateScreen(),
      ),

      /// Quicklinks hier weiter hinzufügen
    ],
  );
}
