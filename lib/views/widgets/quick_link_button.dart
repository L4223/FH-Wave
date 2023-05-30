import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/quick_link_button_controller.dart';

/// A button for Quicklink
class QuickLinkButton extends StatelessWidget {
  final QuickLinkButtonController _controller = QuickLinkButtonController();
  final String title;
  final IconData icon;
  final String targetURL;

  late final Uri quicklinkURL;

  QuickLinkButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.targetURL,
  }) : super(key: key);

  void _launchURL(String targetURL) async {
    quicklinkURL = Uri.parse(targetURL);
    try {
      if (!await canLaunchUrl(quicklinkURL)) {
        await launchUrl(quicklinkURL);
      }
    } catch (e) {
      ///print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.95;
    const height = 50.0;

    return GestureDetector(
      onTap: () => _launchURL(targetURL),
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
