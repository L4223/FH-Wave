// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app_colors.dart';
import '../controllers/dark_mode_controller.dart';
import 'group_calendar_screen.dart';
import 'group_screens/group_screen.dart';
import 'template_screen.dart';

// import 'widgets/buttons/primary_button.dart';
// import 'widgets/buttons/primary_button_with_icon.dart';
// import 'widgets/buttons/secondary_button.dart';
import 'widgets/buttons/widget_button.dart';
import 'widgets/time_table_screen.dart';

Widget meineWidgetsScreen(BuildContext context) {
  return Consumer<DarkModeController>(builder: (context, controller, _) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        /// Hier sind nur Beispiele, biite modifizieren oder ersetzen

        WidgetButton(
          title: 'Campus Navigation',
          textColor:
              controller.isDarkMode ? AppColors.fhwaveBlue500 : AppColors.black,
          backgroundColor: controller.isDarkMode
              ? AppColors.fhwaveNeutral500
              : AppColors.fhwaveBlue500,
          icon: SvgPicture.asset(
            'assets/map.svg',
            width: 45,
            height: 45,
            color: controller.isDarkMode
                ? AppColors.fhwaveBlue500
                : AppColors.black,
          ),
          targetPage: TemplateScreen(),
        ),
        WidgetButton(
          title: 'Gruppen',
          textColor: controller.isDarkMode
              ? AppColors.fhwavePurple500
              : AppColors.black,
          backgroundColor: controller.isDarkMode
              ? AppColors.fhwaveNeutral500
              : AppColors.fhwavePurple500,
          icon: SvgPicture.asset(
            'assets/team.svg',
            width: 45,
            height: 45,
            color: controller.isDarkMode
                ? AppColors.fhwavePurple500
                : AppColors.black,
          ),
          targetPage: const GroupsHome(),
        ),
        WidgetButton(
            title: 'Kalender',
            textColor: controller.isDarkMode
                ? AppColors.fhwaveYellow500
                : AppColors.black,
            backgroundColor: controller.isDarkMode
                ? AppColors.fhwaveNeutral500
                : AppColors.fhwaveYellow500,
            icon: SvgPicture.asset(
              'assets/calendar.svg',
              width: 50,
              height: 50,
              color: controller.isDarkMode
                  ? AppColors.fhwaveYellow500
                  : AppColors.black,
            ),
            targetPage: const GroupCalendarScreen(),
            isLarge: true),
        WidgetButton(
            title: 'Stundenplanverteilung',
            textColor: controller.isDarkMode
                ? AppColors.fhwaveGreen400
                : AppColors.black,
            backgroundColor: controller.isDarkMode
                ? AppColors.fhwaveNeutral500
                : AppColors.fhwaveGreen400,
            icon: Icon(
              Icons.access_time,
              size: 56,
              color: controller.isDarkMode
                  ? AppColors.fhwaveGreen400
                  : AppColors.black,
            ),
            targetPage: TimeTablePage(),
            isLarge: true),
        // PrimaryButtonWithIcon(
        //   icon: Icons.add,
        //   text: "Member Hinzufügen",
        //   onTap: () => {},
        // ),
        // PrimaryButton(
        //     text: "Anmelden",
        //     onTap: () => {},
        //     width: MediaQuery.of(context).size.width - 50),
        // SecondaryButton(
        //     text: "Registeren",
        //     onTap: () => {},
        //     width: MediaQuery.of(context).size.width - 50)

        /// Widgets hier hinzufügen.
        /// Achtung! Nur oben, nicht nach dem Center unten!
        // Center(
        //   child: ClipOval(
        //     child: Container(
        //       color: Colors.black,
        //       child: IconButton(
        //         icon: const Icon(Icons.add, color: Colors.white),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context)
        //             => AddWidgetsScreen()),
        //           );
        //         },
        //         highlightColor: Colors.transparent,
        //         splashColor: Colors.transparent,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  });
}
