import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Approval/approval_interaksi_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';

import 'approval_disbursment_root_screen.dart';

class ApprovalScreen extends StatefulWidget {
  String nikSdm;

  ApprovalScreen(this.nikSdm);
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Center(
              child: Text(
                'Approval',
                style: TextStyle(
                  fontFamily: 'Montserrat Regular',
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false),
        body: WillPopScope(
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Card(
                        color: Colors.blueAccent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ApprovalInteractionScreen(
                                            '', '', '', widget.nikSdm)));
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.verified_user,
                                      size: 50, color: Colors.white),
                                  title: Text(
                                    'APPROVAL INTERAKSI',
                                    style: cardTextStyle,
                                  ),
                                  subtitle: Text(''),
                                ),
                              ]),
                        )),
                    Card(
                        color: Colors.redAccent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ApprovalDisbursmentRootPage(
                                            '', '', widget.nikSdm)));
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.verified_user,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'APPROVAL PENCAIRAN',
                                    style: cardTextStyle,
                                  ),
                                  subtitle: Text(''),
                                ),
                              ]),
                        ))
                  ],
                )),
            onWillPop: () async {
              Future.value(false);
            }));
  }
}
