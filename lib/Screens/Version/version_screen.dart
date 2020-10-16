import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class VersionScreen extends StatefulWidget {
  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Versi Aplikasi',
              style: TextStyle(fontFamily: 'Montserrat Regular'),
            ),
          ),
          body: Container(
              color: Color.fromARGB(255, 242, 242, 242),
              child: Column(
                children: <Widget>[
                  osField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  versionNameField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  versionCodeField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  appIdField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  appNameField(),
                ],
              ))),
    );
  }

  Widget osField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'OS VERSI',
                  style: TextStyle(
                      fontFamily: 'Montserrat Regular', color: Colors.blueGrey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    getVersionNumber().toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                        color: Colors.blueGrey),
                  ))),
        ],
      ),
    );
  }

  Widget versionNameField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NAMA VERSI',
                  style: TextStyle(
                      fontFamily: 'Montserrat Regular', color: Colors.blueGrey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                        color: Colors.blueGrey),
                  ))),
        ],
      ),
    );
  }

  Widget versionCodeField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'KODE VERSI',
                  style: TextStyle(
                      fontFamily: 'Montserrat Regular', color: Colors.blueGrey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                        color: Colors.blueGrey),
                  ))),
        ],
      ),
    );
  }

  Widget appIdField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'ID APLIKASI',
                  style: TextStyle(
                      fontFamily: 'Montserrat Regular', color: Colors.blueGrey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                        color: Colors.blueGrey),
                  ))),
        ],
      ),
    );
  }

  Widget appNameField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'NAMA APLIKASI',
                  style: TextStyle(
                      fontFamily: 'Montserrat Regular', color: Colors.blueGrey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                        color: Colors.blueGrey),
                  ))),
        ],
      ),
    );
  }
}
