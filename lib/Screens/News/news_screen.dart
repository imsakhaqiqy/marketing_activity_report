import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditpensiun_apps/constants.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'Berita',
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            color: grey,
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.new_releases_outlined, size: 70),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Baca Berita Yuk!',
                  style: TextStyle(
                      fontFamily: "Montserrat Regular",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dapatkan informasi terkini dari kantor pusat.',
                  style: TextStyle(
                    fontFamily: "Montserrat Regular",
                    fontSize: 12,
                  ),
                ),
              ]),
            )));
  }
}
