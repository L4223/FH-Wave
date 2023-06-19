import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/dark_mode_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/user_controller.dart';
import 'auth_screens/welcome_screen.dart';
import 'widgets/buttons/primary_button.dart';
import 'widgets/buttons/secondary_button.dart';

//final ProfileScreenController _controller = ProfileScreenController();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeScreenController _controller = HomeScreenController();
  final UserController currentUser = UserController();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var username = user?.displayName;
    var userEmail = user?.email;
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
// Exit Icon
              GestureDetector(
                child: Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: _controller.fontColor,
                ),

                // Schließt den ProfileScreen
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20, // Höhe des Platzhalters anpassen
                  // width: 100, // Breite des Platzhalters anpassen
                  // child: CircleAvatar(
                  //     backgroundImage: AssetImage('assets/felix.jpg'),
                  //     ),
                ),
//Benuzername
                const SizedBox(height: 20.0),
                Text('$username',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: controller.isDarkMode
                            ? Colors.white
                            : Colors.black)),
//Benutzer E-Mail
                const SizedBox(
                  height: 4,
                ),
                Text('$userEmail',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: controller.isDarkMode
                            ? Colors.white
                            : Colors.black)),
//Abmelden Button
                const SizedBox(
                  height: 40,
                ),
                SecondaryButton(
                    width: MediaQuery.of(context).size.width - 120,
                    text: controller.isDarkMode ? 'LightMode' : 'DarkMode',
                    onTap: () => controller.toggleDarkMode()),
                const SizedBox(height: 20.0),
                SecondaryButton(
                    width: MediaQuery.of(context).size.width - 120,
                    text: "Password zurücksetzen",
                    onTap: () {
                      Navigator.pushNamed(context, '/resetps');
                    }),

                const SizedBox(height: 20),
                PrimaryButton(
                  width: MediaQuery.of(context).size.width - 120,
                  text: 'Abmelden',
                  onTap: () {
                    currentUser.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        ModalRoute.withName('/welcome'));
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
