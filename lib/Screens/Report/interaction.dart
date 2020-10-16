import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../constants.dart';
import 'filter_interaction_screen.dart';

// ignore: must_be_immutable
class ReportInteractionScreen extends StatefulWidget {
  @override
  _ReportInteractionScreen createState() => _ReportInteractionScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportInteractionScreen extends State<ReportInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 13,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.bold);
    var cardTextStyleFooter1 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 12,
        color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyleFooter2 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 9,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Interaksi',
          style: fontFamily,
        ),
        actions: <Widget>[
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () async {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => ReportInteractionPdfScreen()));
          //       },
          //       child: Icon(
          //         Icons.picture_as_pdf,
          //         size: 26.0,
          //       ),
          //     )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FilterInteractionScreen(widget.nik)));
                },
                child: Icon(Icons.filter_list),
              )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ReportInteractionProvider>(context, listen: false)
                  .getInteractionReport(ReportInteractionItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future:
                  Provider.of<ReportInteractionProvider>(context, listen: false)
                      .getInteractionReport(ReportInteractionItem(
                          widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<ReportInteractionProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteractionReport.length);
                    if (data.dataInteractionReport.length == 0) {
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
                                  style: cardTextStyle,
                                ),
                                subtitle: Text(''),
                              ),
                            ]),
                      );
                    } else {
                      return GridView.builder(
                          itemCount: data.dataInteractionReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataInteractionReport[i].calonDebitur
                                    .length >
                                15) {
                              calonDebitur = data
                                  .dataInteractionReport[i].calonDebitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur =
                                  data.dataInteractionReport[i].calonDebitur;
                            }

                            if (data.dataInteractionReport[i].plafond != '') {
                              if (data.dataInteractionReport[i].plafond.length >
                                  15) {
                                rencanaPinjaman =
                                    data.dataInteractionReport[i].plafond;
                              } else {
                                rencanaPinjaman =
                                    data.dataInteractionReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
                            }

                            if (data.dataInteractionReport[i].alamat != '') {
                              if (data.dataInteractionReport[i].alamat.length >
                                  15) {
                                alamat = data.dataInteractionReport[i].alamat;
                              } else {
                                alamat = data.dataInteractionReport[i].alamat;
                              }
                            } else {
                              alamat = '';
                            }

                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          InteractionViewScreen(
                                              data.dataInteractionReport[i]
                                                  .calonDebitur,
                                              data.dataInteractionReport[i]
                                                  .alamat,
                                              data.dataInteractionReport[i]
                                                  .email,
                                              data.dataInteractionReport[i]
                                                  .telepon,
                                              data.dataInteractionReport[i]
                                                  .plafond,
                                              data.dataInteractionReport[i]
                                                  .salesFeedback,
                                              data.dataInteractionReport[i]
                                                  .foto,
                                              data.dataInteractionReport[i]
                                                  .tanggalInteraksi,
                                              data.dataInteractionReport[i]
                                                  .jamInteraksi,
                                              data.dataInteractionReport[i]
                                                  .statusInteraksi)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.network(
                                          'https://www.nabasa.co.id/marsit/${data.dataInteractionReport[i].foto}',
                                          fit: BoxFit.contain,
                                        ),
                                        height: 100.0,
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$calonDebitur',
                                            style: cardTextStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$rencanaPinjaman',
                                            style: cardTextStyleChild,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataInteractionReport[i].tanggalInteraksi}',
                                            style: cardTextStyleFooter1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: kPrimaryColor),
                                              Expanded(
                                                child: Text(
                                                  '$alamat',
                                                  style: cardTextStyleFooter2,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ]),
                              ),
                            );
                          });
                    }
                  },
                );
              },
            ),
          )),
    );
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }
}
