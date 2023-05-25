import 'package:flutter/material.dart';
import '../../controllers/quick_link_button_controller.dart';

///  Ein Button für Quicklink
class QuickLinkButton extends StatelessWidget {
  final QuickLinkButtonController _controller = QuickLinkButtonController();
  final String title;
  final IconData icon;
  final Widget targetPage;

  QuickLinkButton({
    super.key,
    required this.title,
    required this.icon,
    required this.targetPage,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.95;
    const height = 50.0;

    return GestureDetector(
      onTap: () => _controller.navigateToTargetPage(context, targetPage),
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
                  color: _controller.color,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _controller.color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
