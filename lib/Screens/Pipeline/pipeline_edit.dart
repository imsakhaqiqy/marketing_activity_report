import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kreditpensiun_apps/Screens/models/image_upload_model.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineEditScreen extends StatefulWidget {
  String username;
  String nik;
  String idPipeline;

  PipelineEditScreen(this.username, this.nik, this.idPipeline);
  @override
  _PipelineEditScreen createState() => _PipelineEditScreen();
}

class _PipelineEditScreen extends State<PipelineEditScreen> {
  bool loadingScreen;
  String image1;
  String image2;
  String base64Image1;
  String base64Image2;
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  bool _isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    images.add("Add Image");
    super.initState();
    this.getCabang();
    this.getBankTakeover();
    this.getDataPipeline();
  }

  String nomorKtp;
  String namaPensiun;
  String tempatLahir;
  String tanggalLahir;
  String alamat;
  String telepon;
  String plafond;
  String keteranganPensiun;
  String path1;
  String path2;
  String path3;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedJenisCabang;
  var selectedJenisDebitur;
  var selectedBankTakeover;
  List<String> _jenisDebiturType = <String>[
    'Prapensiun',
    'Pensiun',
    'Take over Kredit Aktif BTPN',
    'Pegawai Aktif PNS',
    'Pegawai Aktif BUMN',
    'Pegawai Perguruan Tinggi'
  ];
  var selectedJenisKelamin;
  List<String> _jenisKelaminType = <String>['LAKI-LAKI', 'PEREMPUAN'];
  var selectedStatusKredit;
  List<String> _jenisStatusKreditType = <String>[
    'KREDIT BARU',
    'TOP UP',
    'TAKEOVER'
  ];

  var selectedPengelolaPensiun;
  List<String> _jenisPengelolaPensiunType = <String>[
    'TASPEN',
    'ASABRI',
    'DANA PENSIUN PLN',
    'DANA PENSIUN TELKOM',
    'PERTAMINA'
  ];
  String nomorNpwp;
  String keterangan;
  var personalData = new List(34);

  final String url =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getCabang';
  List data =
      List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  final String url2 =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getBankTakeover';
  List data2 =
      List(); //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY
  bool visible = false;
  final nomorKtpController = TextEditingController();
  final namaPensiunController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final keteranganPensiunController = TextEditingController();
  final plafondController = TextEditingController();
  final nomorNpwpController = TextEditingController();

  Future getDataPipeline() async {
    loadingScreen = true;
    String idPipeline = widget.idPipeline;
    String nikSales = widget.nik;
    //server login api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/getDataPipeline';
    //starting web api call
    var response = await http
        .post(url, body: {'id_pipeline': idPipeline, 'nik_sales': nikSales});
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Data_Pipeline'];
      print(message);
      setState(() {
        loadingScreen = false;
        tanggalLahir = message[0]['tgl_lahir'];
        nomorKtpController.text = message[0]['no_ktp'];
        namaPensiunController.text = message[0]['cadeb'];
        teleponController.text = message[0]['telepon'];
        alamatController.text = message[0]['alamat'];
        tempatLahirController.text = message[0]['tempat_lahir'];
        tanggalLahirController.text = message[0]['tgl_lahir'];
        nomorNpwpController.text = message[0]['npwp'];
        if (message[0]['jenis_kelamin'].toString() == '0') {
          selectedJenisKelamin = 'LAKI-LAKI';
        } else {
          selectedJenisKelamin = 'PEREMPUAN';
        }
        plafondController.text = message[0]['nominal'];
        keteranganPensiunController.text = message[0]['keterangan'];
        if (message[0]['jenis_produk'] == '0') {
          selectedJenisDebitur = 'Prapensiun';
        } else if (message[0]['jenis_produk'] == '1') {
          selectedJenisDebitur = 'Pensiun';
        } else if (message[0]['jenis_produk'] == '2') {
          selectedJenisDebitur = 'Take over Kredit Aktif BTPN';
        } else if (message[0]['jenis_produk'] == '3') {
          selectedJenisDebitur = 'Pegawai Aktif PNS';
        } else if (message[0]['jenis_produk'] == '4') {
          selectedJenisDebitur = 'Pegawai Aktif BUMN';
        } else if (message[0]['jenis_produk'] == '5') {
          selectedJenisDebitur = 'Pegawai Perguruan Tinggi';
        }
        selectedJenisCabang = message[0]['cabang'];
        selectedStatusKredit = message[0]['status_kredit'];
        if (selectedStatusKredit == 'TAKEOVER') {
          String bankTakeovernya = '';
          bankTakeovernya = message[0]['bank_takeover'];
          selectedBankTakeover = bankTakeovernya;
        }
        selectedPengelolaPensiun = message[0]['pengelola_pensiun'];
        path1 =
            'https://www.nabasa.co.id/marsit/' + message[0]['foto1'].toString();
        path2 =
            'https://www.nabasa.co.id/marsit/' + message[0]['foto2'].toString();
        images.replaceRange(0, 0 + 1, [path1]);
        image1 =
            'https://www.nabasa.co.id/marsit/' + message[0]['foto1'].toString();
        images.replaceRange(1, 1 + 1, [path2]);
        image2 =
            'https://www.nabasa.co.id/marsit/' + message[0]['foto2'].toString();
      });
    } else {
      setState(() {
        loadingScreen = false;
      });
      print('error');
    }
  }

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

  Future<String> getBankTakeover() async {
    var res = await http
        .get(Uri.encodeFull(url2), headers: {'accept': 'application/json'});
    var resBody = json.decode(res.body)['Daftar_Bank_Takeover'];
    setState(() {
      data2 = resBody;
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
              personalData[33] = message['diamond'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            }
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  Future updatePipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    nomorKtp = nomorKtpController.text;
    namaPensiun = namaPensiunController.text;
    telepon = teleponController.text;
    alamat = alamatController.text;
    tempatLahir = tempatLahirController.text;
    tanggalLahir = tanggalLahirController.text;
    nomorNpwp = nomorNpwpController.text;
    plafond = plafondController.text;
    keteranganPensiun = keteranganPensiunController.text;

    //server save api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/editPipeline';
    var response;
    String bankTakeovernya;
    if (selectedBankTakeover == null) {
      bankTakeovernya = '';
    } else {
      bankTakeovernya = selectedBankTakeover;
    }
    if (path1 != '' && path2 != '') {
      response = await http.post(url, body: {
        'id_pipeline': widget.idPipeline,
        'nomor_ktp': nomorKtp,
        'nama_pensiun': namaPensiun,
        'telepon': telepon,
        'alamat': alamat,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'nomor_npwp': nomorNpwp,
        'plafond': plafond,
        'keterangan': keteranganPensiun,
        'jenis_kelamin': selectedJenisKelamin,
        'jenis_debitur': selectedJenisDebitur,
        'jenis_cabang': selectedJenisCabang,
        'status_kredit': selectedStatusKredit,
        'bank_takeover': bankTakeovernya,
        'pengelola_pensiun': selectedPengelolaPensiun,
        'image': '1',
        'niksales': widget.nik,
      });
    } else {
      response = await http.post(url, body: {
        'id_pipeline': widget.idPipeline,
        'nomor_ktp': nomorKtp,
        'nama_pensiun': namaPensiun,
        'telepon': telepon,
        'alamat': alamat,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'nomor_npwp': nomorNpwp,
        'plafond': plafond,
        'keterangan': keteranganPensiun,
        'jenis_kelamin': selectedJenisKelamin,
        'jenis_debitur': selectedJenisDebitur,
        'jenis_cabang': selectedJenisCabang,
        'status_kredit': selectedStatusKredit,
        'bank_takeover': bankTakeovernya,
        'pengelola_pensiun': selectedPengelolaPensiun,
        'file_name': 'pipeline',
        'image1': base64Image1,
        'name1': image1,
        'image2': base64Image2,
        'name2': image2,
        'niksales': widget.nik,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Pipeline'];
      if (message.toString() == 'Update Success') {
        setState(() {
          visible = false;
          namaPensiunController.clear();
          alamatController.clear();
          teleponController.clear();
          selectedJenisDebitur = null;
          selectedJenisCabang = null;
          selectedStatusKredit = null;
          selectedPengelolaPensiun = null;
          plafondController.clear();
          keteranganPensiunController.clear();
        });
        userLogin();
        Toast.show(
          'Sukses update pipeline',
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
          'Gagal update pipeline',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
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
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        'Mohon menunggu, sedang proses update pipeline...'),
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
              'Ubah Pipeline',
              style: TextStyle(fontFamily: 'Montserrat Regular'),
            ),
            actions: <Widget>[
              loadingScreen
                  ? Text('')
                  : FlatButton(
                      //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
                      //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
                      child: visible
                          ? CircularProgressIndicator(
                              //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Update',
                              style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (selectedJenisKelamin == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih jenis kelamin...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (selectedJenisDebitur == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih jenis produk...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (selectedJenisCabang == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih kantor cabang...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (selectedStatusKredit == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih status kredit...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (selectedPengelolaPensiun == null) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih pengelola pensiun...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (image1 == null || image1 == '') {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih foto ktp...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else if (image2 == null || image2 == '') {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Mohon pilih foto npwp...'),
                              duration: Duration(seconds: 3),
                            ));
                          } else {
                            updatePipeline();
                          }
                        }
                      })
            ],
          ),
          body: loadingScreen
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                )
              : Container(
                  color: Colors.grey[200],
                  child: Form(
                    key: formKey,
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Data Nasabah',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              fieldKtp(),
                              fieldDebitur(),
                              fieldTelepon(),
                              fieldAlamat(),
                              fieldTempatLahir(),
                              fieldTanggalLahir(),
                              fieldNomorNpwp(),
                              fieldJenisKelamin(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Data Kredit',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              fieldPlafond(),
                              fieldKeterangan(),
                              fieldJenisDebitur(),
                              fieldKantorCabang(),
                              fieldStatusKredit(),
                              Visibility(
                                  visible: _isVisible,
                                  child: fieldBankTakeOver()),
                              fieldPengelolaPensiun(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Dokumen Nasabah',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 20),
                                  ),
                                ),
                                path1 != null && path1 != ''
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                path1 = '';
                                                image1 = '';
                                                image2 = '';
                                              });
                                            },
                                            child: Tooltip(
                                              message: 'Reset Photo',
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                            )))
                                    : Text('')
                              ],
                            )),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          //color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: buildGridView())
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
        ));
  }

  Widget fieldKtp() {
    return TextFormField(
      controller: nomorKtpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor KTP wajib diisi...';
        } else if (value.length < 16 && value.length > 16) {
          return 'Nomor KTP harus 16 digit...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor KTP'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTempatLahir() {
    return TextFormField(
      controller: tempatLahirController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Tempat lahir wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Tempat Lahir'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTanggalLahir() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalLahirController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalLahir == null) {
              return 'Tanggal Lahir wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Lahir'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Montserrat Regular')),
    ]);
  }

  Widget fieldJenisKelamin() {
    return DropdownButtonFormField(
        items: _jenisKelaminType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisKelaminType) {
          setState(() {
            selectedJenisKelamin = selectedJenisKelaminType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Kelamin',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedJenisKelamin,
        isExpanded: true);
  }

  Widget fieldNomorNpwp() {
    return TextFormField(
      controller: nomorNpwpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor NPWP wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor NPWP'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama sesuai KTP wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama sesuai KTP'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
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
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No Telepon minimal 10 angka...';
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
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldJenisDebitur() {
    return DropdownButtonFormField(
        items: _jenisDebiturType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
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
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
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
                      fontFamily: 'Montserrat Regular',
                    ),
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
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
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
        style: TextStyle(fontFamily: 'Montserrat Regular'));
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
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldStatusKredit() {
    return DropdownButtonFormField(
        items: _jenisStatusKreditType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedStatusKreditType) {
          setState(() {
            selectedStatusKredit = selectedStatusKreditType;
            if (selectedStatusKredit == 'TAKEOVER') {
              _isVisible = true;
            } else {
              _isVisible = false;
            }
            print(selectedBankTakeover);
          });
        },
        decoration: InputDecoration(
            labelText: 'Status Kredit',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedStatusKredit,
        isExpanded: true);
  }

  Widget fieldBankTakeOver() {
    return DropdownButtonFormField(
        items: data2
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['nama'],
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value['nama'].toString(),
                ))
            .toList(),
        onChanged: (selectedBankTakeoverType) {
          setState(() {
            selectedBankTakeover = selectedBankTakeoverType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Bank Takeover',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedBankTakeover,
        isExpanded: true);
  }

  Widget fieldPengelolaPensiun() {
    return DropdownButtonFormField(
        items: _jenisPengelolaPensiunType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisPengelolaPensiunType) {
          setState(() {
            selectedPengelolaPensiun = selectedJenisPengelolaPensiunType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Pengelola Pensiun',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedPengelolaPensiun,
        isExpanded: true);
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: PhotoView(
                          imageProvider: FileImage(uploadModel.imageFile),
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          if (path1 != '' && path2 != '') {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: PhotoView(
                            imageProvider: NetworkImage(images[index]),
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      images[index],
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            if (index == 0) {
              titled = 'Foto KTP';
              colored = Colors.teal;
            } else if (index == 1) {
              titled = 'Foto NPWP';
              colored = Colors.teal;
            }
            return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: colored, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titled,
                    style: TextStyle(
                        fontSize: 8.0, fontFamily: 'Montserrat Regular'),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                ],
              ),
            );
          }
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        if (file == null) {
        } else {
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          String base64Image =
              base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          } else if (index == 1) {
            image2 = fileName;
            base64Image2 = base64Image;
          }
        }
      });
    });
  }
}
