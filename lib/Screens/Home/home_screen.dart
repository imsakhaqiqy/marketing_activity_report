import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:kreditpensiun_apps/Screens/Home/app_bar.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/Modul/modul_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_screen_rsl.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_screen_sl.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  String username;
  String nik;
  int income;
  String greeting;
  String hakAkses;
  String nikSdm;
  String statusKaryawan;
  int diamond;

  HomeScreen(this.username, this.nik, this.income, this.greeting, this.hakAkses,
      this.nikSdm, this.statusKaryawan, this.diamond);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GetConnect(); // calls getconnect method to check which type if connection it
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarsytAppBar(widget.income, widget.nik, widget.diamond, context),
      backgroundColor: grey,
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Center(
                              child: Text(
                                  "${widget.greeting}, ${widget.username}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto-Regular',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey)))),
                      Container(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Center(
                              child: Text(
                                  "Selamat bekerja, tetap jaga kesehatan ya ...",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Roboto-Regular',
                                      color: Colors.blueGrey)))),
                      Container(
                        child: Expanded(
                            child: GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          primary: false,
                          crossAxisCount: 2,
                          children: <Widget>[
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        MdiIcons.database,
                                        size: 80,
                                        color: Colors.blueGrey,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Database',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.blueGrey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlanningScreen(
                                            widget.username, widget.nik)));
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(MdiIcons.human,
                                          size: 80, color: Colors.blueGrey),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Interaksi',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Roboto-Regular',
                                                    color: Colors.blueGrey),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlanningInteractionScreen(
                                                widget.username,
                                                widget.nik,
                                                widget.hakAkses)));
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(MdiIcons.bank,
                                          size: 80, color: Colors.blueGrey),
                                      Expanded(
                                        child: Text(
                                          'Pencairan',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.blueGrey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DisbursmentScreen(
                                            widget.username,
                                            widget.nik,
                                            widget.statusKaryawan)));
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(MdiIcons.calculator,
                                          size: 80, color: Colors.blueGrey),
                                      Expanded(
                                        child: Text(
                                          'Simulasi',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.blueGrey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SimulationViewScreen(widget.nik)));
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.report_outlined,
                                          size: 80, color: Colors.blueGrey),
                                      Expanded(
                                        child: Text(
                                          'Laporan',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.blueGrey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (widget.hakAkses == '5') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportScreenSl(
                                              widget.username, widget.nikSdm)));
                                } else if (widget.hakAkses == '90') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportScreenRsl(
                                              widget.username, widget.nikSdm)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportScreen(
                                              widget.username, widget.nik)));
                                }
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(MdiIcons.fileDocumentBoxOutline,
                                          size: 80, color: Colors.blueGrey),
                                      Expanded(
                                        child: Text(
                                          'Berita',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.blueGrey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ModulScreen()));
                              },
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          // ignore: missing_return
          onWillPop: () async {
            Future.value(false);
          }),
    );
  }
}
