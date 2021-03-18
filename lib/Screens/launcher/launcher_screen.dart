import 'dart:async';

import 'package:flutter/material.dart';
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
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen(),
        ),
      ),
    );
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/images/imarsyt 2-03.png",
            width: size.height * 0.45,
          ),
        ),
      ),
    );
  }
}
