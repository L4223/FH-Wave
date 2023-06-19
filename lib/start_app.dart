import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/dark_mode_controller.dart';
import 'main.dart';
import 'views/auth_screens/login_screen.dart';
import 'views/auth_screens/password_reset_screen.dart';
import 'views/auth_screens/signup_screen.dart';
import 'views/auth_screens/welcome_screen.dart';
import 'views/calendar_screen.dart';
import 'views/group_screens/group_screen.dart';
import 'views/group_screens/request_screen.dart';
import 'views/home_screen.dart';



class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);


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
                    return Image.asset(
                      "assets/fhwave-loading-schwarz.gif",
                      gaplessPlayback: true,
                      width: 70.0,
                    );
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
                          : const WelcomeScreen(),
                      routes: {
                        '/login': (context) => const LoginScreen(),
                        '/welcome': (context) => const WelcomeScreen(),
                        '/home': (context) => const HomeScreen(),
                        '/signup': (context) => const SignUpScreen(),
                        '/group': (context) => const GroupsHome(),
                        '/request': (context) => const RequestScreen(),
                        '/calendar': (context) => const CalendarScreen(),
                        '/resetps': (context) => const ResetPasswordScreen()
                      },
                    );
                  }
                },
              );
            }
        )
    );
  }
}
