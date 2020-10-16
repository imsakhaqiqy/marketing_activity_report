import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/constants.dart';

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

  PipelineViewScreen(
      this.calonDebitur,
      this.tglPipeline,
      this.alamat,
      this.telepon,
      this.jenisProduk,
      this.nominal,
      this.cabang,
      this.keterangan,
      this.status);
  @override
  _PipelineViewScreenState createState() => _PipelineViewScreenState();
}

class _PipelineViewScreenState extends State<PipelineViewScreen> {
  List imgList;
  List imgText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            '${widget.calonDebitur}',
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            color: grey,
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child:
                ListView(physics: ClampingScrollPhysics(), children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  //color: Colors.white,
                  padding: EdgeInsets.only(
                      left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Tanggal Pipeline',
                            child: Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.tglPipeline)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Alamat',
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.alamat)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Telepon',
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.telepon)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Jenis Produk',
                            child: Icon(
                              Icons.people_outline,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(setProduk(widget.jenisProduk))}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Plafond',
                            child: Icon(
                              Icons.attach_money,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(formatRupiah(widget.nominal))}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Kantor Cabang',
                            child: Icon(
                              Icons.work,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.cabang)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Keterangan',
                            child: Icon(
                              Icons.info,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.keterangan)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Tooltip(
                            message: 'Status',
                            child: Icon(
                              iconStatus(widget.status),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(messageStatus(widget.status))}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: colorStatus(widget.status),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )))
            ])));
  }

  iconStatus(String status) {
    if (status == '1') {
      return Icons.info;
    } else if (status == '2') {
      return Icons.check;
    }
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Belum Pencairan';
    } else if (status == '2') {
      return 'Sudah Pencairan';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.blue;
    } else if (status == '2') {
      return Colors.green;
    }
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setProduk(String produk) {
    if (produk == '0') {
      return 'Prapensiun';
    } else {
      return 'Pensiun';
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
