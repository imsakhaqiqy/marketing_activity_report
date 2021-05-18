import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/Screens/Modul/view_image_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class PipelineViewScreen extends StatefulWidget {
  String calonDebitur;
  String tglPipeline;
  String alamat;
  String telepon;
  String jenisProduk;
  String nominal;
  String cabang;
  String keterangan;
  String status;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String nomorKtp;
  String npwp;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String foto1;
  String foto2;

  PipelineViewScreen(
      this.calonDebitur,
      this.tglPipeline,
      this.alamat,
      this.telepon,
      this.jenisProduk,
      this.nominal,
      this.cabang,
      this.keterangan,
      this.status,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.nomorKtp,
      this.npwp,
      this.statusKredit,
      this.pengelolaPensiun,
      this.bankTakeover,
      this.foto1,
      this.foto2);
  @override
  _PipelineViewScreenState createState() => _PipelineViewScreenState();
}

class _PipelineViewScreenState extends State<PipelineViewScreen> {
  List imgList;
  List imgText;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            '${widget.calonDebitur}',
            style: TextStyle(
              fontFamily: 'Roboto-Regular',
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                String teleponFix = '+62' + widget.telepon.substring(1);
                launchWhatsApp(phone: teleponFix, message: 'Tes');
              },
              icon: Icon(MdiIcons.whatsapp),
              iconSize: 20,
            ),
            IconButton(
              onPressed: () {
                _makePhoneCall('tel:${widget.telepon}');
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
                  'Data Nasabah',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Tanggal Pipeline',
                        setNull(widget.tglPipeline), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Tempat Lahir', setNull(widget.tempatLahir), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Tanggal Lahir', setNull(widget.tanggalLahir),
                        120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Jenis Kelamin',
                        setJenisKelamin(setNull(widget.jenisKelamin)),
                        120.0,
                        ''),
                    SizedBox(height: 10),
                    fieldDebitur('No KTP', setNull(widget.nomorKtp), 120.0,
                        widget.foto1),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'NPWP', setNull(widget.npwp), 120.0, widget.foto2),
                    SizedBox(height: 10),
                    fieldDebitur('Alamat', setNull(widget.alamat), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Telepon', setNull(widget.telepon), 120.0, ''),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data Kredit',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    fieldDebitur('Jenis Produk',
                        setJenisProduk(setNull(widget.jenisProduk)), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Plafond',
                        formatRupiah(setNull(widget.nominal)), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Cabang', setNull(widget.cabang), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Keterangan', setNull(widget.keterangan), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Statu Pipeline',
                        messageStatus(setNull(widget.status)), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Status Kredit', setNull(widget.statusKredit),
                        120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Pengelola Pensiun',
                        setNull(widget.pengelolaPensiun), 120.0, ''),
                    SizedBox(height: 10),
                    setNull(widget.statusKredit) == 'TAKEOVER'
                        ? fieldDebitur('Bank Takeover',
                            setNull(widget.bankTakeover), 120.0, '')
                        : Text(''),
                    setNull(widget.statusKredit) == 'TAKEOVER'
                        ? SizedBox(height: 10)
                        : Text('')
                  ],
                ),
              ),
            ])));
  }

  Widget fieldDebitur(title, value, size, image) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: Colors.indigoAccent,
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
                      style: TextStyle(fontFamily: 'Roboto-Regular'),
                    ),
                  ],
                ))),
        SizedBox(
          width: 10,
        ),
        image != ''
            ? InkWell(
                child: Icon(Icons.image_outlined),
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageApp(image, title)));
                },
              )
            : Text('')
      ],
    );
  }

  iconStatus(String status) {
    if (status == '1') {
      return Icons.info;
    } else if (status == '2') {
      return Icons.check;
    } else if (status == '3') {
      return Icons.send;
    } else if (status == '4') {
      return Icons.date_range;
    }
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.orangeAccent;
    } else if (status == '2') {
      return Colors.greenAccent;
    } else if (status == '3') {
      return Colors.blueAccent;
    } else if (status == '4') {
      return Colors.blueAccent;
    }
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setJenisProduk(String produk) {
    switch (produk) {
      case "0":
        return 'PRAPENSIUN';
        break;
      case "1":
        return 'PENSIUN';
        break;
      case "2":
        return 'TAKE OVER KREDIT AKTIF BTPN';
        break;
      case "3":
        return 'PEGAWAI AKTIF PNS';
        break;
      case "4":
        return 'PEGAWAI AKTIF BUMN';
        break;
      case "5":
        return 'PEGAWAI PERGURUAN TINGGI';
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

  setJenisKelamin(jenisKelamin) {
    if (jenisKelamin == '0') {
      return 'LAKI-LAKI';
    } else {
      return 'PEREMPUAN';
    }
  }
}
