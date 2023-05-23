import 'package:flutter/material.dart';
import 'build_link_button.dart';
import 'template_screen.dart';

Widget quicklinksScreen(BuildContext context) {
  return Column(
    children: [
      buildLinkButton(context,
          icon: Icons.mail_outline_rounded,
          targetPage: const TemplateScreen(title: 'TEMPLATE'),
          title: 'TEMPLATE'),

      /// Quicklinks hier weiter hinzufügen
    ],
  );
}
