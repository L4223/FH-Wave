import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';
import 'meine_widgets_screen.dart';
import 'profile_screen.dart';
import 'quicklinks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLeftButtonSelected = true;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: Stack(children: [
        // Blauer Hintergrund mit Farbverlauf
        Container(
          height: MediaQuery.of(context).size.height * 3 / 5,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.appBlue, Color.fromRGBO(250, 250, 250, 0)],
            ),
          ),
        ),
        ListView(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // fhwave logo
                        SvgPicture.asset(
                          'assets/fhwave_logo_weiss.svg',
                          width: 70,
                        ),
                        ClipOval(
                          // Profil-Button
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            color: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.photo_camera_outlined),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()),
                                );
                              },

                              /// Um die Konsistenz des Designs zu halten,
                              /// sollten Sie daran denken, die Dekorationen
                              /// von Button zu eliminieren
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 52,
                    ),
                    const Text('Moin,\nMustermann!',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Helvetica Neue')),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text('Bist du voll motiviert?',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica Neue')),
                    const SizedBox(
                      height: 28,
                    ),
                    // Zwei Buttons in einer Reihe zum Wechseln der Seiten
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeftButtonSelected = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLeftButtonSelected
                                  ? Colors.black
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            width: 162.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Meine Widgets',
                                style: TextStyle(
                                    color: isLeftButtonSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Helvetica Neue'),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeftButtonSelected = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLeftButtonSelected
                                  ? Colors.transparent
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                width: 2.0,
                              ),
                            ),
                            width: 162.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Quicklinks',
                                style: TextStyle(
                                    color: isLeftButtonSelected
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Helvetica Neue'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    // Die Widgets werden hier dargestellt
                    Visibility(
                        visible: isLeftButtonSelected,
                        child: meineWidgetsScreen(context)),
                    // Die Quicklinks werden hier dargestellt
                    Visibility(
                      visible: !isLeftButtonSelected,
                      child: quicklinksScreen(context),
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}
