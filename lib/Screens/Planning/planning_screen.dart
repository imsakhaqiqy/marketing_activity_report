import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Planning/next_planning_screen.dart';
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
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getPlanning';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Planning'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Planning'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _nopen(dynamic user) {
    return user['nopen'];
  }

  String _nama(dynamic user) {
    return user['namapensiunan'];
  }

  String _tglLahir(dynamic user) {
    return user['tgl_lahir_pensiunan'];
  }

  String _gajiPokok(dynamic user) {
    return user['penpok'];
  }

  String _alamat(dynamic user) {
    return user['alm_peserta'];
  }

  String _kelurahan(dynamic user) {
    return user['kelurahan'];
  }

  String _kecamatan(dynamic user) {
    return user['kecamatan'];
  }

  String _kabupaten(dynamic user) {
    return user['kota_kab'];
  }

  String _provinsi(dynamic user) {
    return user['provinsi'];
  }

  String _kodepos(dynamic user) {
    return user['kodepos'];
  }

  String _namaKantor(dynamic user) {
    return user['nmkanbyr'];
  }

  String _tmtPensiun(dynamic user) {
    return user['tmtpensiun'];
  }

  String _penerbitSkep(dynamic user) {
    return user['penerbit_skep'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _visitStatus(dynamic user) {
    return user['visit_status'];
  }

  String _npwp(dynamic user) {
    return user['npwp'];
  }

  String _namaPenerima(dynamic user) {
    return user['nama_penerima'];
  }

  String _tanggalLahirPenerima(dynamic user) {
    return user['tgl_lahir_penerima'];
  }

  String _nomorSkep(dynamic user) {
    return user['nomor_skep'];
  }

  String _tanggalSkep(dynamic user) {
    return user['tanggal_skep'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  void initState() {
    super.initState();
    fetchUsers();
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
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionNull(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih rencana interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  Future interactionDate(BuildContext context) {
    Toast.show(
      'Maaf, silahkan pilih tanggal interaksi terlebih dahulu...',
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: Colors.white,
        child: _buildList(),
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
                          fontFamily: 'Roboto-Regular',
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
                            color: Colors.white, fontFamily: 'Roboto-Regular'),
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

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlanningViewScreen(
                              _nama(_users[index]),
                              _tglLahir(_users[index]),
                              _gajiPokok(_users[index]),
                              _alamat(_users[index]),
                              _kelurahan(_users[index]),
                              _kecamatan(_users[index]),
                              _kabupaten(_users[index]),
                              _provinsi(_users[index]),
                              _kodepos(_users[index]),
                              _namaKantor(_users[index]),
                              _tmtPensiun(_users[index]),
                              _penerbitSkep(_users[index]),
                              _telepon(_users[index]),
                              _visitStatus(_users[index]),
                              _nopen(_users[index]),
                              _npwp(_users[index]),
                              _namaPenerima(_users[index]),
                              _tanggalLahirPenerima(_users[index]),
                              _nomorSkep(_users[index]),
                              _tanggalSkep(_users[index]),
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            setSubNama(_nama(_users[index])),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Gaji Pokok',
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatRupiah(
                                    setSubNama(_gajiPokok(_users[index]))
                                        .toString()),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto-Regular'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Umur',
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                setNull(umur(int.parse(_tglLahir(_users[index])
                                            .substring(0, 4)))
                                        .toString()) +
                                    ' TAHUN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto-Regular'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: inputs[index],
                        onChanged: (bool value) {
                          ItemChange(value, index, _nopen(_users[index]),
                              _nama(_users[index]));
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
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.hourglass_empty, size: 70),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Request Database Yuk!',
                style: TextStyle(
                    fontFamily: "Roboto-Regular",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Hubungi tim IT Support kantor pusat, Imam Tri Prabowo (089612277567).',
                style: TextStyle(
                  fontFamily: "Roboto-Regular",
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return 'NULL';
    } else {
      return data;
    }
  }

  umur(int tglLahir) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    return int.parse(formatted) - tglLahir;
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
          style: TextStyle(fontSize: 12, fontFamily: 'Roboto-Regular')),
    ]);
  }

  formatRupiah(String a) {
    if (a.substring(0, 1) != '0') {
      FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
          amount: double.parse(a.replaceAll(',', '')),
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
