import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Report/interaction.dart';
import 'package:kreditpensiun_apps/Screens/Report/disbursment.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportScreen extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();

  String username;
  String nik;

  ReportScreen(this.username, this.nik);
}

class _ReportScreen extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    var date = new DateTime.now();
    String bulan = date.month.toString();
    if (bulan.length == 1) {
      bulan = '0' + bulan.toString();
    } else {
      bulan = bulan.toString();
    }
    print(bulan);
    String tgl1 = date.year.toString() + '-' + bulan + '-' + '01';
    String tgl2 = date.year.toString() + '-' + bulan + '-' + '31';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan',
          style: fontFamily,
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportInteractionScreen(
                                  widget.nik, tgl1, tgl2)));
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.directions_run,
                                size: 50, color: kPrimaryColor),
                            title: Text(
                              'INTERAKSI',
                              style: cardTextStyle,
                            ),
                            subtitle: Text(''),
                          ),
                        ]),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportDisbursmentScreen(
                                  widget.nik, tgl1, tgl2)));
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.note,
                              size: 50,
                              color: kPrimaryColor,
                            ),
                            title: Text(
                              'PENCAIRAN',
                              style: cardTextStyle,
                            ),
                            subtitle: Text(''),
                          ),
                        ]),
                  ))
            ],
          )),
    );
  }
}
