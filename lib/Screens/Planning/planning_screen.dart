import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Planning/next_planning_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_add_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/planning_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
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
  int plan = 0;
  List<bool> inputs = new List<bool>();
  List<String> notass = new List<String>();
  List<String> namaa = new List<String>();
  int counter = 0;
  String tglInteraksi;
  void initState() {
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < 100; i++) {
        inputs.add(false);
      }
    });
  }

  void ItemChange(bool val, int index, String notas, String nama) {
    setState(() {
      inputs[index] = val;
      if (val == true) {
        notass.add(notas);
        namaa.add(nama);
      } else {
        notass.remove(notas);
        namaa.remove(nama);
      }
    });
  }

  int _bottomNavCurrentIndex = 0;
  int itemSelected = 0;

  //Getting value from TextField Widget
  final tglInteraksiController = TextEditingController();

  Future interactionMax(BuildContext context) {
    Toast.show(
      'Maaf, maksimal rencana interaksi per hari hanya 3 saja...',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionNull(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih rencana interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionDate(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih tanggal interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Database',
          style: fontFamily,
        ),
        actions: <Widget>[],
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
              if (snapshot.data == null &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                );
              } else if (snapshot.data == null) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                                trailing: Checkbox(
                                  value: inputs[i],
                                  onChanged: (bool value) {
                                    ItemChange(
                                        value,
                                        i,
                                        data.dataPlanning[i].nopen,
                                        data.dataPlanning[i].nama);
                                    if (value == true) {
                                      setState(() {
                                        itemSelected += 1;
                                      });
                                    } else {
                                      setState(() {
                                        itemSelected -= 1;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.black12,
        ))),
        padding: EdgeInsets.all(16),
        height: 120,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Text(
                      itemSelected.toString() + ' data dipilih',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Montserrat Regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: null)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: fieldTanggal(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        tglInteraksi = tglInteraksiController.text;
                        if (notass.length > 3) {
                          interactionMax(context);
                        } else if (notass.length == 0) {
                          interactionNull(context);
                        } else {
                          if (tglInteraksi == '') {
                            interactionDate(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NextPlanningScreen(
                                          widget.username,
                                          widget.nik,
                                          notass,
                                          namaa,
                                          tglInteraksi,
                                        )));
                          }
                        }
                      },
                      child: Text(
                        'Selanjutnya',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat Regular'),
                      ),
                    ),
                  )
                ],
              ),
            ],
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
          decoration: InputDecoration(labelText: 'Pilih Tanggal Interaksi'),
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
}
