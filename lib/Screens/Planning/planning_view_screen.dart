import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanningViewScreen extends StatefulWidget {
  String nama;
  String tglLahir;
  String gajiPokok;
  String alamat;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String kodepos;
  String namaKantor;
  String tmtPensiun;
  String penerbitSkep;
  String telepon;
  String visitStatus;
  String notas;
  String npwp;
  String namaPenerima;
  String tanggalLahirPenerima;
  String nomorSkep;
  String tanggalSkep;

  PlanningViewScreen(
    this.nama,
    this.tglLahir,
    this.gajiPokok,
    this.alamat,
    this.kelurahan,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.kodepos,
    this.namaKantor,
    this.tmtPensiun,
    this.penerbitSkep,
    this.telepon,
    this.visitStatus,
    this.notas,
    this.npwp,
    this.namaPenerima,
    this.tanggalLahirPenerima,
    this.nomorSkep,
    this.tanggalSkep,
  );
  @override
  _PlanningViewScreenState createState() => _PlanningViewScreenState();
}

class _PlanningViewScreenState extends State<PlanningViewScreen> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  String telepon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(widget.telepon);
      if (widget.telepon == null ||
          widget.telepon == '' ||
          widget.telepon.isEmpty) {
        telepon = setNull(widget.telepon);
      } else {
        if (widget.telepon.substring(0, 1) != '0') {
          telepon = '0' + widget.telepon;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(
              '${setNull(widget.nama)}',
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (widget.telepon != '') {
                    String teleponFix = '+62' + telepon.substring(1);
                    launchWhatsApp(phone: teleponFix, message: 'Tes');
                  } else {
                    Toast.show(
                      'No telepon kosong...',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                icon: Icon(MdiIcons.whatsapp),
                iconSize: 20,
              ),
              IconButton(
                onPressed: () {
                  if (widget.telepon.length >= 10) {
                    _makePhoneCall('tel:$telepon');
                  } else {
                    Toast.show(
                      'No telepon kosong...',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                icon: Icon(Icons.call),
                iconSize: 20,
              )
            ],
          ),
          body: Container(
              color: Colors.grey[200],
              child:
                  ListView(physics: ClampingScrollPhysics(), children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Informasi Pribadi',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          fieldDebitur(
                              'Notas', setNull(widget.notas.trimLeft())),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Tanggal Lahir', setNull(widget.tglLahir)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Gaji Pokok',
                              setNull(formatRupiah(widget.gajiPokok))),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('NPWP', setNull(widget.npwp)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Telepon', telepon),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Tanggal Pensiun', setNull(widget.tmtPensiun)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Informasi Penerima',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          fieldDebitur(
                              'Nama Penerima', setNull(widget.namaPenerima)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Tanggal Lahir',
                              setNull(widget.tanggalLahirPenerima)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Alamat', setNull(widget.alamat)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Kelurahan', setNull(widget.kelurahan)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Kecamatan', setNull(widget.kecamatan)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Kota', setNull(widget.kabupaten)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Propinsi', setNull(widget.provinsi)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Kodepos', setNull(widget.kodepos)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Informasi Lainnya',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          fieldDebitur(
                              'Kantor Bayar', setNull(widget.namaKantor)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur('Nomor SKEP', setNull(widget.nomorSkep)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Tanggal SKEP', setNull(widget.tanggalSkep)),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Penerbit SKEP', setNull(widget.penerbitSkep)),
                        ],
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return 'NULL';
    } else {
      return data;
    }
  }

  setColorStatusVisit(String nilai) {
    if (nilai == '1') {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  setStatusVisit(String nilai) {
    if (nilai == '1') {
      return 'BELUM DI INTERAKSI';
    } else {
      return 'SUDAH DI INTERAKSI';
    }
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

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          decoration: new BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style:
                  TextStyle(fontFamily: 'Roboto-Regular', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        color: Colors.black,
                      ),
                    )
                  ],
                ))),
      ],
    );
  }
}
