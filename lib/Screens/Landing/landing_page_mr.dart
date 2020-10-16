import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Aplikasi/aplikasi_screen.dart';
import 'package:kreditpensiun_apps/Screens/Approval/approval_screen.dart';
import 'package:kreditpensiun_apps/Screens/Home/home_screen.dart';
import 'package:kreditpensiun_apps/Screens/Account/account_screen.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class LandingMrScreen extends StatefulWidget {
  @override
  _LandingMrScreenState createState() => new _LandingMrScreenState();
  String username;
  String nik;
  int income;
  String fotoProfil;
  String divisi;
  String greeting;
  String hakAkses;
  List personalData;
  String tarif;
  LandingMrScreen(this.username, this.nik, this.income, this.fotoProfil,
      this.divisi, this.greeting, this.hakAkses, this.personalData, this.tarif);
}

class _LandingMrScreenState extends State<LandingMrScreen> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [];
  @override
  Widget build(BuildContext context) {
    print(widget.income.toString());
    _container = [
      new HomeScreen(widget.username, widget.nik, widget.income,
          widget.greeting, widget.hakAkses, widget.personalData[0]),
      new AplikasiScreen(),
      new AccountScreen(widget.username, widget.fotoProfil, widget.divisi,
          widget.personalData, widget.nik, widget.tarif, widget.hakAkses),
    ];
    return new Scaffold(
      body: _container.elementAt(_bottomNavCurrentIndex),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        print(index);
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.home, color: kPrimaryColor),
            icon: new Icon(Icons.home, color: Colors.grey),
            title: new Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Montserrat Regular',
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.apps, color: kPrimaryColor),
            icon: new Icon(Icons.apps, color: Colors.grey),
            title: new Text(
              'Pinjaman',
              style: TextStyle(
                fontFamily: 'Montserrat Regular',
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: new Icon(Icons.settings, color: kPrimaryColor),
            icon: new Icon(Icons.account_circle, color: Colors.grey),
            title: new Text(
              'Account',
              style: TextStyle(
                fontFamily: 'Montserrat Regular',
              ),
            )),
      ],
    );
  }
}
