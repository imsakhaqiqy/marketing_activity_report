import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Report/disbursment_marketing_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_marketing_sl_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportMarketingSlScreen extends StatefulWidget {
  @override
  _ReportMarketingSlScreen createState() => _ReportMarketingSlScreen();

  String nik;

  ReportMarketingSlScreen(this.nik);
}

class _ReportMarketingSlScreen extends State<ReportMarketingSlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Marketing',
          style: fontFamily,
        ),
        actions: <Widget>[],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ReportMarketingSlProvider>(context, listen: false)
                  .getMarketingSlReport(ReportMarketingSlItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future:
                  Provider.of<ReportMarketingSlProvider>(context, listen: false)
                      .getMarketingSlReport(ReportMarketingSlItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<ReportMarketingSlProvider>(
                  builder: (context, data, _) {
                    print(data.dataMarketingSlReport.length);
                    if (data.dataMarketingSlReport.length == 0) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.hourglass_empty, size: 50),
                                title: Text(
                                  'DATA TIDAK DITEMUKAN',
                                  style: TextStyle(
                                      fontFamily: "Montserrat Regular",
                                      fontSize: 14,
                                      color: Color.fromRGBO(63, 63, 63, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(''),
                              ),
                            ]),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.dataMarketingSlReport.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DisbursmentMarketingScreen(
                                                '',
                                                data.dataMarketingSlReport[i]
                                                    .nik)));
                              },
                              child: ListTile(
                                title: Text(
                                    '${data.dataMarketingSlReport[i].nama}'),
                                subtitle: Text(
                                  'JOIN : ${data.dataMarketingSlReport[i].joinDate} - ${data.dataMarketingSlReport[i].jabatan}',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Montserrat Regular'),
                                ),
                                trailing: gender(
                                    data.dataMarketingSlReport[i].jenisKelamin),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          )),
    );
  }

  gender(String a) {
    if (a == '0') {
      return new Icon(
        MdiIcons.humanMale,
        color: Colors.lightBlue,
        size: 30.0,
      );
    } else {
      return new Icon(
        MdiIcons.humanFemale,
        color: Colors.redAccent,
        size: 30.0,
      );
    }
  }
}
