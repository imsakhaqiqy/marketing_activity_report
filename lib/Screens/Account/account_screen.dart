import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Help/help_screen.dart';
import 'package:kreditpensiun_apps/Screens/Login/login_screen.dart';
import 'package:kreditpensiun_apps/Screens/Modul/modul_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/personal_data_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/profile_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/slip_gaji_screen.dart';
import 'package:kreditpensiun_apps/Screens/Version/version_screen.dart';
import 'package:kreditpensiun_apps/Screens/Voucher/voucher_screen.dart';

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

  AccountScreen(this.username, this.fotoProfil, this.divisi, this.personalData,
      this.nik, this.tarif, this.hakAkses);
}

class _SettingScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
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
                                            '${widget.divisi}',
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
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'PROFIL',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                              Icon(Icons.event_note,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'SLIP GAJI',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                                ModulScreen()));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.library_books,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'DOCUMENTS',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                                PipelineScreen(widget.username,
                                                    widget.nik)));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.linear_scale,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'PIPELINE',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                    print(widget.personalData[24]);
                                    if (widget.personalData[24] ==
                                        'MARKETING AGEN') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VoucherScreen(
                                                      widget.username,
                                                      widget.nik,
                                                      widget.tarif)));
                                    } else {
                                      showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                              'Maaf fitur ini hanya untuk marketing agent...'),
                                          actions: <Widget>[],
                                        ),
                                      );
                                    }
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.attach_money,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'VOUCHER',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                              Icon(Icons.help,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'BANTUAN',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
                                      child: AlertDialog(
                                        title: Text(
                                            'Apakah Anda ingin keluar dari aplikasi ini ?'),
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
                                              Icon(Icons.exit_to_app,
                                                  color: Colors.black87),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'LOGOUT',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                      color: Colors.black87,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black87,
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
