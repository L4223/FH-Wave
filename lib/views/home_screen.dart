import 'package:flutter/material.dart';
import '../Widgets/dark_mode_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: DarkModeButton(),
      ),
    );
  }
}
