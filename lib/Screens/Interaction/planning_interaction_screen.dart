import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_add.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_add_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/planning_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class PlanningInteractionScreen extends StatefulWidget {
  @override
  _PlanningInteractionScreen createState() => _PlanningInteractionScreen();

  String username;
  String nik;
  String hakAkses;

  PlanningInteractionScreen(this.username, this.nik, this.hakAkses);
}

class _PlanningInteractionScreen extends State<PlanningInteractionScreen> {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rencana Interaksi',
          style: fontFamily,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InteractionScreen(
                            widget.username, widget.nik, widget.hakAkses)));
              },
              child: Tooltip(
                message: 'Daftar Interaksi Periode $bulan $tahun',
                child: Icon(Icons.view_list),
              ),
            ),
          ),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<PlanningInteractionProvider>(context, listen: false)
                  .getInteraction(InteractionItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<PlanningInteractionProvider>(context,
                      listen: false)
                  .getInteraction(InteractionItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<PlanningInteractionProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteraction.length);
                    if (data.dataInteraction.length == 0) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.hourglass_empty, size: 50),
                                title: Text(
                                  'RENCANA INTERAKSI TIDAK DITEMUKAN',
                                  style: cardTextStyle,
                                ),
                                subtitle: Text(''),
                              ),
                            ]),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.date_range, size: 50),
                                    title: Text(
                                      'JADWAL INTERAKSI HARI INI $hari-$bulan-$tahun',
                                      style: cardTextStyle,
                                    ),
                                    subtitle:
                                        Text('Selamat bekerja, sukses selalu'),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.dataInteraction.length,
                              itemBuilder: (context, i) {
                                return Card(
                                    elevation: 4,
                                    child: InkWell(
                                      onTap: () {
                                        if (data.dataInteraction[i]
                                                    .visitStatus ==
                                                null ||
                                            data.dataInteraction[i]
                                                    .visitStatus ==
                                                '') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InteractionAddScreen(
                                                          widget.username,
                                                          widget.nik,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .nama,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .alamat,
                                                          '',
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .telepon,
                                                          'Database ',
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .kelurahan,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .kecamatan,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .provinsi,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .kabupaten,
                                                          data
                                                              .dataInteraction[
                                                                  i]
                                                              .nopen)));
                                        } else {
                                          showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text(
                                                  'Maaf, nasabah sudah di interaksi...'),
                                              actions: <Widget>[],
                                            ),
                                          );
                                        }
                                      },
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Tooltip(
                                              message: messageStatus(
                                                  '${data.dataInteraction[i].visitStatus}'),
                                              child: Icon(
                                                iconStatus(
                                                    '${data.dataInteraction[i].visitStatus}'),
                                                color: colorStatus(
                                                    '${data.dataInteraction[i].visitStatus}'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              data.dataInteraction[i].nama,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Montserrat Regular'),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Notas: ${data.dataInteraction[i].nopen}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Montserrat Regular'),
                                        ),
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        ],
                      );
                    }
                  },
                );
              },
            ),
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah rencana interaksi hari ini',
        backgroundColor: kPrimaryColor,
        child: Text('+',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlanningAddScreen(widget.username, widget.nik)));
        },
      ),
    );
  }

  messageStatus(String status) {
    if (status == '' || status == 'null') {
      return 'Belum di interaksi';
    } else if (status == 'valid') {
      return 'Sudah di interaksi';
    } else if (status == 'not_valid') {
      return 'Data tidak valid';
    }
  }

  iconStatus(String status) {
    if (status == '' || status == 'null') {
      return Icons.info;
    } else if (status == 'valid') {
      return Icons.check;
    } else if (status == 'not_valid') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == '' || status == 'null') {
      return Colors.blue;
    } else if (status == 'valid') {
      return Colors.green;
    } else if (status == 'not_valid') {
      return Colors.red;
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
