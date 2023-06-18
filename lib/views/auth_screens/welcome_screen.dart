import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/secondary_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final HomeScreenController _controller = HomeScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppColors.getFhwaveBlueGradientContainer(context),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 3),
                Text('Willkommen bei',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: _controller.fontColor)),
                const SizedBox(height: 30.0),
                Image.asset(
                  "assets/fhwave-loading-standard.gif",
                  gaplessPlayback: true,
                  width: 90.0,
                ),
                const SizedBox(height: 180.0),
                PrimaryButton(
                  width: MediaQuery.of(context).size.width - 50,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        ModalRoute.withName('/login'));
                  },
                  text: 'Anmelden',
                ),
                const SizedBox(height: 20.0),
                SecondaryButton(
                  width: MediaQuery.of(context).size.width - 50,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                        ModalRoute.withName('/signup'));
                  },
                  text: 'Registrieren',
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Version 1.0.0 - fhwave von AEM Team 9',
                  style: TextStyle(
                      color: AppColors.fhwaveNeutral300, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
