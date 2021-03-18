import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  String currentLocation;
  String currentLatitude;
  String currentLongitude;

  LoginScreen(
      this.currentLocation, this.currentLatitude, this.currentLongitude);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(
            this.currentLocation, this.currentLatitude, this.currentLongitude));
  }
}
