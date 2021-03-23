import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_add.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_add_new.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_edit.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_akad_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentAkadScreen extends StatefulWidget {
  @override
  _DisbursmentAkadScreen createState() => _DisbursmentAkadScreen();

  String username;
  String nik;

  DisbursmentAkadScreen(this.username, this.nik);
}

_showPopupMenu(
        String username,
        String nik,
        String idPipeline,
        String namaPensiun,
        String alamat,
        String telepon,
        String selectedJenisDebitur,
        String selectedJenisProduk,
        String tanggalAkad,
        String nomorAplikasi,
        String nomorPerjanjian,
        String selectedJenisCabang,
        String plafond,
        String selectedJenisInfo,
        String selectedStatusKredit,
        String namaPetugasBank,
        String jabatanPetugasBank,
        String teleponPetugasBank,
        String selectedPengelolaPensiun) =>
    PopupMenuButton<int>(
      padding: EdgeInsets.only(left: 2),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DisbursmentAddNewScreen(
                      username,
                      nik,
                      '',
                      namaPensiun,
                      alamat,
                      telepon,
                      selectedJenisDebitur,
                      selectedJenisProduk,
                      tanggalAkad,
                      nomorAplikasi,
                      nomorPerjanjian,
                      selectedJenisCabang,
                      plafond,
                      selectedJenisInfo,
                      selectedStatusKredit,
                      namaPetugasBank,
                      jabatanPetugasBank,
                      teleponPetugasBank,
                      selectedPengelolaPensiun,
                      idPipeline)));
            },
            child: Tooltip(
                message: 'Pencairan',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money_sharp,
                      color: Colors.teal,
                      size: 20,
                    ),
                    Text('Pencairan')
                  ],
                )),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 20),
    );

class _DisbursmentAkadScreen extends State<DisbursmentAkadScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle1 =
        TextStyle(fontFamily: "Montserrat Regular", fontSize: 14);
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Akad Kredit',
          style: fontFamily,
        ),
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<DisbursmentAkadProvider>(context, listen: false)
                  .getDisbursmentAkad(DisbursmentAkadItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future:
                  Provider.of<DisbursmentAkadProvider>(context, listen: false)
                      .getDisbursmentAkad(DisbursmentAkadItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<DisbursmentAkadProvider>(
                  builder: (context, data, _) {
                    print(data.dataDisbursmentAkad.length);
                    if (data.dataDisbursmentAkad.length == 0) {
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
                                'Akad Kredit Yuk!',
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
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton(
                                color: Colors.teal,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PipelineScreen(
                                              widget.username, widget.nik)));
                                },
                                child: Text(
                                  'Lihat Pipeline',
                                  style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data.dataDisbursmentAkad.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    elevation: 4,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text(
                                                data.dataDisbursmentAkad[i]
                                                    .debitur,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Montserrat Regular'),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Plafond',
                                                    child: Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${formatRupiah(data.dataDisbursmentAkad[i].nominalPinjaman)}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Tanggal Akad',
                                                    child: Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataDisbursmentAkad[i].tanggalAkad}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Nomor Aplikasi',
                                                    child: Icon(
                                                      Icons
                                                          .confirmation_number_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataDisbursmentAkad[i].nomorAplikasi}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              _showPopupMenu(
                                                widget.username,
                                                widget.nik,
                                                data.dataDisbursmentAkad[i]
                                                    .idPipeline,
                                                data.dataDisbursmentAkad[i]
                                                    .debitur,
                                                data.dataDisbursmentAkad[i]
                                                    .alamat,
                                                data.dataDisbursmentAkad[i]
                                                    .telepon,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedJenisDebitur,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedJenisProduk,
                                                data.dataDisbursmentAkad[i]
                                                    .tanggalAkad,
                                                data.dataDisbursmentAkad[i]
                                                    .nomorAplikasi,
                                                data.dataDisbursmentAkad[i]
                                                    .nomorPerjanjian,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedJenisCabang,
                                                data.dataDisbursmentAkad[i]
                                                    .nominalPinjaman,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedJenisInfo,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedStatusKredit,
                                                data.dataDisbursmentAkad[i]
                                                    .namaPetugasBank,
                                                data.dataDisbursmentAkad[i]
                                                    .jabatanPetugasBank,
                                                data.dataDisbursmentAkad[i]
                                                    .teleponPetugasBank,
                                                data.dataDisbursmentAkad[i]
                                                    .selectedPengelolaPensiun,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
