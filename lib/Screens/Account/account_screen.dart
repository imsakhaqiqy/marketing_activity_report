import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Help/help_screen.dart';
import 'package:kreditpensiun_apps/Screens/Modul/modul_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/profile_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/slip_gaji_screen.dart';
import 'package:kreditpensiun_apps/Screens/Redeem/redeem_screen.dart';
import 'package:kreditpensiun_apps/Screens/Utility/utility_screen.dart';
import 'package:kreditpensiun_apps/Screens/Voucher/voucher_screen.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();

  String username;
  String fotoProfil;
  String divisi;
  List personalData;
  String nik;
  String tarif;
  String hakAkses;
  int diamond;

  AccountScreen(this.username, this.fotoProfil, this.divisi, this.personalData,
      this.nik, this.tarif, this.hakAkses, this.diamond);
}

class _SettingScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.username);
    String foto = 'https://www.nabasa.co.id/marsit/' + widget.fotoProfil;
    print(foto);
    return SafeArea(
      child: Scaffold(
          //appBar: AppBar(automaticallyImplyLeading: false),
          body: WillPopScope(
              child: Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 82,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                          radius: 32,
                                          backgroundImage: NetworkImage(foto)),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${widget.username}',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat Medium',
                                                color: Colors.black87,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${widget.personalData[24]}',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat Medium',
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black87,
                                                fontSize: 10),
                                          ),
                                        ],
                                      )
                                    ])),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfileScreen(
                                                widget.personalData)));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.person,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Profil',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SlipGajiScreen()));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.notes_outlined,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Slip Gaji',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PipelineRootPage(
                                                    widget.username,
                                                    widget.nik)));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.linear_scale,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Pipeline',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      (widget.personalData[24] == 'MARKETING AGENT')
                          ? Container(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.black12,
                              ))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(left: 0.0),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VoucherScreen(
                                                          widget.username,
                                                          widget.nik,
                                                          widget.tarif)));
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                        Icons
                                                            .monetization_on_outlined,
                                                        color: Colors.black54),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        'Insentif',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat Regular',
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.chevron_right,
                                                color: Colors.black54,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(height: 0),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UtilityScreen()));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.accessible,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Bantuan',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    if (widget.tarif == '0.50') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RedeemScreen(
                                                      widget.username,
                                                      widget.nik,
                                                      widget.diamond)));
                                    } else {
                                      Toast.show(
                                        'Maaf fitur ini belum tersedia',
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.phone_android,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Tukar Pulsa',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HelpScreen()));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                  Icons
                                                      .question_answer_outlined,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'FAQ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 0.0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title:
                                            Text('Apakah Anda ingin keluar ?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              print("you choose no");
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Tidak'),
                                          ),
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
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.logout,
                                                  color: Colors.black54),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Keluar',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              onWillPop: () async {
                Future.value(false);
              })),
    );
  }
}
