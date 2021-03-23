import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_akad_screen.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_edit.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_edit_new.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentScreen extends StatefulWidget {
  @override
  _DisbursmentScreen createState() => _DisbursmentScreen();

  String username;
  String nik;
  String statusKaryawan;

  DisbursmentScreen(this.username, this.nik, this.statusKaryawan);
}

class _DisbursmentScreen extends State<DisbursmentScreen> {
  bool visible = false;

  Future deleteDisbursment(String id) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/tes.php/deleteDisbursment';
    var response = await http.post(url, body: {'id_disbursment': id});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Disbursment'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses delete pencairan',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete pencairan',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Pencairan',
          style: fontFamily,
        ),
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<DisbursmentProvider>(context, listen: false)
                  .getDisbursment(DisbursmentItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<DisbursmentProvider>(context, listen: false)
                  .getDisbursment(DisbursmentItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<DisbursmentProvider>(
                  builder: (context, data, _) {
                    print(data.dataDisbursment.length);
                    if (data.dataDisbursment.length == 0) {
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
                                'Pencairan Kredit Yuk!',
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DisbursmentAkadScreen(
                                              widget.username, widget.nik)));
                                },
                                child: Text(
                                  'Lihat Akad Kredit',
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
                                itemCount: data.dataDisbursment.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                      elevation: 4,
                                      child: GestureDetector(
                                        onHorizontalDragStart:
                                            (DragStartDetails details) {
                                          if ((widget.statusKaryawan !=
                                                      'MARKETING AGEN' &&
                                                  data.dataDisbursment[i]
                                                          .statusPencairan !=
                                                      'success') ||
                                              (widget.statusKaryawan ==
                                                      'MARKETING AGEN' &&
                                                  data.dataDisbursment[i]
                                                          .approvalSl !=
                                                      '4')) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisbursmentEditScreen(
                                                        widget.username,
                                                        widget.nik,
                                                        data.dataDisbursment[i]
                                                            .nomorAkad,
                                                        widget.statusKaryawan),
                                              ),
                                            );
                                          }
                                        },
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisbursmentViewScreen(
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .debitur,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .alamat,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .telepon,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .tanggalAkad,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .nomorAkad,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .noJanji,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .plafond,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .jenisPencairan,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .jenisProduk,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .cabang,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .infoSales,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .foto1,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .foto2,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .foto3,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .tanggalPencairan,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .jamPencairan,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .namaTl,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .jabatanTl,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .teleponTl,
                                                          data
                                                              .dataDisbursment[
                                                                  i]
                                                              .namaSales)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Tooltip(
                                                  message: messageStatus(
                                                      '${data.dataDisbursment[i].statusPencairan}',
                                                      widget.statusKaryawan,
                                                      '${data.dataDisbursment[i].approvalSl}'),
                                                  child: Icon(
                                                    iconStatus(
                                                        '${data.dataDisbursment[i].statusPencairan}',
                                                        widget.statusKaryawan,
                                                        '${data.dataDisbursment[i].approvalSl}'),
                                                    color: colorStatus(
                                                        '${data.dataDisbursment[i].statusPencairan}'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  data.dataDisbursment[i]
                                                      .debitur,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Montserrat Regular'),
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${formatRupiah(data.dataDisbursment[i].plafond)}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Montserrat Regular'),
                                                ),
                                                Text(
                                                  '${data.dataDisbursment[i].tanggalAkad}',
                                                  style: fontFamily,
                                                ),
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 12,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    if ((widget.statusKaryawan !=
                                                                'MARKETING AGEN' &&
                                                            data
                                                                    .dataDisbursment[
                                                                        i]
                                                                    .statusPencairan !=
                                                                'success') ||
                                                        (widget.statusKaryawan ==
                                                                'MARKETING AGEN' &&
                                                            data.dataDisbursment[i]
                                                                    .approvalSl !=
                                                                '4')) {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DisbursmentEditNewScreen(
                                                            widget.username,
                                                            widget.nik,
                                                            '',
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .debitur,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .alamat,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .telepon,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .tanggalAkad,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .jenisProduk,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .tanggalAkad,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .nomorAkad,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .noJanji,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .cabang,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .plafond,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .infoSales,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .statusKredit,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .namaTl,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .jabatanTl,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .teleponTl,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .pengelolaPensiun,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .idPipeline,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .tanggalPencairan,
                                                            data
                                                                .dataDisbursment[
                                                                    i]
                                                                .foto3,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      Toast.show(
                                                        'Pencairan sudah di approve, data tidak bisa di edit kembali',
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_SHORT,
                                                        gravity: Toast.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            'Apakah Anda ingin menghapus pencairan debitur ' +
                                                                data
                                                                    .dataDisbursment[
                                                                        i]
                                                                    .debitur +
                                                                ' ?'),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text('Tidak'),
                                                          ),
                                                          FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              deleteDisbursment(
                                                                data
                                                                    .dataDisbursment[
                                                                        i]
                                                                    .id,
                                                              );
                                                            },
                                                            child: Text('Ya'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                )
                                              ],
                                            ),
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
        tooltip: 'Tambah Pencairan',
        backgroundColor: kPrimaryColor,
        child: Text('+',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DisbursmentAkadScreen(widget.username, widget.nik)));
        },
      ),
    );
  }

  messageStatus(String status, String statusKaryawan, String bayar) {
    if (status == 'waiting') {
      return 'Menunggu Persetujuan';
    } else if (status == 'success') {
      if (statusKaryawan == 'MARKETING AGEN') {
        if (bayar == '4') {
          return 'Sudah dibayarkan';
        } else {
          return 'Disetujui Sales Leader';
        }
      } else {
        return 'Disetujui Sales Leader';
      }
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader ';
    } else {
      return 'Menunggu Persetujuan';
    }
  }

  iconStatus(String status, String statusKaryawan, String bayar) {
    if (status == 'waiting') {
      return Icons.info;
    } else if (status == 'success') {
      if (statusKaryawan == 'MARKETING AGEN') {
        if (bayar == '4') {
          return Icons.attach_money;
        } else {
          return Icons.check;
        }
      } else {
        return Icons.check;
      }
    } else if (status == 'failed') {
      return Icons.cancel;
    } else {
      return Icons.info;
    }
  }

  colorStatus(String status) {
    if (status == 'waiting') {
      return Colors.blue;
    } else if (status == 'success') {
      return Colors.green;
    } else if (status == 'failed') {
      return Colors.red;
    } else {
      return Colors.blue;
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
