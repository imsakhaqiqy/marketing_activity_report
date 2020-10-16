import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class PipelineScreen extends StatefulWidget {
  @override
  _PipelineScreen createState() => _PipelineScreen();

  String username;
  String nik;

  PipelineScreen(this.username, this.nik);
}

class _PipelineScreen extends State<PipelineScreen> {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.white);
    var cardTextStyle1 = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.grey);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pipeline',
          style: fontFamily,
        ),
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () => Provider.of<PipelineProvider>(context, listen: false)
              .getPipeline(PipelineItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<PipelineProvider>(context, listen: false)
                  .getPipeline(PipelineItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<PipelineProvider>(
                  builder: (context, data, _) {
                    print(data.dataPipeline.length);
                    if (data.dataPipeline.length == 0) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.hourglass_empty,
                                  size: 50,
                                ),
                                title: Text(
                                  'PIPELINE TIDAK DITEMUKAN',
                                  style: cardTextStyle1,
                                ),
                                subtitle: Text(''),
                              ),
                            ]),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Card(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.linear_scale,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      'PIPELINE PERIODE $bulan $tahun',
                                      style: cardTextStyle,
                                    ),
                                    subtitle: Text(
                                      'Selamat bekerja, sukses selalu',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data.dataPipeline.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                      elevation: 4,
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
                                                              .status)));
                                        },
                                        child: ListTile(
                                          title: Row(
                                            children: [
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
                                            ],
                                          ),
                                          subtitle: Text(
                                            'Plafond: ${formatRupiah(data.dataPipeline[i].plafond)}',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontFamily:
                                                    'Montserrat Regular'),
                                          ),
                                          trailing: Text(
                                            '${data.dataPipeline[i].tglPipeline}',
                                            style: fontFamily,
                                          ),
                                        ),
                                      ));
                                }),
                          )
                        ],
                      );
                    }
                  },
                );
              },
            ),
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Pipeline',
        backgroundColor: kPrimaryColor,
        child: Text('+',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PipelineAddScreen(widget.username, widget.nik)));
        },
      ),
    );
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Belum Pencairan';
    } else if (status == '2') {
      return 'Sudah Pencairan';
    }
  }

  iconStatus(String status) {
    if (status == '1') {
      return Icons.info;
    } else if (status == '2') {
      return Icons.check;
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.blue;
    } else if (status == '2') {
      return Colors.green;
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
}
