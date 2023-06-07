import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';
import '../controllers/home_screen_controller.dart';
import 'meine_widgets_screen.dart';
import 'profile_screen.dart';
import 'quick_links_screen.dart';
import 'widgets/toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isMeineWidgetsVisible = true;
  final HomeScreenController _controller = HomeScreenController();
  int selectedIndex = 0;
  List<bool> isSelected = [true, false];
  PageController pageController = PageController(initialPage: 0);

  void onToggle(bool isMeineWidgetsSelected) {
    setState(() {
      isMeineWidgetsVisible = isMeineWidgetsSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AppColors.getFhwaveBlueGradientContainer(context),
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
                        SvgPicture.asset(
                          'assets/fhwave_logo_weiss.svg',
                          width: 70,
                        ),
                        ClipOval(
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            color: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.account_circle_outlined),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()),
                                );
                              },
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
                    Text('${_controller.greeting}, \n${_controller.name}!',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w800,
                            color: _controller.fontColor)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(_controller.motivatingWords,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 28,
                    ),
                    ToggleButton(onToggle: onToggle),
                    const SizedBox(
                      height: 25,
                    ),
                    Visibility(
                      visible: isMeineWidgetsVisible,
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        meineWidgetsScreen(context)
                      ]),
                    ),
                    Visibility(
                      visible: !isMeineWidgetsVisible,
                      child: quickLinksScreen(context),
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}
