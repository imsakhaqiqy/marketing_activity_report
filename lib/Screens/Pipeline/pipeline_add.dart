import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

// ignore: must_be_immutable
class PipelineAddScreen extends StatefulWidget {
  String username;
  String nik;

  PipelineAddScreen(this.username, this.nik);
  @override
  _PipelineAddScreen createState() => _PipelineAddScreen();
}

class _PipelineAddScreen extends State<PipelineAddScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCabang();
  }

  String namaPensiun;
  String alamat;
  String telepon;
  String plafond;
  String keteranganPensiun;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedJenisCabang;
  var selectedJenisDebitur;
  List<String> _jenisDebiturType = <String>['Prapensiun', 'Pensiun'];
  var personalData = new List(33);

  final String url =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getCabang';
  List data =
      List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  bool visible = false;
  final namaPensiunController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final keteranganPensiunController = TextEditingController();
  final plafondController = TextEditingController();

  // ignore: missing_return
  Future<String> getCabang() async {
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    var resBody = json.decode(res.body)['Daftar_Cabang'];
    setState(() {
      data = resBody;
      print(data);
    });
  }

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    //server login api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/getLogin';

    //starting web api call
    var response = await http
        .post(url, body: {'username': username, 'password': password});

    if (username == '' || password == '') {
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message);
        if (message['message'].toString() == 'Login Success') {
          if (message['status_account'] == 'SUSPEND') {
          } else {
            setState(() {
              personalData[0] = message['nik'];
              personalData[1] = message['full_name'];
              personalData[2] = message['marital_status'];
              personalData[3] = message['date_of_birth'];
              personalData[4] = message['place_of_birth'];
              personalData[5] = message['no_ktp'];
              personalData[6] = message['gender'];
              personalData[7] = message['religion'];
              personalData[8] = message['email_address'];
              personalData[9] = message['phone_number'];
              personalData[10] = message['education'];
              personalData[11] = message['alamat'];
              personalData[12] = message['kelurahan'];
              personalData[13] = message['kecamatan'];
              personalData[14] = message['kabupaten'];
              personalData[15] = message['kode_pos'];
              personalData[16] = message['propinsi'];
              personalData[17] = message['no_rekening'];
              personalData[18] = message['nama_bank'];
              personalData[19] = message['nama_rekening'];
              personalData[20] = message['divisi_karyawan'];
              personalData[21] = message['jabatan_karyawan'];
              personalData[22] = message['wilayah_karyawan'];
              personalData[23] = message['branch'];
              personalData[24] = message['status_karyawan'];
              personalData[25] = message['grade_karyawan'];
              personalData[26] = message['gaji_pokok'];
              personalData[27] = message['tunjangan_tkd'];
              personalData[28] = message['tunjangan_jabatan'];
              personalData[29] = message['tunjangan_perumahan'];
              personalData[30] = message['tunjangan_telepon'];
              personalData[31] = message['tunjangan_kinerja'];
              personalData[32] = message['nik_marsit'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                        message['full_name'],
                        message['nik_marsit'],
                        message['income'],
                        message['pict'],
                        message['divisi'],
                        message['greeting'],
                        message['hak_akses'],
                        personalData,
                        message['tarif'],
                      )));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      message['full_name'],
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'])));
            }
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  Future savePipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamat = alamatController.text;
    telepon = teleponController.text;
    plafond = plafondController.text;
    keteranganPensiun = keteranganPensiunController.text;

    //server save api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/savePipeline';

    //starting web api call
    var response = await http.post(url, body: {
      'nama_pensiun': namaPensiun,
      'alamat': alamat,
      'telepon': telepon,
      'jenis_debitur': selectedJenisDebitur,
      'jenis_cabang': selectedJenisCabang,
      'plafond': plafond,
      'keterangan': keteranganPensiun,
      'niksales': widget.nik,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Pipeline'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          namaPensiunController.clear();
          alamatController.clear();
          teleponController.clear();
          selectedJenisDebitur = null;
          selectedJenisCabang = null;
          plafondController.clear();
          keteranganPensiunController.clear();
        });
        userLogin();
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Sukses menambahkan data pipeline...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          visible = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Gagal menambahkan data pipeline...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          visible
              ? showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text(
                        'Mohon menunggu, sedang proses penyimpanan pipeline...'),
                    //content: Text('We hate to see you leave...'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                )
              : Navigator.of(context).pop();
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Pipeline',
              style: TextStyle(fontFamily: 'Montserrat Regular'),
            ),
            actions: <Widget>[
              FlatButton(
                  //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
                  //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
                  child: visible
                      ? CircularProgressIndicator(
                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Simpan',
                          style: TextStyle(
                              fontFamily: 'Montserrat Regular',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      if (selectedJenisDebitur == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Mohon pilih jenis produk...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else if (selectedJenisCabang == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Mohon pilih kantor cabang...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        savePipeline();
                      }
                    }
                  })
            ],
          ),
          body: Container(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    fieldDebitur(),
                    fieldAlamat(),
                    fieldTelepon(),
                    fieldPlafond(),
                    fieldKeterangan(),
                    fieldJenisDebitur(),
                    fieldKantorCabang(),
                  ],
                ),
              )),
        ));
  }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
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

  Widget fieldAlamat() {
    return TextFormField(
      controller: alamatController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Alamat wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Alamat'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 11) {
          return 'No Telepon minimal 11 angka...';
        } else if (value.length > 13) {
          return 'No Telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'No Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldJenisDebitur() {
    return DropdownButtonFormField(
        items: _jenisDebiturType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular', fontSize: 12),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisDebiturType) {
          setState(() {
            selectedJenisDebitur = selectedJenisDebiturType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Produk',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle:
                TextStyle(fontFamily: 'Montserrat Regular', fontSize: 12)),
        value: selectedJenisDebitur,
        isExpanded: true);
  }

  Widget fieldKantorCabang() {
    return DropdownButtonFormField(
        items: data
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['NAMA'],
                    style: TextStyle(
                        fontFamily: 'Montserrat Regular', fontSize: 12),
                  ),
                  value: value['NAMA'].toString(),
                ))
            .toList(),
        onChanged: (selectedJenisCabangType) {
          setState(() {
            selectedJenisCabang = selectedJenisCabangType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Kantor Cabang',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle:
                TextStyle(fontFamily: 'Montserrat Regular', fontSize: 12)),
        value: selectedJenisCabang,
        isExpanded: true);
  }

  Widget fieldPlafond() {
    return TextFormField(
        controller: plafondController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal pinjaman wajib diisi...';
          } else if (value.length < 8) {
            return 'Nominal pinjaman minimal 8 digit...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal Pinjaman'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'));
  }

  Widget fieldKeterangan() {
    return TextFormField(
      controller: keteranganPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Keterangan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Keterangan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontSize: 12, fontFamily: 'Montserrat Regular'),
    );
  }
}
