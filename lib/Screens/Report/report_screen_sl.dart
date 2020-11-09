import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Report/interaction.dart';
import 'package:kreditpensiun_apps/Screens/Report/disbursment.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_disbursment_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_interaction_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_marketing_sl_screen.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportScreenSl extends StatefulWidget {
  @override
  _ReportScreenSl createState() => _ReportScreenSl();

  String username;
  String nik;

  ReportScreenSl(this.username, this.nik);
}

class _ReportScreenSl extends State<ReportScreenSl> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold);
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
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportInteractionSlScreen(
                                  widget.nik, tgl1, tgl2)));
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.directions_run,
                                size: 50, color: Colors.white),
                            title: Text(
                              'INTERAKSI',
                              style: cardTextStyle,
                            ),
                            subtitle: Text(''),
                          ),
                        ]),
                  )),
              Card(
                color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportDisbursmentSlScreen(
                                widget.nik, tgl1, tgl2)));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.note,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text(
                        'PENCAIRAN',
                        style: cardTextStyle,
                      ),
                      subtitle: Text(''),
                    ),
                  ]),
                ),
              ),
              Card(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReportMarketingSlScreen(widget.nik)));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.people_outline,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text(
                        'MARKETING',
                        style: cardTextStyle,
                      ),
                      subtitle: Text(''),
                    ),
                  ]),
                ),
              )
            ],
          )),
    );
  }
}
