import 'package:flutter/material.dart';

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
  String emailEnd = '@student.fh-kiel.de';
  String passwordController = '';
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loginController.updateLinkStatus(context);
  }


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
                      'Einloggen',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: _controller.fontColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    buildEmailFormField(),
                    const SizedBox(height: 20.0),
                    buildPasswordFormField(),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/resetps'),
                          child: const Text(
                            "Password vergessen?",
                            style: TextStyle(
                              color: AppColors.fhwaveBlue600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    buildLoginButton(),
                    const SizedBox(height: 20.0),
                    buildSignUpLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      cursorColor: AppColors.black,
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
        suffixText: emailEnd,
        suffixStyle: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte gib deine E-Mail ein!';
        }
        return null;
      },
      onSaved: (value) {
        emailController = value!.trim()+emailEnd;
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
        return null;
      },
      onSaved: (value) {
        passwordController = value!;
      },
    );
  }

  Center buildLoginButton() {
    return Center(
      child: PrimaryButton(
        width: MediaQuery.of(context).size.width - 50,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _loginController.login(
              context,
              emailController,
              passwordController,
            );
          }
        },
        text: 'Anmelden',
      ),
    );
  }

  GestureDetector buildSignUpLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: const Row(
        children: [
          SizedBox(width: 13),
          Text(
            'Noch kein Konto?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            ' Registrieren ',
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
