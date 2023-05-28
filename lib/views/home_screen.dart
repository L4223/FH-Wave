import 'package:flutter/material.dart';
import '../Widgets/dark_mode_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  NewHomeScreen createState() => NewHomeScreen();
}

class NewHomeScreen extends State<HomeScreen> {
  void updateBackgroundColor(Color color) {
    setState(() {
      hintergrundfarbe = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hintergrundfarbe.toString()),
        backgroundColor:
            hintergrundfarbe, // Aktualisiere die Hintergrundfarbe der AppBar
      ),
      body: Center(
        child: DarkMode(updateBackgroundColor), // Übergib die Callback-Funktion
      ),
      backgroundColor: hintergrundfarbe,
    );
  }
}
