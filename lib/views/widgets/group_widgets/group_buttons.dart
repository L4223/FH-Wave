import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dark_mode_controller.dart';

TextStyle textStyle = const TextStyle(fontSize: 25, color: Color(0xFF26282b));

Color iconColor = const Color(0xFF26282b);

Color bgColor = const Color(0xFFFFFFFF);

ButtonStyle roundButtonStyle(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  return ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(Size(screenWidth * 0.3, 50)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.black, width: 2))),
      backgroundColor: MaterialStateProperty.all<Color>(bgColor));
}

Widget funcButton(
    BuildContext context, String text, IconData icon, void Function() func) {
  return Consumer<DarkModeController>(builder: (context, controller, _) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: roundButtonStyle(context),
        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: func,
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  });
}

Widget pushScreenButton(
    BuildContext context, String route, String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton.icon(
      style: roundButtonStyle(context),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      onPressed: () => Navigator.pushNamed(context, route),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    ),
  );
}

class DropDownMenuWidget extends StatefulWidget {
  final BuildContext context;
  final List<String> list;

  const DropDownMenuWidget(
      {Key? key, required this.context, required this.list})
      : super(key: key);

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  String selectedValue = "Auswählen";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (newValue) {
        // Aktualisieren Sie den ausgewählten Wert,
        // wenn sich der Benutzer ändert
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: widget.list.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
