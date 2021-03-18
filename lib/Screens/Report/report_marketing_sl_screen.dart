import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Report/pipeline_marketing_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/disbursment_marketing_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_marketing_sl_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportMarketingSlScreen extends StatefulWidget {
  @override
  _ReportMarketingSlScreen createState() => _ReportMarketingSlScreen();

  String nik;

  ReportMarketingSlScreen(this.nik);
}

_showPopupMenu(String niksales, String nama) => PopupMenuButton<int>(
      padding: EdgeInsets.only(left: 2),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DisbursmentMarketingScreen('', niksales, nama)));
            },
            child: Tooltip(
                message: 'Pencairan',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment_outlined,
                      color: Colors.teal,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Pencairan')
                  ],
                )),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PipelineMarketingScreen('', niksales, nama)));
            },
            child: Tooltip(
                message: 'Pipeline',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.linear_scale,
                      color: Colors.teal,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Pipeline')
                  ],
                )),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 30),
    );

class _ReportMarketingSlScreen extends State<ReportMarketingSlScreen> {
  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void _createEmail({@required String email}) async {
    String emailaddress() {
      return 'mailto:$email?subject=Sample Subject&body=This is a Sample email';
    }

    if (await canLaunch(emailaddress())) {
      await launch(emailaddress());
    } else {
      throw 'Could not Email';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Tim Marketing',
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
                      return Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.hourglass_empty_outlined,
                                        size: 70),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tim Marketing Tidak Ditemukan!',
                                style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                        margin: EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              child: FlatButton(
                                                onPressed: () {
                                                  _createEmail(
                                                      email: data
                                                          .dataMarketingSlReport[
                                                              i]
                                                          .alamatEmail);
                                                },
                                                child: Icon(MdiIcons.email),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              child: FlatButton(
                                                onPressed: () {
                                                  String teleponFix = '+62' +
                                                      data
                                                          .dataMarketingSlReport[
                                                              i]
                                                          .noTelepon
                                                          .substring(1);
                                                  launchWhatsApp(
                                                      phone: teleponFix,
                                                      message: 'Tes');
                                                },
                                                child: Icon(MdiIcons.whatsapp),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              child: FlatButton(
                                                onPressed: () {
                                                  _makePhoneCall(
                                                      'tel:${data.dataMarketingSlReport[i].noTelepon}');
                                                },
                                                child: Icon(MdiIcons.phone),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                );
                              },
                              child: ListTile(
                                  leading: gender(data
                                      .dataMarketingSlReport[i].jenisKelamin),
                                  title: Text(
                                      '${data.dataMarketingSlReport[i].nama}'),
                                  subtitle: Text(
                                    'JOIN : ${data.dataMarketingSlReport[i].joinDate} - ${data.dataMarketingSlReport[i].jabatan}',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Montserrat Regular'),
                                  ),
                                  trailing: _showPopupMenu(
                                      data.dataMarketingSlReport[i].nik,
                                      data.dataMarketingSlReport[i].nama)),
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
