import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class LogDiamondScreen extends StatefulWidget {
  String niksales;

  LogDiamondScreen(this.niksales);
  @override
  _LogDiamondScreen createState() => _LogDiamondScreen();
}

class _LogDiamondScreen extends State<LogDiamondScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getLogDiamondx';

  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'niksales': widget.niksales});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_LogDiamond'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_LogDiamond'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _nik(dynamic user) {
    return user['nik'];
  }

  String _kodeTransaksi(dynamic user) {
    return user['kode_transaksi'];
  }

  String _debit(dynamic user) {
    return user['debit'];
  }

  String _kredit(dynamic user) {
    return user['kredit'];
  }

  String _createdAt(dynamic user) {
    return user['created_at'];
  }

  String _updatedAt(dynamic user) {
    return user['updated_at'];
  }

  String _trxRef(dynamic user) {
    return user['trx_ref'];
  }

  String _ref(dynamic user) {
    return user['ref'];
  }

  String _number(dynamic user) {
    return user['number'];
  }

  String _code(dynamic user) {
    return user['code'];
  }

  String _status(dynamic user) {
    return user['status'];
  }

  String _message(dynamic user) {
    return user['status'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Riwayat Diamond'),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.info_outlined,
                              color: Colors.black54,
                              size: 15,
                            ),
                            Text(
                              setKeterangan(
                                _kodeTransaksi(_users[index]),
                                _code(_users[index]),
                                _number(_users[index]),
                                _message(_users[index]),
                              ),
                              style: setStyle(
                                _kodeTransaksi(_users[index]),
                                _debit(_users[index]),
                                _kredit(_users[index]),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.black54,
                              size: 15,
                            ),
                            Text(_createdAt(_users[index]),
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                        trailing: Column(
                          children: <Widget>[
                            Text(
                              setDiamond(
                                _kodeTransaksi(_users[index]),
                                _debit(_users[index]),
                                _kredit(_users[index]),
                              ),
                              style: setStyle(
                                _kodeTransaksi(_users[index]),
                                _debit(_users[index]),
                                _kredit(_users[index]),
                              ),
                            ),
                            Icon(
                              MdiIcons.diamond,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Riwayat diamond belum tersedia',
              style: TextStyle(
                  fontFamily: "Roboto-Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }

  setKeterangan(
      String kodeTransaksi, String code, String number, String message) {
    String x = kodeTransaksi.substring(0, 3);
    if (x == 'int') {
      return 'Interaksi';
    } else if (x == 'pnc') {
      return 'Pencairan';
    } else {
      return 'Isi Pulsa ' +
          setNull(code) +
          ' ' +
          setNull(number) +
          ' ' +
          setNull(message);
    }
  }

  setDiamond(String kodeTransaksi, String debit, String kredit) {
    String x = kodeTransaksi.substring(0, 3);
    if (x == 'int') {
      return '+ ' + debit;
    } else if (x == 'pnc') {
      return '+ ' + debit;
    } else {
      return '- ' + kredit;
    }
  }

  setNull(String data) {
    if (data == null || data == '') {
      return 'NULL';
    } else {
      return data;
    }
  }

  setStyle(String kodeTransaksi, String debit, String kredit) {
    String x = kodeTransaksi.substring(0, 3);
    if (x == 'int') {
      return TextStyle(color: Colors.blue);
    } else if (x == 'pnc') {
      return TextStyle(color: Colors.blue);
    } else {
      return TextStyle(color: Colors.red);
    }
  }
}
