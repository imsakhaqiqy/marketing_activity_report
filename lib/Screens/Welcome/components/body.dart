import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Login/login_screen.dart';
import 'package:kreditpensiun_apps/Screens/Mitra/mitra_screen.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_screen.dart';
import 'package:kreditpensiun_apps/Screens/Welcome/components/background.dart';
import 'package:kreditpensiun_apps/components/rounded_button.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String latitudeData = "";
  String longitudeData = "";

  final String url =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getVersion';
  String versionId;
  String versionIdApp = '1.0.23';

  String title = "title";
  String content = "content";

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = '';
  String _currentLatitude = '';
  String _currentLongitude = '';

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        _currentLatitude = "${place.position.latitude}";
        _currentLongitude = "${place.position.longitude}";
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAppVersion();
    _getCurrentLocation();
    WidgetsFlutterBinding.ensureInitialized();
    OneSignal.shared
        .init("3146f435-b89d-4004-9db7-8d778386075e", iOSSettings: null);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        title = notification.payload.title;
        title = notification.payload.body;
      });
    });
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult notification) {
      print("notifikasi di tap");
    });
  }

  Future<String> getAppVersion() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body)['Daftar_Version'];
      setState(() {
        versionId = resBody[0]['version_id'];
      });
    }
  }

  Widget build(BuildContext context) {
    print(_currentAddress);
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    if (versionId == null) {
      return Background(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      );
    } else {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "iMarsyt - Marketing Report System",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto-Regular',
                    color: Colors.white),
              ),
              SizedBox(height: size.height * 0.05),
              Image.asset(
                "assets/images/MARKETING-01.png",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "MASUK",
                color: Colors.white,
                textColor: kPrimaryColor,
                press: () {
                  if (versionIdApp != versionId) {
                    Toast.show(
                      'Versi aplikasi anda belum diupdate, mohon untuk melakukan update terlebih dahulu di playstore...',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen(_currentAddress, _currentLatitude,
                              _currentLongitude);
                        },
                      ),
                    );
                  }
                },
              ),
              RaisedButton(
                color: grey,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text(
                  'DAFTAR',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      fontFamily: 'Roboto-Regular'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: Text(
                      'v ' + versionIdApp,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Roboto-Regular'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        color: kPrimaryColor,
      );
    }
  }
}
