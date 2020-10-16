import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/constants.dart';

class InteractionViewScreen extends StatefulWidget {
  String calonDebitur;
  String alamat;
  String email;
  String telepon;
  String rencanaPinjaman;
  String salesFeedback;
  String foto;
  String tanggalInteraksi;
  String jamInteraksi;
  String status;

  InteractionViewScreen(
      this.calonDebitur,
      this.alamat,
      this.email,
      this.telepon,
      this.rencanaPinjaman,
      this.salesFeedback,
      this.foto,
      this.tanggalInteraksi,
      this.jamInteraksi,
      this.status);
  @override
  _InteractionViewScreenState createState() => _InteractionViewScreenState();
}

class _InteractionViewScreenState extends State<InteractionViewScreen> {
  @override
  Widget build(BuildContext context) {
    String foto = 'https://www.nabasa.co.id/marsit/' + widget.foto;
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
                      Center(
                          child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(foto),
                      )),
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
                            message: 'Email',
                            child: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.email)}',
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
                            message: 'Rencana Pinjaman',
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
                              '${setNull(widget.rencanaPinjaman)}',
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
                            message: 'Sales Feedback',
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
                              '${setNull(widget.salesFeedback)}',
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
                            message: 'Tanggal Interaksi',
                            child: Icon(
                              Icons.directions_walk,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.tanggalInteraksi)}',
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
                            message: 'Jam Interaksi',
                            child: Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setNull(widget.jamInteraksi)}',
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
                            message: 'Status Interaksi',
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              '${setStatusInteraksi(widget.status)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat Regular',
                                  color:
                                      setColorStatusInteraksi(widget.status)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )))
            ])));
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setColorStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return Colors.blue;
    } else if (nilai == '1') {
      return Colors.green;
    } else if (nilai == '11') {
      return Colors.red;
    }
  }

  setStatusInteraksi(String nilai) {
    if (nilai == '0') {
      return 'MENUNGGU PERSETUJUAN';
    } else if (nilai == '1') {
      return 'INTERAKSI DI SETUJUI';
    } else if (nilai == '11') {
      return 'INTERAKSI DI TOLAK';
    }
  }
}
