import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/constants.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          title: Text(
            'DOKUMEN',
            style: TextStyle(fontFamily: 'Roboto-Regular'),
          ),
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Text('DOKUMEN'),
            ],
          ),
        ),
      ),
    );
  }
}
