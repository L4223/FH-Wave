import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'controllers/user_controller.dart';
import 'firebase_options.dart';
import 'views/home_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "FH-Wave", options: DefaultFirebaseOptions.android);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController? user = UserController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // Authentifizierungsüberprüfung:
          //User Rigstriert und verfiziert ==> HomeScreen
          // ansonsten ==> LoginScreen
          user.checkAuth() == false ? const LoginScreen() : const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
