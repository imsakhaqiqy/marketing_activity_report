import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/filter_disbursment_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_disbursment_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_disbursment_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_disbursment_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../constants.dart';
import 'filter_disbursment_screen.dart';

// ignore: must_be_immutable
class ReportDisbursmentSlScreen extends StatefulWidget {
  @override
  _ReportDisbursmentSlScreen createState() => _ReportDisbursmentSlScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportDisbursmentSlScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportDisbursmentSlScreen extends State<ReportDisbursmentSlScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.nik);
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 13,
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
          'Laporan Pencairan',
          style: fontFamily,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FilterDisbursmentSlScreen(widget.nik)));
                },
                child: Icon(Icons.filter_list),
              )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ReportDisbursmentSlProvider>(context, listen: false)
                  .getDisbursmentSlReport(ReportDisbursmentSlItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<ReportDisbursmentSlProvider>(context,
                      listen: false)
                  .getDisbursmentSlReport(ReportDisbursmentSlItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<ReportDisbursmentSlProvider>(
                  builder: (context, data, _) {
                    print(data.dataDisbursmentSlReport.length);
                    if (data.dataDisbursmentSlReport.length == 0) {
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
                                'Pencairan Tidak Ditemukan!',
                                style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      );
                    } else {
                      return GridView.builder(
                          itemCount: data.dataDisbursmentSlReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataDisbursmentSlReport[i].debitur.length >
                                15) {
                              calonDebitur = data
                                  .dataDisbursmentSlReport[i].debitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur =
                                  data.dataDisbursmentSlReport[i].debitur;
                            }

                            if (data.dataDisbursmentSlReport[i].plafond != '') {
                              if (data.dataDisbursmentSlReport[i].plafond
                                      .length >
                                  15) {
                                rencanaPinjaman = data
                                    .dataDisbursmentSlReport[i].plafond
                                    .substring(0, 15);
                              } else {
                                rencanaPinjaman =
                                    data.dataDisbursmentSlReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
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
                                          DisbursmentViewScreen(
                                              data.dataDisbursmentSlReport[i]
                                                  .debitur,
                                              data.dataDisbursmentSlReport[i]
                                                  .alamat,
                                              data.dataDisbursmentSlReport[i]
                                                  .telepon,
                                              data.dataDisbursmentSlReport[i]
                                                  .tanggalAkad,
                                              data.dataDisbursmentSlReport[i]
                                                  .nomorAkad,
                                              data.dataDisbursmentSlReport[i]
                                                  .noJanji,
                                              data.dataDisbursmentSlReport[i]
                                                  .plafond,
                                              data.dataDisbursmentSlReport[i]
                                                  .jenisPencairan,
                                              data.dataDisbursmentSlReport[i]
                                                  .jenisProduk,
                                              data.dataDisbursmentSlReport[i]
                                                  .cabang,
                                              data.dataDisbursmentSlReport[i]
                                                  .infoSales,
                                              data.dataDisbursmentSlReport[i]
                                                  .foto1,
                                              data.dataDisbursmentSlReport[i]
                                                  .foto2,
                                              data.dataDisbursmentSlReport[i]
                                                  .foto3,
                                              data.dataDisbursmentSlReport[i]
                                                  .tanggalPencairan,
                                              data.dataDisbursmentSlReport[i]
                                                  .jamPencairan,
                                              data.dataDisbursmentSlReport[i]
                                                  .namaTl,
                                              data.dataDisbursmentSlReport[i]
                                                  .jabatanTl,
                                              data.dataDisbursmentSlReport[i]
                                                  .teleponTl,
                                              data.dataDisbursmentSlReport[i]
                                                  .namaSales)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.network(
                                          'https://www.nabasa.co.id/marsit/${data.dataDisbursmentSlReport[i].foto1}',
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
                                            '${formatRupiah(rencanaPinjaman)}',
                                            style: cardTextStyleChild,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataDisbursmentSlReport[i].tanggalPencairan}',
                                            style: cardTextStyleFooter1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_outline,
                                                color: kPrimaryColor),
                                            Expanded(
                                              child: Text(
                                                '${data.dataDisbursmentSlReport[i].namaSales}',
                                                style: cardTextStyleFooter2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
