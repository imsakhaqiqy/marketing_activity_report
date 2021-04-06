import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_add.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_add_new.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_edit.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_root_screen.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_akad_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentAkadScreen extends StatefulWidget {
  @override
  _DisbursmentAkadScreen createState() => _DisbursmentAkadScreen();

  String username;
  String nik;

  DisbursmentAkadScreen(this.username, this.nik);
}

_showPopupMenu(
        String username,
        String nik,
        String idPipeline,
        String namaPensiun,
        String alamat,
        String telepon,
        String selectedJenisDebitur,
        String selectedJenisProduk,
        String tanggalAkad,
        String nomorAplikasi,
        String nomorPerjanjian,
        String selectedJenisCabang,
        String plafond,
        String selectedJenisInfo,
        String selectedStatusKredit,
        String namaPetugasBank,
        String jabatanPetugasBank,
        String teleponPetugasBank,
        String selectedPengelolaPensiun) =>
    PopupMenuButton<int>(
      padding: EdgeInsets.only(left: 2),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DisbursmentAddNewScreen(
                      username,
                      nik,
                      '',
                      namaPensiun,
                      alamat,
                      telepon,
                      selectedJenisDebitur,
                      selectedJenisProduk,
                      tanggalAkad,
                      nomorAplikasi,
                      nomorPerjanjian,
                      selectedJenisCabang,
                      plafond,
                      selectedJenisInfo,
                      selectedStatusKredit,
                      namaPetugasBank,
                      jabatanPetugasBank,
                      teleponPetugasBank,
                      selectedPengelolaPensiun,
                      idPipeline)));
            },
            child: Tooltip(
                message: 'Pencairan',
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money_sharp,
                      color: Colors.teal,
                      size: 20,
                    ),
                    Text('Pencairan')
                  ],
                )),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 20),
    );

class _DisbursmentAkadScreen extends State<DisbursmentAkadScreen> {
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getDisbursmentAkad';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Disbursment_Akad'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Disbursment_Akad'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _idPipeline(dynamic user) {
    return user['id_pipeline'];
  }

  String _debitur(dynamic user) {
    return user['debitur'];
  }

  String _tanggalAkad(dynamic user) {
    return user['tanggal_akad'];
  }

  String _nomorAplikasi(dynamic user) {
    return user['nomor_aplikasi'];
  }

  String _nomorPerjanjian(dynamic user) {
    return user['nomor_perjanjian'];
  }

  String _nominalPinjaman(dynamic user) {
    return user['nominal_pinjaman'];
  }

  String _jenisProduk(dynamic user) {
    return user['jenis_produk'];
  }

  String _salesInfo(dynamic user) {
    return user['sales_info'];
  }

  String _namaPetugasBank(dynamic user) {
    return user['nama_petugas_bank'];
  }

  String _jabatanPetugasBank(dynamic user) {
    return user['jabatan_petugas_bank'];
  }

  String _teleponPetugasBank(dynamic user) {
    return user['telepon_petugas_bank'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _selectedJenisDebitur(dynamic user) {
    return user['selected_jenis_debitur'];
  }

  String _selectedJenisProduk(dynamic user) {
    return user['selected_jenis_produk'];
  }

  String _selectedJenisCabang(dynamic user) {
    return user['selected_jenis_cabang'];
  }

  String _selectedJenisInfo(dynamic user) {
    return user['selected_jenis_info'];
  }

  String _selectedStatusKredit(dynamic user) {
    return user['selected_status_kredit'];
  }

  String _selectedPengelolaPensiun(dynamic user) {
    return user['selected_pengelola_pensiun'];
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Akad Kredit',
          style: fontFamily,
        ),
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
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
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            _debitur(_users[index]),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat Regular'),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Plafond',
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatRupiah(_nominalPinjaman(_users[index])),
                                style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Tanggal Akad',
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _tanggalAkad(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Nomor Aplikasi',
                                child: Icon(
                                  Icons.confirmation_number_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _nomorAplikasi(_users[index]),
                                style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          _showPopupMenu(
                            widget.username,
                            widget.nik,
                            _idPipeline(_users[index]),
                            _debitur(_users[index]),
                            _alamat(_users[index]),
                            _telepon(_users[index]),
                            _selectedJenisDebitur(_users[index]),
                            _selectedJenisProduk(_users[index]),
                            _tanggalAkad(_users[index]),
                            _nomorAplikasi(_users[index]),
                            _nomorPerjanjian(_users[index]),
                            _selectedJenisCabang(_users[index]),
                            _nominalPinjaman(_users[index]),
                            _selectedJenisInfo(_users[index]),
                            _selectedStatusKredit(_users[index]),
                            _namaPetugasBank(_users[index]),
                            _jabatanPetugasBank(_users[index]),
                            _teleponPetugasBank(_users[index]),
                            _selectedPengelolaPensiun(_users[index]),
                          ),
                        ],
                      ),
                    ),
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
              'Akad Kredit Yuk!',
              style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dapatkan insentif besar dari pencairanmu.',
              style: TextStyle(
                fontFamily: "Montserrat Regular",
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PipelineRootPage(widget.username, widget.nik)));
              },
              child: Text(
                'Lihat Pipeline',
                style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        );
      }
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
