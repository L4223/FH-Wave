import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/buttons/primary_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserController _signUpController = UserController();
  final HomeScreenController _controller = HomeScreenController();
  String emailController = '';
  String passwordController = '';
  String nameController = '';
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
        title: const Text('Sign Up'),
      ),*/
        body: Stack(
      children: [
        AppColors.getFhwaveBlueGradientContainer(context),
        SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 130.0),
                SvgPicture.asset(
                  'assets/fhwave_logo_weiss.svg',
                  width: 70,
                ),
                const SizedBox(height: 50.0),
                Text('Regstrieren',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: _controller.fontColor)),
                const SizedBox(height: 20.0),
//Name
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.person,
                          size: 24,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte gib deinen Namen ein!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameController = value!.trim();
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.email,
                          size: 22,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte gib deine E-Mail ein!';
                      }
                      if (!value.trim().endsWith('fh-kiel.de')) {
                        return 'Nur FH-E-Mails sind erlaubt!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController = value!.trim();
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.lock,
                          size: 24,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte gib dein Passwort ein!';
                      }
                      passwordController = value;
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Passwort wiederholen',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.lock,
                          size: 24,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte bestätige dein Passwort!';
                      }
                      if (value != passwordController) {
                        return 'Passwort stimmt nicht überein!';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20.0),
//Name, E-mail und Password an Regstrierungsfunktion Übergeben
                Center(
                  child: PrimaryButton(
                    width: MediaQuery.of(context).size.width - 50,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _signUpController.signUp(context, nameController,
                            emailController, passwordController);
                      }
                    },
                    text: 'Registrieren',
                  ),
                ),
                const SizedBox(height: 20.0),
//Underline Navigieren ==> LoginScreen
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        ModalRoute.withName('/login'));
                  },
                  child: const Row(
                    children: [
                      SizedBox(width: 13),
                      Text(
                        'Schon ein Konto?',
                        style: TextStyle(color: Colors.black, fontSize: 16
                            //decoration: TextDecoration.underline,
                            ),
                      ),
                      Text(
                        ' Anmelden',
                        style: TextStyle(
                          color: AppColors.fhwaveBlue600,
                          fontSize: 16,
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
