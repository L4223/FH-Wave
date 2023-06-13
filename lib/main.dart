import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'controllers/dark_mode_controller.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';
import 'views/auth_screens/login_screen.dart';
import 'views/auth_screens/signup_screen.dart';
import 'views/calendar_screen.dart';
import 'views/group_screens/group_screen.dart';
import 'views/home_screen.dart';

dynamic screenSize;

UserController userController = UserController();
User? user = userController.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: "FH-Wave",
      options: DefaultFirebaseOptions.android);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkModeController>(
      create: (_) => DarkModeController(),
      child: Consumer<DarkModeController>(
        builder: (context, controller, _) {
          return MaterialApp(
            theme: ThemeData(
              brightness: controller.isDarkMode ?
              Brightness.dark : Brightness.light,
              fontFamily: 'Roboto',
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/group': (context) => const GroupsHome(),
              '/calendar': (context) => const CalendarScreen(),
            },
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Intro.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.play();
    });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _handleVideoPlaybackComplete();
      }
    });
  }

  void _handleVideoPlaybackComplete() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height /
                        _controller.value.aspectRatio,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
