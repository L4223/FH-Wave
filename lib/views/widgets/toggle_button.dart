import 'package:flutter/material.dart';
import '../../app_colors.dart';

class ToggleButton extends StatefulWidget {
  final Function(bool) onToggle;

  const ToggleButton({Key? key, required this.onToggle}) : super(key: key);

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

const double width = 300.0;
const double height = 58.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = AppColors.white;
const Color normalColor = AppColors.black;

class ToggleButtonState extends State<ToggleButton> {
  bool isMeineWidgetsSelected = true;

  void toggle(bool isSelected) {
    setState(() {
      isMeineWidgetsSelected = isSelected;
      widget.onToggle(isMeineWidgetsSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: height,
        decoration: const BoxDecoration(
          color: AppColors.fhwaveNeutral100,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(
                  isMeineWidgetsSelected ? loginAlign : signInAlign, 0),
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 400),
              child: Container(
                width: width * 0.58,
                height: height,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                toggle(true);
              },
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Container(
                  width: width * 0.58,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Meine Widgets',
                    style: TextStyle(
                      color:
                      isMeineWidgetsSelected ? selectedColor : normalColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                toggle(false);
              },
              child: Align(
                alignment: const Alignment(0.89, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Quicklinks',
                    style: TextStyle(
                      color:
                      isMeineWidgetsSelected ? normalColor : selectedColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
