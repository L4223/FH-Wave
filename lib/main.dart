import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/dark_mode_controller.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';
import 'views/auth_screens/login_screen.dart';
import 'views/auth_screens/signup_screen.dart';
import 'views/calendar_screen.dart';
import 'views/group_calendar_screen.dart';
import 'views/group_screens/group_screen.dart';
import 'views/home_screen.dart';

dynamic screenSize; //Screen Size

UserController userController = UserController();
User? user = userController.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "FH-Wave", options: DefaultFirebaseOptions.currentPlatform);

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
          return FutureBuilder<bool>(
            future: userController.checkAuth(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final isAuthenticated = snapshot.data ?? false;
                return MaterialApp(
                  theme: ThemeData(
                    brightness: controller.isDarkMode
                        ? Brightness.dark
                        : Brightness.light,
                    fontFamily: 'Roboto',
                  ),
                  debugShowCheckedModeBanner: false,
                  home: isAuthenticated
                      ? const HomeScreen()
                      : const LoginScreen(),
                  routes: {
                    '/login': (context) => const LoginScreen(),
                    '/home': (context) => const HomeScreen(),
                    '/signup': (context) => const SignUpScreen(),
                    '/group': (context) => const GroupCreationScreen(),
                    '/calendar': (context) => const GroupCalendarScreen(),
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
