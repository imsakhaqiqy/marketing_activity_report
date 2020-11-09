import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Approval/approval_disbursment_root_screen.dart';
import 'package:kreditpensiun_apps/Screens/Approval/approval_pencairan_screen.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class ApprovalDisbursmentViewScreen extends StatefulWidget {
  String username;
  String nik;
  String nikSdm;
  String id;
  String calonDebitur;
  String alamat;
  String telepon;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String nominal;
  String jenisPencairan;
  String jenisProduk;
  String kantorCabang;
  String informasiSales;
  String foto1;
  String foto2;
  String foto3;
  String tanggalPencairan;
  String jamPencairan;
  String namaSales;
  String statusPencairan;

  ApprovalDisbursmentViewScreen(
      this.username,
      this.nik,
      this.nikSdm,
      this.id,
      this.calonDebitur,
      this.alamat,
      this.telepon,
      this.tanggalAkad,
      this.nomorAplikasi,
      this.nomorPerjanjian,
      this.nominal,
      this.jenisPencairan,
      this.jenisProduk,
      this.kantorCabang,
      this.informasiSales,
      this.foto1,
      this.foto2,
      this.foto3,
      this.tanggalPencairan,
      this.jamPencairan,
      this.namaSales,
      this.statusPencairan);
  @override
  _ApprovalDisbursmentViewScreenState createState() =>
      _ApprovalDisbursmentViewScreenState();
}

class _ApprovalDisbursmentViewScreenState
    extends State<ApprovalDisbursmentViewScreen> {
  List imgList;
  List imgText;
  bool _loadingA = false;
  bool _loadingR = false;

  Future dialogLoading(bool _loadingA) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            if (_loadingA == false) {
              Navigator.of(context).pop();
            }
          });

          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                height: 20,
                width: 20,
              )
            ])),
          );
        });
  }

  Future approvalInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingA = true;
    });
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/ApprovalDisbursment';

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'status_pencairan': 'success',
      'rekom_sl': 'approve_pencairan',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Approval_Disbursment'];
      print(message);
      if (message == 'Save Success') {
        setState(() {
          _loadingA = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ApprovalDisbursmentRootPage(
                    widget.username, widget.nik, widget.nikSdm)),
            ModalRoute.withName('/home'));
      } else {
        setState(() {
          _loadingA = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Pencairan gagal disetujui...'),
            //content: Text('We hate to see you leave...'),
            actions: <Widget>[],
          ),
        );
      }
    }
  }

  Future rejectInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingR = true;
    });
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/RejectDisbursment';

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'status_pencairan': 'failed',
      'rekom_sl': 'reject_pencairan',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Reject_Disbursment'];
      if (message.toString() == 'Save Success') {
        setState(() {
          _loadingR = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ApprovalDisbursmentRootPage(
                    widget.username, widget.nik, widget.nikSdm)),
            ModalRoute.withName('/'));
      } else {
        setState(() {
          _loadingR = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Pencairan gagal ditolak...'),
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

  @override
  Widget build(BuildContext context) {
    String foto1 = 'https://www.nabasa.co.id/marsit/' + widget.foto1;
    String foto2 = 'https://www.nabasa.co.id/marsit/' + widget.foto2;
    String foto3 = 'https://www.nabasa.co.id/marsit/' + widget.foto3;
    imgList = [foto1, foto2, foto3];
    imgText = ['Foto Akad', 'Foto Tanda Tangan Akad', 'Foto Bukti Dana Cair'];
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
                      _buildBannerMenu(),
                      SizedBox(
                        height: 10,
                      ),
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
                            message: 'Tanggal Akad',
                            child: Icon(
                              Icons.check,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.tanggalAkad)}',
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
                            message: 'Nomor Aplikasi',
                            child: Icon(
                              Icons.turned_in_not,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.nomorAplikasi)}',
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
                            message: 'Nomor Perjanjian',
                            child: Icon(
                              Icons.turned_in_not,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.nomorPerjanjian)}',
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
                            message: 'Jenis Pencairan',
                            child: Icon(
                              Icons.people,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.jenisPencairan)}',
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
                              Icons.turned_in_not,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.jenisProduk)}',
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
                              '${setNull(widget.kantorCabang)}',
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
                            message: 'Sales Informasi',
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.informasiSales)}',
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
                            message: 'Tanggal Pencairan',
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
                              '${setNull(widget.tanggalPencairan)}',
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
                            message: 'Jam Pencairan',
                            child: Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.jamPencairan)}',
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
                            message: 'Status Pencairan',
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
                              '${setNull(widget.statusPencairan)}',
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
                            message: 'Nama Sales',
                            child: Icon(
                              Icons.person_pin,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.namaSales)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: () {
                            dialogLoading(_loadingA);
                            approvalInteraksi();
                          },
                          child: Text(
                            'Setuju',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat Regular'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: FlatButton(
                          color: Colors.redAccent,
                          onPressed: () {
                            dialogLoading(_loadingR);
                            rejectInteraksi();
                          },
                          child: Text(
                            'Tolak',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat Regular'),
                          ),
                        ),
                      )
                    ],
                  ))
            ])));
  }

  Widget _buildBannerMenu() {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: PhotoView(
                                  imageProvider: NetworkImage(item),
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.transparent),
                                ),
                              ),
                            );
                          },
                          child: Image.network(item, fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }
}
