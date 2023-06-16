import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/user_controller.dart';
import '../widgets/buttons/primary_button.dart';

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
                    Image.asset(
                      "assets/fhwave-loading-weiss-schwarz.gif",
                      gaplessPlayback: true,
                      width: 70.0,
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                      'Registrieren',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: _controller.fontColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    buildNameFormField(),
                    const SizedBox(height: 20.0),
                    buildEmailFormField(),
                    const SizedBox(height: 20.0),
                    buildPasswordFormField(),
                    const SizedBox(height: 20.0),
                    buildConfirmPasswordFormField(),
                    const SizedBox(height: 20.0),
                    buildSignUpButton(),
                    const SizedBox(height: 20.0),
                    buildLoginLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
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
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-Mail-Adresse',
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
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
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
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
    );
  }

  Center buildSignUpButton() {
    return Center(
      child: PrimaryButton(
        width: MediaQuery.of(context).size.width - 50,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _signUpController.signUp(
              context,
              nameController,
              emailController,
              passwordController,
            );
          }
        },
        text: 'Registrieren',
      ),
    );
  }

  GestureDetector buildLoginLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login').then((value) {
          setState(() {
            // Reset form values
            nameController = '';
            emailController = '';
            passwordController = '';
          });
        });
      },
      child: const Row(
        children: [
          SizedBox(width: 13),
          Text(
            'Schon ein Konto?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            ' Anmelden',
            style: TextStyle(
              color: AppColors.fhwaveBlue600,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
