import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TransparentAppbar extends StatelessWidget {
  TransparentAppbar({super.key, required this.heading, required this.route});

  String route;
  String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const SizedBox(
              width: 22,
            ),
            GestureDetector(
              child: const Icon(Icons.arrow_back_ios_new_rounded),
              onTap: () {
                Navigator.pop(context, route);
              },
            ),
            const SizedBox(width: 12),
            Text(
              heading,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    );
  }
}
