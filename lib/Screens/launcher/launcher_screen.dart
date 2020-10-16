import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Welcome/welcome_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class LauncherScreen extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: AnimatedSplashScreen(
      splash: Image.asset('assets/logo.png'),
      nextScreen: WelcomeScreen(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: grey200,
      duration: 3000,
    ));
  }
}
