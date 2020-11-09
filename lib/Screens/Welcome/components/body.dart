import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Login/login_screen.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_container_screen.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_screen.dart';
import 'package:kreditpensiun_apps/Screens/Welcome/components/background.dart';
import 'package:kreditpensiun_apps/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final _links = ['https://camellabs.com'];
  final String url =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getVersion';
  String versionId;
  String versionIdApp = '1.0.11';

  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAppVersion();
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
    print(versionId);
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
                  if (versionIdApp != versionId) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text(
                            'Versi aplikasi anda belum diupdate, mohon untuk melakukan update terlebih dahulu di playstore...'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                              SystemNavigator.pop();
                            },
                            child: Text('Ya'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  }
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
                        'INGIN MENJADI AGEN , DAFTAR DISINI YA',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat Regular'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: Text(
                      'V.' + versionId,
                      style: TextStyle(
                          color: Colors.grey, fontFamily: 'Montserrat Regular'),
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
}
