import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:toast/toast.dart';

class InteractionAddScreen extends StatefulWidget {
  String username;
  String nik;
  String namaNasabah;
  String alamatNasabah;
  String emailNasabah;
  String teleponNasabah;
  String title;
  String kelurahan;
  String kecamatan;
  String propinsi;
  String kotakab;
  String notas;

  InteractionAddScreen(
      this.username,
      this.nik,
      this.namaNasabah,
      this.alamatNasabah,
      this.emailNasabah,
      this.teleponNasabah,
      this.title,
      this.kelurahan,
      this.kecamatan,
      this.propinsi,
      this.kotakab,
      this.notas);
  @override
  _InteractionAddScreen createState() => _InteractionAddScreen();
}

class _InteractionAddScreen extends State<InteractionAddScreen> {
  void initState() {
    super.initState();
    setState(() {
      namaPensiunController.text = widget.namaNasabah;
      alamatController.text = widget.alamatNasabah;
      kelurahanController.text = widget.kelurahan;
      kecamatanController.text = widget.kecamatan;
      kotakabController.text = widget.kotakab;
      propinsiController.text = widget.propinsi;
      emailController.text = widget.emailNasabah;
      teleponController.text = widget.teleponNasabah;
    });
  }

  String kodeOtp;
  String namaPensiun;
  String alamat;
  String kelurahan;
  String kecamatan;
  String kotakab;
  String propinsi;
  String email;
  String telepon;
  String otp;
  String rencanaPinjaman;
  var selectedSalesFeedback;
  List<String> _jenisSalesFeedbackType = <String>[
    'SUDAH PINDAH BANK / KANTOR BAYAR',
    'MASIH MEMILIKI PINJAMAN DI BANK LAIN',
    'MASIH MEMILIKI PINJAMAN DI KOPERASI LAIN',
    'MENUNGGU PINJAMAN LUNAS TERLEBIH DAHULU',
    'BELUM ADA PINJAMAN DI BANK LAIN',
    'MAU TAKEOVER PINJAMAN',
    'PENSIUNAN BERMINAT UNTUK MEMINJAM',
    'MASIH MAU MENANYAKAN KELUARGA INTI',
  ];
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String uploadEndPoint =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/saveInteraction';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  bool _loading = false;
  bool _loadingOtp = false;
  var hasil;
  var personalData = new List(38);

  final namaPensiunController = TextEditingController();
  final alamatController = TextEditingController();
  final kelurahanController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kotakabController = TextEditingController();
  final propinsiController = TextEditingController();
  final emailController = TextEditingController();
  final teleponController = TextEditingController();
  final otpController = TextEditingController();
  final rencanaPinjamanController = TextEditingController();

