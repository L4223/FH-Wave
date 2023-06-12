import 'package:flutter/material.dart';

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

Widget roundButton(BuildContext context, Function func, String text) {
  return GestureDetector(
    onTap: () {
      func();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          width: 2.0,
        ),
      ),
      width: 300,
      height: 50.0,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget smallRoundButton(BuildContext context, Function func, String text) {
  return GestureDetector(
    onTap: () {
      func();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          width: 2.0,
        ),
      ),
      width: 140,
      height: 50.0,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget funcButton(
    BuildContext context, String text, IconData icon, void Function() func) {
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
