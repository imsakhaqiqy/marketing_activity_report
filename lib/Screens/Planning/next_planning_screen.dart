import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class NextPlanningScreen extends StatefulWidget {
  String username;
  String niksales;
  List<String> notas;
  List<String> nama;
  String tglInteraksi;

  NextPlanningScreen(
      this.username, this.niksales, this.notas, this.nama, this.tglInteraksi);
  @override
  _NextPlanningScreenState createState() => _NextPlanningScreenState();
}

class _NextPlanningScreenState extends State<NextPlanningScreen> {
  String notasnya = '';
  var personalData = new List(38);
  bool visible = false;

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.niksales;

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

  Future simpanRencana() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
      for (int a = 0; a < widget.notas.length; a++) {
        if (a == widget.notas.length - 1) {
          notasnya += widget.notas[a];
        } else {
          notasnya += widget.notas[a] + ',';
        }
      }
    });

    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/savePlanningInteraction';
    //starting web api call
    var response = await http.post(url, body: {
      'niksales': widget.niksales,
      'notas': notasnya,
      'tgl_interaksi': widget.tglInteraksi
    });
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Planning_Interaction'];
      //print(message);
      if (message['message'].toString() == 'Save Success') {
        setState(() {
          visible = false;
          notasnya = '';
        });
        userLogin();
        Toast.show(
          'Sukses menambahkan data rencana interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
          notasnya = '';
        });
        Toast.show(
          'Gagal menambahkan data rencana interaksi...',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          visible
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        'Mohon menunggu, sedang proses penyimpanan rencana interaksi...'),
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
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text(
                'Tambah Rencana Interaksi',
                style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: ListView.builder(
                itemCount: widget.notas.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${widget.nama[i]}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Regular'),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          '${widget.notas[i]}',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Roboto-Regular'),
                        ),
                        trailing: null),
                  );
                },
              ),
            ),
            bottomSheet: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: Colors.black12,
              ))),
              padding: EdgeInsets.all(16),
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          widget.notas.length.toString() + ' data dipilih',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Roboto-Regular',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: null)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Row(children: <Widget>[
                          Icon(Icons.directions_walk, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.tglInteraksi,
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.blueGrey,
                                  fontSize: 16.0),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: FlatButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              simpanRencana();
                              //print(widget.notas.length);
                            },
                            child: visible
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                    height: 20.0,
                                    width: 20.0,
                                  )
                                : Text(
                                    'Simpan',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto-Regular'),
                                  )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
