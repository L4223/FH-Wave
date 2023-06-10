import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/user_controller.dart';

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
      SingleChildScrollView( child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              SvgPicture.asset(
                'assets/fhwave_logo_weiss.svg',
                width: 70,
              ),
              const SizedBox(height: 20.0),
              Text('Regstrieren',
                  style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w800,
                      color: _controller.fontColor)),
              const SizedBox(height: 20.0),
//Name
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geb deinen Name ein!';
                  }
                  return null;
                },
                onSaved: (value) {
                  nameController = value!.trim();
                },
              ),
              const SizedBox(height: 20.0),
//Email
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'E-Mail',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geb deine E-Mail ein!';
                  }
//überprüfung, ob die E-Mail-Adresse mit der Ende "fh_kiel.de"
                  if (!value.endsWith('fh-kiel.de')) {
                    return 'Nur FH-E-Mails sind erlaubt!';
                  }
                  return null;
                },
                onSaved: (value) {
                  emailController = value!.trim();
                },
              ),
              const SizedBox(height: 20.0),
// Password
              TextFormField(
              decoration: InputDecoration(
                labelText: 'Passwort',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
//Sichtbarkeit status des Password
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geb dein Passwort ein!';
                }
                passwordController = value;
                return null;
              },
            ),
              const SizedBox(height: 20.0),
//Passwort wiederholen
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password wiederholen',
                  prefixIcon: const Icon(Icons.lock),
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
                      isPasswordVisible ? Icons.visibility
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
              const SizedBox(height: 20.0),
//Name, E-mail und Password an Regstrierungsfunktion Übergeben
          Center( child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _signUpController.signUp(context, nameController,
                        emailController, passwordController);
                  }
                },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ), backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
                child: const Text('Registrieren'),
              ),
          ),
              const SizedBox(height: 20.0),
//Underline Navigieren ==> LoginScreen
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Row(
                  children: [
                    Text(
                      'Schon ein Konto?',
                      style: TextStyle(
                        color: Colors.black,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      ' Anmelden',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
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
      )],
    )
    );
  }
}
