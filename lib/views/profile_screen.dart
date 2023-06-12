import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/home_screen_controller.dart';
import '../controllers/user_controller.dart';
import 'widgets/buttons/primary_button.dart';
import 'widgets/dark_mode_button.dart';

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
//Profielbild
              const SizedBox(
                height: 130, // Höhe des Platzhalters anpassen
                width: 130, // Breite des Platzhalters anpassen
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
                      color: _controller.fontColor)),
//Benutzer E-Mail
              const SizedBox(
                height: 4,
              ),
              Text('$userEmail',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: _controller.fontColor)),
//Abmelden Button
              const SizedBox(
                height: 40,
              ),
              const DarkModeButton(),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Abmelden',
                onTap: () {
                  currentUser.signOut();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
