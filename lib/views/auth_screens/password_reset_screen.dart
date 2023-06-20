import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart';

import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/secondary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final HomeScreenController _controller = HomeScreenController();
  final _formKey = GlobalKey<FormState>();

  String emailController = '';
  String emailEnd = '@student.fh-kiel.de';

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
                    const SizedBox(height: 30.0),
                    Text(
                      'Passwort zurücksetzen',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: _controller.fontColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "➊ Gib bitte die E-Mail-Adresse deines "
                        "fhwave-Kontos ein.",
                        style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.w800,
                          color: AppColors.fhwaveNeutral500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "➋ Wenn deine E-Mail-Adresse verifiziert ist, "
                        "erhaltest du eine E-Mail mit Anweisungen.",
                        style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.w800,
                          color: AppColors.fhwaveNeutral500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "➌ Nach Bestätigung deines neuen Passwortes bleibst du "
                        "eingeloggt und das Passwort wurde gespeichert!",
                        style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.w800,
                          color: AppColors.fhwaveNeutral500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    buildEmailFormField(),
                    const SizedBox(height: 30.0),
                    PrimaryButton(
                      width: MediaQuery.of(context).size.width - 50,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          resetPassword();
                        }
                      },
                      text: 'Password zurücksetzen',
                    ),
                    const SizedBox(height: 20.0),
                    SecondaryButton(
                        width: MediaQuery.of(context).size.width - 50,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: "Zurück"),
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
        suffixStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte gib deine E-Mail ein!';
        }
        return null;
      },
      onSaved: (value) {
        emailController = value!.trim() + emailEnd;
      },
    );
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController);
      showSuccessDialog();
    } catch (e) {
      showErrorDialog(e);
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Container(
              alignment: Alignment.center,
              child: const Text('Password zurücksetzen')),
          content: Text(
            'E-Mail zum Zurücksetzen des Passworts wurde an '
            '$emailController gesendet',
            style: const TextStyle(color: AppColors.fhwaveNeutral300),
          ),
          actions: [
            Center(
              child: PrimaryButton(
                width: 120,
                height: 40,
                onTap: () => Navigator.pop(context),
                text: 'OK',
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }

  void showErrorDialog(dynamic e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Container(
              alignment: Alignment.center,
              child: const Text('Password zurücksetzen')),
          content: Text(
            'Zurücksetzen des Passworts ist fehlgeschlagen: $e',
            style: const TextStyle(color: AppColors.fhwaveNeutral300),
          ),
          actions: [
            Center(
              child: PrimaryButton(
                width: 120,
                height: 40,
                onTap: () => Navigator.pop(context),
                text: 'OK',
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
