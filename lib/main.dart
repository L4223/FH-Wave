import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    // Rufe die Authentifizierungsüberprüfung auf
    checkAuth();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: checkAuth() == false ? const LoginScreen() : const HomeScreen(),
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

bool checkAuth() {
  //Authentifizierungsüberprüfung
  var user = FirebaseAuth.instance.currentUser;

  if (user != null && user.emailVerified) {
    return true;
  } else {
    return false;
  }
}
