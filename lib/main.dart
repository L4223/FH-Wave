import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/dark_mode_controller.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkModeController>(
      create: (_) => DarkModeController(),
      child: Consumer<DarkModeController>(
        builder: (context, controller, _) {
          return MaterialApp(
            theme: ThemeData(
              brightness:
                  controller.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
