import 'package:flutter/material.dart';

Widget buildLinkButton(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Widget targetPage,
}) {
  const width = 338.0;
  const height = 50.0;

  void navigateToTargetPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  return GestureDetector(
    onTap: navigateToTargetPage,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Icon(
                icon,
                size: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica Neue',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
