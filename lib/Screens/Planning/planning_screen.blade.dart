import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_add_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/planning_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:intl/intl.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreen createState() => _PlanningScreen();

  String username;
  String nik;

  PlanningScreen(this.username, this.nik);
}

class _PlanningScreen extends State<PlanningScreen> {
  final formKey = GlobalKey<FormState>();
  int totalRencana;
  bool _loading = false;
  String nama;
  String notas;
  String tglInteraksi;

  //getting value from TextField widget.
  final namaController = TextEditingController();
  final notasController = TextEditingController();
  final tglInteraksiController = TextEditingController();

  Future addModal(String notas, String nama) async {
    namaController.text = nama;
    notasController.text = notas;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mau Interaksi Kapan ?'),
          content: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: ListBody(
              children: <Widget>[
                fieldNama(),
                SizedBox(
                  height: 10,
                ),
                fieldNotas(),
                SizedBox(
                  height: 10,
                ),
                fieldTanggal(),
                SizedBox(
                  height: 10,
                ),
                fieldKirim(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
        );
      },
    );
  }

  getDataInputan() {
    notas = notasController.text;
    tglInteraksi = tglInteraksiController.text;
  }

  Future addPlanningInteraction(String niksales) async {
    //_loading = true;
    getDataInputan();
    //server login api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/AddPlanningInteraction';

    //
    //starting web api call
    var response = await http.post(url, body: {
      'niksales': niksales,
      'notas': notas,
      'tgl_interaksi': tglInteraksi
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Send_Planning'];
      print(message);
      if (message['message'].toString() == 'Save Success') {
        //_loading = false;
        tglInteraksiController.clear();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message['message'].toString()),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        tglInteraksiController.clear();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message['message'].toString() +
                  ', Data sudah di tambahkan di tanggal $tglInteraksi'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Databases',
          style: fontFamily,
        ),
        actions: <Widget>[
          // FlatButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) =>
          //               PlanningAddScreen(widget.username, widget.nik)));
          //     },
          //     child: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
        onRefresh: () => Provider.of<PlanningProvider>(context, listen: false)
            .getPlanning(PlanningItem(widget.nik)),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<PlanningProvider>(context, listen: false)
                .getPlanning(PlanningItem(widget.nik)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                );
              }
              return Consumer<PlanningProvider>(
                builder: (context, data, _) {
                  if (data.dataPlanning.length == 0) {
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
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.dataPlanning.length,
                        itemBuilder: (context, i) {
                          return Card(
                              elevation: 2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlanningViewScreen(
                                          data.dataPlanning[i].nama,
                                          data.dataPlanning[i].tglLahir,
                                          data.dataPlanning[i].gajiPokok,
                                          data.dataPlanning[i].alamat,
                                          data.dataPlanning[i].kelurahan,
                                          data.dataPlanning[i].kecamatan,
                                          data.dataPlanning[i].kabupaten,
                                          data.dataPlanning[i].provinsi,
                                          data.dataPlanning[i].kodepos,
                                          data.dataPlanning[i].namaKantor,
                                          data.dataPlanning[i].tmtPensiun,
                                          data.dataPlanning[i].penerbitSkep,
                                          data.dataPlanning[i].telepon,
                                          data.dataPlanning[i].visitStatus,
                                          data.dataPlanning[i].nopen)));
                                },
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        '${setSubNama(data.dataPlanning[i].nama)}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat Regular'),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Gaji Pokok : ${formatRupiah(data.dataPlanning[i].gajiPokok)}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Montserrat Regular'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Umur : ${umur(data.dataPlanning[i].tglLahir)} TAHUN',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Montserrat Regular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    child: Icon(Icons.add_shopping_cart),
                                    onTap: () {
                                      //addPlanningInteraction();
                                      addModal(data.dataPlanning[i].nopen,
                                          data.dataPlanning[i].nama);
                                      print('${data.dataPlanning[i].nopen}');
                                    },
                                  ),
                                ),
                              ));
                        });
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  umur(String tglLahir) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    return int.parse(formatted) - int.parse(tglLahir.substring(0, 4));
  }

  setSubNama(String nama) {
    if (nama.length > 25) {
      return nama.substring(0, 25);
    } else {
      return nama;
    }
  }

  formatRupiah(String a) {
    if (a.substring(0, 1) == '0') {
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
    } else {
      return a;
    }
  }

  Widget fieldNama() {
    return TextFormField(
      enabled: false,
      controller: namaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama pensiun wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama Pensiun'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldNotas() {
    return TextFormField(
      enabled: false,
      controller: notasController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Notas wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Notas'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTanggal() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tglInteraksiController,
          validator: (DateTime dateTime) {
            if (dateTime == null) {
              return 'Tanggal interaksi wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Interaksi'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular')),
    ]);
  }

  Widget fieldKirim() {
    return FlatButton(
      color: Colors.deepPurple,
      child: Text("Tambah",
          style: TextStyle(
              fontFamily: 'Montserrat Regular',
              fontSize: 12.0,
              color: Colors.white)),
      onPressed: () {
        if (formKey.currentState.validate()) {
          addPlanningInteraction(widget.nik);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
