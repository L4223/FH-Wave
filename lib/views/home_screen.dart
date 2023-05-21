import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: Stack(children: [
        // Blue Gradient Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter / 4,
              colors: const [
                Color.fromRGBO(168, 207, 255, 1),
                Colors.white,
              ],
            ),
          ),
        ),
        // fhwave logo
        Positioned(
          top: 120,
          left: 28,
          child: SvgPicture.asset(
            'assets/fhwave_logo_weiss.svg',
            width: 70,
          ),
        ),
      ]),
    );
  }
}
