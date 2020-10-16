import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:kreditpensiun_apps/Screens/Help/help_screen.dart';
import 'package:kreditpensiun_apps/Screens/Home/app_bar.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/not_aktif_screen.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/News/news_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_provider.dart';
import 'package:provider/provider.dart';

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

  HomeScreen(this.username, this.nik, this.income, this.greeting, this.hakAkses,
      this.nikSdm);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GetConnect(); // calls getconnect method to check which type if connection it
  }

  Widget build(BuildContext context) {
    //to get size
    Notif() {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Apakah Anda ingin keluar dari aplikasi ini ?'),
          //content: Text('We hate to see you leave...'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print("you choose no");
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    setState(() {
      //Notif();
    });

    //style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.blueGrey);

    return Scaffold(
      appBar: MarsytAppBar(widget.income, widget.nik, context),
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
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Center(
                              child: Text(
                                  "${widget.greeting}, ${widget.username}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Montserrat Regular',
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
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu8.png')
                                ],
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
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu1.png')
                                ],
                              ),
                              onTap: () {
                                if (widget.hakAkses == '14' ||
                                    widget.hakAkses == '5') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlanningInteractionScreen(
                                                  widget.username,
                                                  widget.nik,
                                                  widget.hakAkses)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotAktiInteractionScreen()));
                                }
                              },
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu2.png')
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DisbursmentScreen(
                                            widget.username, widget.nik)));
                              },
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu3.png')
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SimulationScreen()));
                              },
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu4.png')
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReportScreen(
                                            widget.username, widget.nik)));
                              },
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Image.asset('assets/menus/menu5.png')
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsScreen()));
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
