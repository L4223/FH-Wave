import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:provider/provider.dart';
import '../app_colors.dart';
import '../controllers/dark_mode_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/user_controller.dart';

//import '../controllers/dark_mode_controller.dart';
//import '../controllers/profile_screen_controller.dart';
import '../views/home_screen.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent, // Hintergrund transparent machen
      body: Stack(
        children: [
// HomeScreen im Hinterground anzeigen
          const Positioned.fill(
            child: HomeScreen(),
          ),
// Scrollbare Fläsche auf home_screen Platzieren
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
// Exit Icon
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: _controller.fontColor,
                            // Schließt den ProfileScreen
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                              height: 150, // Höhe des Platzhalters anpassen
                              width: 150, // Breite des Platzhalters anpassen
                              child: CircleAvatar(
                                  //backgroundImage: AssetImage('assets/felix.jpg'),
                                  ),
                            ),
//Benuzername
                            const SizedBox(height: 20.0),
                            Text('$username!',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                currentUser.signOut();
                                Navigator.pushNamed(context, '/login');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Colors.black,
                                minimumSize: const Size(150, 30),
                              ),
                              child: const Text('Abmelden'),
                            ),
                            const DarkModeButton(),
                            const SizedBox(height: 10),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
