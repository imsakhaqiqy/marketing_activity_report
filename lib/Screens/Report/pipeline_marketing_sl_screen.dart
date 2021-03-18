import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_edit.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_submit.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PipelineMarketingScreen extends StatefulWidget {
  @override
  _PipelineMarketingScreen createState() => _PipelineMarketingScreen();

  String username;
  String nik;
  String nama;

  PipelineMarketingScreen(this.username, this.nik, this.nama);
}

class _PipelineMarketingScreen extends State<PipelineMarketingScreen> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pipeline - ' + widget.nama,
            style: fontFamily,
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () =>
                Provider.of<PipelineProvider>(context, listen: false)
                    .getPipeline(PipelineItem(widget.nik)),
            color: Colors.red,
            child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                    future:
                        Provider.of<PipelineProvider>(context, listen: false)
                            .getPipeline(PipelineItem(widget.nik)),
                    builder: (context, snapshot) {
                      if (snapshot.data == null &&
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                        );
                      } else if (snapshot.data == null) {
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
                                      child:
                                          Icon(Icons.hourglass_empty, size: 70),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Buat Pipeline Yuk!',
                                  style: TextStyle(
                                      fontFamily: "Montserrat Regular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Dapatkan insentif besar dari pencairanmu.',
                                  style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                        );
                      } else {
                        return Consumer<PipelineProvider>(
                            builder: (context, data, _) {
                          print(data.dataPipeline.length);
                          if (data.dataPipeline.length == 0) {
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
                                          child: Icon(Icons.hourglass_empty,
                                              size: 70),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Buat Pipeline Yuk!',
                                      style: TextStyle(
                                          fontFamily: "Montserrat Regular",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Dapatkan insentif besar dari pencairanmu.',
                                      style: TextStyle(
                                        fontFamily: "Montserrat Regular",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data.dataPipeline.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: Colors.grey,
                                      ))),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PipelineViewScreen(
                                                        data.dataPipeline[i]
                                                            .namaNasabah,
                                                        data.dataPipeline[i]
                                                            .tglPipeline,
                                                        data.dataPipeline[i]
                                                            .alamat,
                                                        data.dataPipeline[i]
                                                            .telepon,
                                                        data.dataPipeline[i]
                                                            .jenisProduk,
                                                        data.dataPipeline[i]
                                                            .plafond,
                                                        data.dataPipeline[i]
                                                            .cabang,
                                                        data.dataPipeline[i]
                                                            .keterangan,
                                                        data.dataPipeline[i]
                                                            .status,
                                                        data.dataPipeline[i]
                                                            .tempatLahir,
                                                        data.dataPipeline[i]
                                                            .tanggalLahir,
                                                        data.dataPipeline[i]
                                                            .jenisKelamin,
                                                        data.dataPipeline[i]
                                                            .noKtp,
                                                        data.dataPipeline[i]
                                                            .npwp,
                                                        data.dataPipeline[i]
                                                            .statusKredit,
                                                        data.dataPipeline[i]
                                                            .pengelolaPensiun,
                                                        data.dataPipeline[i]
                                                            .bankTakeover,
                                                        data.dataPipeline[i]
                                                            .foto1,
                                                        data.dataPipeline[i]
                                                            .foto2,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: ListTile(
                                            title: Row(children: [
                                              Tooltip(
                                                message: messageStatus(
                                                    '${data.dataPipeline[i].status}'),
                                                child: Icon(
                                                  iconStatus(
                                                      '${data.dataPipeline[i].status}'),
                                                  color: colorStatus(
                                                      '${data.dataPipeline[i].status}'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                data.dataPipeline[i]
                                                    .namaNasabah,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Montserrat Regular'),
                                              ),
                                            ]),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.teal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          'Plafond',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat Regular',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${formatRupiah(data.dataPipeline[i].plafond)}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat Regular'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            trailing: Text(
                                              '${data.dataPipeline[i].tglPipeline}',
                                              style: fontFamily,
                                            ),
                                          ),
                                        ),
                                      ));
                                });
                          }
                        });
                      }
                    }))));
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Belum Pencairan';
    } else if (status == '2') {
      return 'Sudah Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    }
  }

  iconStatus(String status) {
    if (status == '1') {
      return Icons.info;
    } else if (status == '2') {
      return Icons.check;
    } else if (status == '3') {
      return Icons.send;
    } else if (status == '4') {
      return Icons.date_range;
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.orangeAccent;
    } else if (status == '2') {
      return Colors.greenAccent;
    } else if (status == '3') {
      return Colors.blueAccent;
    } else if (status == '4') {
      return Colors.blueAccent;
    }
  }

  namaBulan(String bulan) {
    switch (bulan) {
      case '1':
        return 'Januari';
        break;
      case '2':
        return 'Februari';
        break;
      case '3':
        return 'Maret';
        break;
      case '4':
        return 'April';
        break;
      case '5':
        return 'Mei';
        break;
      case '6':
        return 'Juni';
        break;
      case '7':
        return 'Juli';
        break;
      case '8':
        return 'Agustus';
        break;
      case '9':
        return 'September';
        break;
      case '10':
        return 'Oktober';
        break;
      case '11':
        return 'November';
        break;
      case '12':
        return 'Desember';
        break;
    }
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

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat Regular', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Montserrat Regular',
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
