import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        title: new Text('History Diamond'),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator());
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
                        title: Text(
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
                        subtitle: Text(
                          _createdAt(_users[index]),
                          style: setStyle(
                            _kodeTransaksi(_users[index]),
                            _debit(_users[index]),
                            _kredit(_users[index]),
                          ),
                        ),
                        trailing: Text(
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
        return Container(
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/images/box.svg',
                height: 50,
              ),
              title: Text('DATA TIDAK DITEMUKAN'),
            ),
          ),
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
      return '+ ' + debit + ' DIAMOND';
    } else if (x == 'pnc') {
      return '+ ' + debit + ' DIAMOND';
    } else {
      return '- ' + kredit + ' DIAMOND';
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
