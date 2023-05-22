import 'package:flutter/material.dart';
import 'build_link_button.dart';
import 'template_screen.dart';

Widget QuicklinksScreen(BuildContext context) {
  return Column(
    children: [
      buildLinkButton(context,
          icon: Icons.mail_outline_rounded,
          targetPage: TemplateScreen(title: 'TEMPLATE'),
          title: 'TEMPLATE'),

      /// Add quick links here
    ],
  );
}
