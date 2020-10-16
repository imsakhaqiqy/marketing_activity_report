import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Approval/approval_interaksi_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:http/http.dart' as http;

class ApprovalInteractionViewScreen extends StatefulWidget {
  String username;
  String nik;
  String hakAkses;
  String nikSdm;
  String id;
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
  String namaSales;

  ApprovalInteractionViewScreen(
      this.username,
      this.nik,
      this.hakAkses,
      this.nikSdm,
      this.id,
      this.calonDebitur,
      this.alamat,
      this.email,
      this.telepon,
      this.rencanaPinjaman,
      this.salesFeedback,
      this.foto,
      this.tanggalInteraksi,
      this.jamInteraksi,
      this.status,
      this.namaSales);
  @override
  _ApprovalInteractionViewScreenState createState() =>
      _ApprovalInteractionViewScreenState();
}

class _ApprovalInteractionViewScreenState
    extends State<ApprovalInteractionViewScreen> {
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
        'https://www.nabasa.co.id/api_marsit_v1/index.php/ApprovalInteraction';

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'approval_sl': '1',
      'rekom_sl': 'approve',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Approval_Interaction'];
      print(message);
      if (message == 'Save Success') {
        setState(() {
          _loadingA = false;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ApprovalInteractionScreen(
                widget.username, widget.nik, widget.hakAkses, widget.nikSdm)));
      } else {
        setState(() {
          _loadingA = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Interaksi gagal disetujui...'),
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

  Future rejectInteraksi() async {
    //showing CircularProgressIndicator
    setState(() {
      _loadingR = true;
    });
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/RejectInteraction';

    //starting web api call
    var response = await http.post(url, body: {
      'id_nya': widget.id.toString(),
      'approval_sl': '11',
      'rekom_sl': 'reject',
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Reject_Interaction'];
      if (message.toString() == 'Save Success') {
        setState(() {
          _loadingR = false;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ApprovalInteractionScreen(
                widget.username, widget.nik, widget.hakAkses, widget.nikSdm)));
      } else {
        setState(() {
          _loadingR = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Interaksi gagal ditolak...'),
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
                            child: Text('${widget.namaSales}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat Regular',
                                  color: Colors.black,
                                )),
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
                      ),
                    ],
                  ))
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
