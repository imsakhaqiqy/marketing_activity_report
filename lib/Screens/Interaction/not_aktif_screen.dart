import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/constants.dart';

class NotAktiInteractionScreen extends StatefulWidget {
  @override
  _NotAktiInteractionScreenState createState() =>
      _NotAktiInteractionScreenState();
}

class _NotAktiInteractionScreenState extends State<NotAktiInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interaksi',
          style: fontFamily,
        ),
      ),
      body: Container(
        color: grey,
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.directions_walk,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(
                      'MAAF, KAMU BELUM BISA MELAKUKAN INTERAKSI',
                      style: cardTextStyle,
                    ),
                    subtitle: Text(
                      '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
