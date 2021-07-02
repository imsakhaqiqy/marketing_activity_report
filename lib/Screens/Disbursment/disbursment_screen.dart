import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_akad_screen.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_edit_new.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DisbursmentScreen extends StatefulWidget {
  @override
  _DisbursmentScreen createState() => _DisbursmentScreen();

  String username;
  String nik;
  String statusKaryawan;
  String personalData;

  DisbursmentScreen(
      this.username, this.nik, this.statusKaryawan, this.personalData);
}

class _DisbursmentScreen extends State<DisbursmentScreen> {
  bool visible = false;
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getDisbursment';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Disbursment'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Disbursment'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _debitur(dynamic user) {
    return user['debitur'];
  }

  String _nomorAkad(dynamic user) {
    return user['nomor_akad'];
  }

  String _plafond(dynamic user) {
    return user['plafond'];
  }

  String _cabang(dynamic user) {
    return user['cabang'];
  }

  String _tanggalAkad(dynamic user) {
    return user['tanggal_akad'];
  }

  String _alamat(dynamic user) {
    return user['alamat'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _noJanji(dynamic user) {
    return user['no_janji'];
  }

  String _jenisPencairan(dynamic user) {
    return user['jenis_pencairan'];
  }

  String _jenisProduk(dynamic user) {
    return user['jenis_produk'];
  }

  String _infoSales(dynamic user) {
    return user['info_sales'];
  }

  String _foto1(dynamic user) {
    return user['foto1'];
  }

  String _foto2(dynamic user) {
    return user['foto2'];
  }

  String _foto3(dynamic user) {
    return user['foto3'];
  }

  String _tanggalPencairan(dynamic user) {
    return user['tgl_pencairan'];
  }

  String _jamPencairan(dynamic user) {
    return user['jam_pencairan'];
  }

  String _statusPencairan(dynamic user) {
    return user['status_pencairan'];
  }

  String _statusBayar(dynamic user) {
    return user['status_bayar'];
  }

  String _approvalSl(dynamic user) {
    return user['approval_sl'];
  }

  String _namaTl(dynamic user) {
    return user['nama_tl'];
  }

  String _jabatanTl(dynamic user) {
    return user['jabatan_tl'];
  }

  String _teleponTl(dynamic user) {
    return user['telepon_tl'];
  }

  String _namaSales(dynamic user) {
    return user['namasales'];
  }

  String _statusKredit(dynamic user) {
    return user['status_kredit'];
  }

  String _pengelolaPensiun(dynamic user) {
    return user['pengelola_pensiun'];
  }

  String _bankTakeover(dynamic user) {
    return user['bank_takeover'];
  }

  String _idPipeline(dynamic user) {
    return user['id_pipeline'];
  }

  String _tanggalPipeline(dynamic user) {
    return user['tgl_pipeline'];
  }

  String _tempatLahir(dynamic user) {
    return user['tempat_lahir'];
  }

  String _tanggalLahir(dynamic user) {
    return user['tgl_lahir'];
  }

  String _jenisKelamin(dynamic user) {
    return user['jenis_kelamin'];
  }

  String _noKtp(dynamic user) {
    return user['no_ktp'];
  }

  String _npwp(dynamic user) {
    return user['npwp'];
  }

  String _statusPipeline(dynamic user) {
    return user['status'];
  }

  String _tanggalPenyerahan(dynamic user) {
    return user['tgl_penyerahan'];
  }

  String _namaPenerima(dynamic user) {
    return user['nama_penerima'];
  }

  String _teleponPenerima(dynamic user) {
    return user['telepon_penerima'];
  }

  String _kodeProduk(dynamic user) {
    return user['kode_produk'];
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

  var personalData = new List(38);

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

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

  Future deleteDisbursment(String id, String idPipeline) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/deleteDisbursment';
    var response = await http.post(url, body: {
      'id_disbursment': id,
      'id_pipeline': idPipeline,
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Disbursment'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses hapus pencairan',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        userLogin();
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal hapus pencairan',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  setAksesEdit(String tglPencairan, String tglCutOff) {
    final a = DateTimeFormat.format(DateTime.parse(tglPencairan), format: 'U');
    final b = DateTimeFormat.format(DateTime.parse(tglCutOff), format: 'U');
    if (int.parse(a) > int.parse(b)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          title: Text(
            'Pencairan',
            style: fontFamily,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Toast.show(
                  'Pencairan Kredit ' + bulan + ' ' + tahun,
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: Colors.blueAccent,
                );
              },
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Tambah Pencairan',
          backgroundColor: kPrimaryColor,
          child: Text('+',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DisbursmentAkadScreen(widget.username, widget.nik)));
          },
        ),
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
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DisbursmentViewScreen(
                            _debitur(_users[index]),
                            _alamat(_users[index]),
                            _telepon(_users[index]),
                            _tanggalAkad(_users[index]),
                            _nomorAkad(_users[index]),
                            _noJanji(_users[index]),
                            _plafond(_users[index]),
                            _jenisPencairan(_users[index]),
                            _jenisProduk(_users[index]),
                            _cabang(_users[index]),
                            _infoSales(_users[index]),
                            _foto1(_users[index]),
                            _foto2(_users[index]),
                            _foto3(_users[index]),
                            _tanggalPencairan(_users[index]),
                            _jamPencairan(_users[index]),
                            _namaTl(_users[index]),
                            _jabatanTl(_users[index]),
                            _teleponTl(_users[index]),
                            _namaSales(_users[index]),
                            _cabang(_users[index]),
                            _infoSales(_users[index]),
                            _statusPipeline(_users[index]),
                            _statusKredit(_users[index]),
                            _pengelolaPensiun(_users[index]),
                            _bankTakeover(_users[index]),
                            _tanggalPenyerahan(_users[index]),
                            _namaPenerima(_users[index]),
                            _teleponPenerima(_users[index]),
                            _tanggalPipeline(_users[index]),
                            _tempatLahir(_users[index]),
                            _tanggalLahir(_users[index]),
                            _jenisKelamin(_users[index]),
                            _noKtp(_users[index]),
                            _npwp(_users[index]),
                            _kodeProduk(_users[index]))));
                  },
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
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
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
                                formatRupiah(_plafond(_users[index])),
                                style: TextStyle(fontFamily: 'Roboto-Regular'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Tanggal Pencairan',
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _tanggalPencairan(_users[index]),
                                style: fontFamily,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Tooltip(
                                message: 'Status Pencairan',
                                child: Icon(
                                  Icons.info,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                messageStatus(
                                    _statusPencairan(_users[index]),
                                    widget.statusKaryawan,
                                    _approvalSl(_users[index])),
                                style: fontFamily,
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if ((widget.statusKaryawan == 'MARKETING AGEN' &&
                                  _approvalSl(_users[index]) != '4')) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DisbursmentEditNewScreen(
                                      widget.username,
                                      widget.nik,
                                      '',
                                      _debitur(_users[index]),
                                      _alamat(_users[index]),
                                      _telepon(_users[index]),
                                      _tanggalAkad(_users[index]),
                                      _jenisProduk(_users[index]),
                                      _tanggalAkad(_users[index]),
                                      _nomorAkad(_users[index]),
                                      _noJanji(_users[index]),
                                      _cabang(_users[index]),
                                      _plafond(_users[index]),
                                      _infoSales(_users[index]),
                                      _statusKredit(_users[index]),
                                      _namaTl(_users[index]),
                                      _jabatanTl(_users[index]),
                                      _teleponTl(_users[index]),
                                      _pengelolaPensiun(_users[index]),
                                      _idPipeline(_users[index]),
                                      _tanggalPencairan(_users[index]),
                                      _foto3(_users[index]),
                                    ),
                                  ),
                                );
                              } else if ((widget.statusKaryawan !=
                                      'MARKETING AGEN' &&
                                  _statusPencairan(_users[index]) ==
                                      'success' &&
                                  setAksesEdit(
                                          _tanggalPencairan(_users[index]) +
                                              ' ' +
                                              _jamPencairan(_users[index]),
                                          widget.personalData) ==
                                      true)) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DisbursmentEditNewScreen(
                                      widget.username,
                                      widget.nik,
                                      '',
                                      _debitur(_users[index]),
                                      _alamat(_users[index]),
                                      _telepon(_users[index]),
                                      _tanggalAkad(_users[index]),
                                      _jenisProduk(_users[index]),
                                      _tanggalAkad(_users[index]),
                                      _nomorAkad(_users[index]),
                                      _noJanji(_users[index]),
                                      _cabang(_users[index]),
                                      _plafond(_users[index]),
                                      _infoSales(_users[index]),
                                      _statusKredit(_users[index]),
                                      _namaTl(_users[index]),
                                      _jabatanTl(_users[index]),
                                      _teleponTl(_users[index]),
                                      _pengelolaPensiun(_users[index]),
                                      _idPipeline(_users[index]),
                                      _tanggalPencairan(_users[index]),
                                      _foto3(_users[index]),
                                    ),
                                  ),
                                );
                              } else {
                                Toast.show(
                                  'Pencairan ' +
                                      messageStatus(
                                          _statusPencairan(_users[index]),
                                          widget.statusKaryawan,
                                          _approvalSl(_users[index])) +
                                      ', data tidak bisa di edit kembali',
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if ((widget.statusKaryawan != 'MARKETING AGEN' &&
                                      _statusPencairan(_users[index]) !=
                                          'success') ||
                                  (widget.statusKaryawan == 'MARKETING AGEN' &&
                                      _approvalSl(_users[index]) != '4')) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                        'Apakah Anda ingin menghapus pencairan debitur ' +
                                            _debitur(_users[index]) +
                                            ' ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Tidak'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteDisbursment(_id(_users[index]),
                                              _idPipeline(_users[index]));
                                        },
                                        child: Text('Ya'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Toast.show(
                                  'Pencairan ' +
                                      messageStatus(
                                          _statusPencairan(_users[index]),
                                          widget.statusKaryawan,
                                          _approvalSl(_users[index])) +
                                      ', data tidak bisa di hapus kembali',
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          )
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
              'Pencairan Kredit Yuk!',
              style: TextStyle(
                  fontFamily: "Roboto-Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dapatkan insentif besar dari pencairanmu.',
              style: TextStyle(
                fontFamily: "Roboto-Regular",
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              color: kPrimaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DisbursmentAkadScreen(widget.username, widget.nik)));
              },
              child: Text(
                'Lihat Akad Kredit',
                style: TextStyle(
                  fontFamily: "Roboto-Regular",
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status, String statusKaryawan, String bayar) {
    if (status == 'waiting') {
      return 'Menunggu Sales Leader';
    } else if (status == 'success') {
      if (statusKaryawan == 'MARKETING AGEN') {
        if (bayar == '4') {
          return 'Sudah dibayarkan';
        } else {
          return 'Disetujui Sales Leader';
        }
      } else {
        return 'Disetujui Sales Leader';
      }
    } else if (status == 'failed') {
      return 'Ditolak Sales Leader ';
    } else {
      return 'Menunggu Sales Leader';
    }
  }

  namaBulan(String bulan) {
    switch (bulan) {
      case '1':
        return 'Januari';
        break;
      case '2':
        return 'Februari';
        break;
      case '3':
        return 'Maret';
        break;
      case '4':
        return 'April';
        break;
      case '5':
        return 'Mei';
        break;
      case '6':
        return 'Juni';
        break;
      case '7':
        return 'Juli';
        break;
      case '8':
        return 'Agustus';
        break;
      case '9':
        return 'September';
        break;
      case '10':
        return 'Oktober';
        break;
      case '11':
        return 'November';
        break;
      case '12':
        return 'Desember';
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
}
