import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../controllers/home_screen_controller.dart';
import 'meine_widgets_screen.dart';
import 'profile_screen.dart';
import 'quick_links_screen.dart';
import 'widgets/group_widgets/popups.dart';
import 'widgets/toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isMeineWidgetsVisible = true;
  final HomeScreenController _controller = HomeScreenController();

  void onToggle(bool isMeineWidgetsSelected) {
    setState(() {
      isMeineWidgetsVisible = isMeineWidgetsSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Aktuelle User-date aus Firebase
    var currentUser = FirebaseAuth.instance.currentUser;
    var username = currentUser?.displayName;

    return Scaffold(
      body: Stack(children: [
        AppColors.getFhwaveBlueGradientContainer(context),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 250.0,
              backgroundColor: AppColors.transparent,
              shadowColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const BlurredDialog();
                                  },
                                );
                              },
                              child: Image.asset(
                                "assets/fhwave-loading-weiss-schwarz.gif",
                                gaplessPlayback: true,
                                width: 70.0,
                              )),
                          // SvgPicture.asset(
                          //   'assets/fhwave_logo_weiss.svg',
                          //   width: 70,
                          // ),

                          ClipOval(
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              color: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.account_circle_outlined),
                                color: Colors.black,
                                onPressed: () => _showBottomSheet(context),
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text('${_controller.greeting}, \n$username!',
                          style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w800,
                              color: _controller.fontColor)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(_controller.motivatingWords,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 55.0,
                maxHeight: 0.0,
                child: Center(child: ToggleButton(onToggle: onToggle)),
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 25,
                  ),
                  Visibility(
                    visible: isMeineWidgetsVisible,
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
                      meineWidgetsScreen(context)
                    ]),
                  ),
                  Visibility(
                    visible: !isMeineWidgetsVisible,
                    child: quickLinksScreen(context),
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 2.7 / 5,
            child: const ProfileScreen()),
      );
    },
  );
}
