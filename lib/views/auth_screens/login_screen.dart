import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/buttons/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final HomeScreenController _controller = HomeScreenController();
  final _formKey = GlobalKey<FormState>();
  final UserController _loginController = UserController();
  String emailController = '';
  String passwordController = '';
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Log In'),
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
                  Text('Anmelden',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.w800,
                          color: _controller.fontColor)),
                  const SizedBox(height: 20.0),
//Email
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      cursorColor: AppColors.black,
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
// Password
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
                          return 'Bitte geb dein Passwort ein!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordController = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
//Name, E-mail und Password an Anmeldesfunktion Übergeben
                  Center(
                    child: PrimaryButton(
                      width: MediaQuery.of(context).size.width - 50,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _loginController.login(
                              context, emailController, passwordController);
                        }
                      },
                      text: 'Anmelden',
                    ),
                  ),
                  const SizedBox(height: 20.0),
//Underline Navigieren ==> LoginScreen
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          'Noch kein Konto?',
                          style: TextStyle(color: Colors.black, fontSize: 16
                              //decoration: TextDecoration.underline,
                              ),
                        ),
                        Text(
                          ' Registrieren ',
                          style: TextStyle(
                            color: AppColors.fhwaveBlue600,
                            // decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      )
        ],
      ),
    );
  }
}
