import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../views/home_screen.dart';
import '../views/widgets/buttons/primary_button.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User existiert? ==>
  // Eingabefehler mithilfe von AlertDialogs überpruft.
  //Kein Eingabefehler ==> Anmelden

  User? get currentUser => _auth.currentUser;

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;

// Regstriert und verifiziert?
// Daten aus Firebase speichern/Id & e-mail & username
// und Navigieren ==> HomeScreen

      if (user != null && user.emailVerified) {
        // _currentUser = UserModel(uid: user.uid, email: user.email!);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            ModalRoute.withName('/home'));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('E-Mail Überprüfung')),
            content: const Text(
              'Bitte verifiziere deine E-Mail, bevor du dich anmeldest.',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
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
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('Fehler bei der Anmeldung')),
            content: const Text(
              'Kein Konto für diese E-Mail gefunden.',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
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
          ),
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('Fehler bei der Anmeldung')),
            content: const Text(
              'Passwort ist gültig',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
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
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Container(
              alignment: Alignment.center,
              child: const Text('Fehler bei der Anmeldung')),
          content: Text(
            'Fehler aufgetreten: $e',
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
        ),
      );
    }
  }

  Future<void> logOut() async {
    _auth.signOut();
  }

  //Email und Password != Null? ==>
  // Eingabefehler mithilfe von AlertDialogs überpruft.
  //Kein Eingabefehler ==> Regstrieren
  Future<void> signUp(BuildContext context, String username, String email,
      String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = userCredential.user;
      //die eingegebne Name beim Regstrieren als DisplayName speichern!
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      await user?.reload();
      if (user != null) {
        await user.sendEmailVerification();
        setupUserDb(username, user.uid, email);

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('Registrierung erfolgreich')),
            content: const Text(
              'Bitte überprüfe deine E-Mail,'
              'um dein Konto zu bestätigen.',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
            ),
            actions: [
              Center(
                child: PrimaryButton(
                  width: 120,
                  height: 40,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');
                  },
                  text: 'OK',
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('Fehler bei der Registrierung')),
            content: const Text(
              'Passwort ist zu schwach.',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
            ),
            actions: [
              Center(
                child: PrimaryButton(
                  width: 120,
                  height: 40,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'OK',
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
                alignment: Alignment.center,
                child: const Text('Fehler bei der Registrierung')),
            content: const Text(
              'Ein Konto existiert bereits für diese E-Mail.',
              style: TextStyle(color: AppColors.fhwaveNeutral300),
            ),
            actions: [
              Center(
                child: PrimaryButton(
                  width: 120,
                  height: 40,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'OK',
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Container(
              alignment: Alignment.center,
              child: const Text('Fehler bei der Registrierung')),
          content: Text(
            'Fehler aufgetreten: $e',
            style: const TextStyle(color: AppColors.fhwaveNeutral300),
          ),
          actions: [
            Center(
              child: PrimaryButton(
                width: 120,
                height: 40,
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'OK',
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
  }

  // Future<void> resetPassword(String email) async {
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //   } catch (e) {
  //   }
  // }

  //Authentifizierungsüberprüfung
  Future<bool> checkAuth() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setupUserDb(String userName, String uid, String userMail) async {
    var firestore = FirebaseFirestore.instance;

    try {
      final groupRef = firestore.collection('users').doc(uid);
      var list = [];

      await groupRef.set({
        'userName': userName,
        'uid': uid,
        'userMail': userMail,
        'group_requests': FieldValue.arrayUnion(list),
        'groups': FieldValue.arrayUnion(list),
      });
    } catch (e) {
      // print('Fehler beim Erstellen der Gruppe: $e');
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      // Erfolgreiche Abmeldung
      //print("efolgreich abgemeldet");
    } catch (e) {
      // Fehler bei der Abmeldung
      //print('Fehler bei der Abmeldung: $e');
    }
  }
}