  void _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      tmpFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      tmpFile = picture;
    });
    Navigator.of(context).pop();
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
              personalData[34] = message['total_pencairan'];
              personalData[35] = message['total_interaksi'];
              personalData[36] = message['rating'];
              personalData[37] = message['tgl_cut_off'];
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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Silahkan Pilih Foto Interaksi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera();
                      })
                ],
              ),
            ),
          );
        });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  Future requestOtp() async {
    setState(() {
      _loadingOtp = true;
    });
    //server login api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/sendOtp';
    telepon = teleponController.text;
    //starting web api call
    var response = await http
        .post(url, body: {'telepon': telepon, 'nik_sales': widget.nik});
    if (telepon == '' || telepon == null) {
      setState(() {
        _loadingOtp = false;
      });
      Toast.show(
        'No telepon wajib diisi terlebih dahulu',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Save_Otp'];
        print(message);
        if (message['message'].toString() == 'Otp Success') {
          setState(() {
            _loadingOtp = false;
            kodeOtp = message['kode_otp'];
          });
          Toast.show(
            'Kode verifikasi berhasil dikirim ke nomor nasabah, mohon ditanyakan ya',
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red,
          );
        }
      }
    }
  }

  upload(String fileName) {
    //getting value from controller
    namaPensiun = namaPensiunController.text;
    alamat = alamatController.text;
    email = emailController.text;
    telepon = teleponController.text;
    otp = otpController.text;
    rencanaPinjaman = rencanaPinjamanController.text;

    http.post(uploadEndPoint, body: {
      "niksales": widget.nik,
      "image": base64Image,
      "name": fileName,
      "file_name": "interaksi",
      "nama_pensiun": namaPensiun,
      "alamat": alamat,
      "email": email,
      "telepon": telepon,
      "otp": otp,
      "rencana_pinjaman": rencanaPinjaman,
      "sales_feedback": selectedSalesFeedback.toString(),
      "notas": widget.notas
    }).then((result) {
      if (result.statusCode == 200) {
        var message = jsonDecode(result.body)['status'];
        if (message == 'Nomor Telepon') {
          setState(() {
            _loading = false;
            print(message);
          });
          Toast.show(
            'Nomor telepon sudah terdaftar, mohon masukkan nomor telepon lain',
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red,
          );
        } else {
          setStatus(jsonDecode(result.body)['status']);
          setState(() {
            _loading = false;
            hasil = result.body;
            tmpFile = null;
            namaPensiunController.clear();
            alamatController.clear();
            kelurahanController.clear();
            kecamatanController.clear();
            kotakabController.clear();
            propinsiController.clear();
            emailController.clear();
            teleponController.clear();
            otpController.clear();
            rencanaPinjamanController.clear();
            selectedSalesFeedback = null;
          });
          userLogin();
          Toast.show(
            'Sukses menambahkan data interaksi',
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red,
          );
        }
      } else {
        setState(() {
          _loading = false;
        });
        Toast.show(
          'Gagal menambahkan data interaksi',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      Toast.show(
        'Gagal menambahkan data interaksi',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
      );
    });
  }

  Widget _decideImageView() {
    if (tmpFile == null) {
      return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(
              color: kPrimaryColor,
              width: 3,
            ),
          ),
          child: Center(
              child: Text("Foto Selfie / KTP",
                  style:
                      TextStyle(fontSize: 20, fontFamily: 'Roboto-Regular'))));
    } else {
      base64Image = base64Encode(tmpFile.readAsBytesSync());
      tmpFile = tmpFile;
      return Row(
        children: [
          Flexible(
              child: Image.file(
            tmpFile,
            fit: BoxFit.fill,
          ))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _loading
              ? Toast.show(
                  'Mohon menunggu, sedang proses penyimpanan interaksi',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.red,
                )
              : Navigator.of(context).pop();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: grey,
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Interaksi',
                style: TextStyle(fontFamily: 'Roboto-Regular'),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white),
                    padding: EdgeInsets.all(2.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      if (selectedSalesFeedback == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Mohon pilih sales feedback...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else if (tmpFile == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Mohon pilih foto selfie/KTP...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else if (otpController.text != kodeOtp) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content:
                              Text('Mohon isi kode verifikasi dengan benar...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        setState(() {
                          _loading = true;
                        });
                        showGeneralDialog(
                          context: context,
                          barrierColor: Colors.black12
                              .withOpacity(0.6), // background color
                          barrierDismissible:
                              false, // should dialog be dismissed when tapped outside
                          barrierLabel: "Dialog", // label for barrier
                          transitionDuration: Duration(
                              milliseconds:
                                  400), // how long it takes to popup dialog after button click
                          pageBuilder: (_, __, ___) {
                            // your widget implementation
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        startUpload();
                      }
                    }
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Form(
                    key: formKey,
                    child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          fieldDebitur(),
                          fieldAlamat(),
                          fieldKelurahan(),
                          fieldKecamatan(),
                          fieldKotakab(),
                          fieldPropinsi(),
                          fieldEmail(),
                          fieldTelepon(),
                          Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: fieldOTP(),
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 16.0, right: 16.0),
                                child: Center(
                                  child: _loadingOtp
                                      ? SizedBox(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                        )
                                      : FlatButton(
                                          color: kPrimaryColor,
                                          child: Text("Kirim Kode Verifikasi",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Regular',
                                                  fontSize: 12.0,
                                                  color: Colors.white)),
                                          onPressed: () {
                                            requestOtp();
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                ))
                          ]),
                          fieldRencanaPinjaman(),
                          fieldSalesFeedback(),
                          _decideImageView(),
                        ]),
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _loading
                    ? Toast.show(
                        'Mohon menunggu, sedang proses penyimpanan interaksi',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.red,
                      )
                    : _showChoiceDialog(context);
              },
              backgroundColor: kPrimaryColor,
              child: new Icon(Icons.camera_alt),
            ),
          ),
        ));
  }

  Widget fieldDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Calon debitur wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Calon debitur'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Roboto-Regular'),
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
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldKelurahan() {
    return TextFormField(
      controller: kelurahanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kelurahan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kelurahan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldKecamatan() {
    return TextFormField(
      controller: kecamatanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kecamatan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kecamatan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldKotakab() {
    return TextFormField(
      controller: kotakabController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kabupaten wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kabupaten'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldPropinsi() {
    return TextFormField(
      controller: propinsiController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Propinsi wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Propinsi'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldEmail() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldTelepon() {
    return TextFormField(
      controller: teleponController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'No Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldOTP() {
    return TextFormField(
      controller: otpController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Kode verifikasi wajib diisi...';
        } else if (value.length < 4) {
          return 'Kode verifikasi minimal 4 angka...';
        } else if (value.length > 4) {
          return 'Kode verifikasi maksimal 4 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Kode Verifikasi'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldRencanaPinjaman() {
    return TextFormField(
      controller: rencanaPinjamanController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Rencana pinjaman wajib diisi...';
        } else if (value.length < 8) {
          return 'Rencana pinjaman minimal 8 angka...';
        } else if (value.length > 9) {
          return 'Rencana pinjaman maksimal 9 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Rencana Pinjaman'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Roboto-Regular'),
    );
  }

  Widget fieldSalesFeedback() {
    return DropdownButtonFormField(
        items: _jenisSalesFeedbackType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedSalesFeedbackType) {
          setState(() {
            selectedSalesFeedback = selectedSalesFeedbackType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Sales Feedback',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Roboto-Regular',
            )),
        value: selectedSalesFeedback,
        isExpanded: true);
  }
}
