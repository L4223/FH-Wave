import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'views/auth_screens/login_screen.dart';
import 'views/auth_screens/signup_screen.dart';
import 'views/group_screens/group_screen.dart';
import 'views/home_screen.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/group': (context) => const GroupCreationScreen(),
      },
    );
  }
}
