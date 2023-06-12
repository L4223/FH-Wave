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
              width: 10,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            ),
            Text(
              heading,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
