import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/constants.dart';

class DisbursmentViewScreen extends StatefulWidget {
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

  DisbursmentViewScreen(
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
      this.jamPencairan);
  @override
  _DisbursmentViewScreenState createState() => _DisbursmentViewScreenState();
}

class _DisbursmentViewScreenState extends State<DisbursmentViewScreen> {
  List imgList;
  List imgText;
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
                    ],
                  )))
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
                        Image.network(item, fit: BoxFit.fill),
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