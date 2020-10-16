import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditpensiun_apps/constants.dart';

class AplikasiScreen extends StatefulWidget {
  @override
  _AplikasiScreenState createState() => _AplikasiScreenState();
}

class _AplikasiScreenState extends State<AplikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Center(
              child: Text(
                'Pinjaman',
                style: TextStyle(
                  fontFamily: 'Montserrat Regular',
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false),
        body: WillPopScope(
            child: Container(
                color: grey,
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SvgPicture.asset(
                        'assets/undraw_transfer_money_rywa.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Kamu dapat menemukan pinjaman kredit disini",
                              style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.2,
                                  fontSize: 16.0,
                                  height: 2.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            onWillPop: () async {
              Future.value(false);
            }));
  }
}
