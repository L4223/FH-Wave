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
import 'views/group_screens/group_screen.dart';
import 'views/home_screen.dart';

dynamic screenSize; //Screen Size

UserController userController = UserController();
User? user = userController.currentUser;
Future<void> main() async {
  // FirebaseOptions firebaseOptions = FirebaseOptions(
  //     apiKey: "AIzaSyANUV9WeE0Kl-47hzEZwWcRZVreJfotw-A",
  //     appId: "1:728562690240:android:d1967f8145a42636eba525",
  //     messagingSenderId: "728562690240",
  //     projectId: "fh-wave",
  //     databaseURL: "https://fh-wave-default-rtdb.europe-west1.firebasedatabase.app"
  // );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "FH-Wave", options: DefaultFirebaseOptions.android);

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
              fontFamily: 'Roboto',
            ),
            debugShowCheckedModeBanner: false,
            home: userController.checkAuth() == false
                ? const LoginScreen()
                : const HomeScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/group': (context) => const GroupCreationScreen(),
              '/calendar': (context) => const CalendarScreen(),
            },
          );
        },
      ),
    );
  }
}
