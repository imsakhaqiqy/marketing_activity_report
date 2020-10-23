import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Login/login_screen.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_container_screen.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_screen.dart';
import 'package:kreditpensiun_apps/Screens/Welcome/components/background.dart';
import 'package:kreditpensiun_apps/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditpensiun_apps/constants.dart';

class Body extends StatelessWidget {
  final _links = ['https://camellabs.com'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Marsit Reporting System",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat Regular',
                  color: Colors.black),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/welcome.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Masuk",
              color: green200,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Center(
                    child: Text(
                      'INGIN MENJADI AGEN , KLIK DISINI',
                      style: TextStyle(
                          color: Colors.grey, fontFamily: 'Montserrat Regular'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
