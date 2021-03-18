import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_add.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/not_aktif_screen.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/planning_interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class InteractionScreen extends StatefulWidget {
  @override
  _InteractionScreen createState() => _InteractionScreen();

  String username;
  String nik;
  String hakAkses;

  InteractionScreen(this.username, this.nik, this.hakAkses);
}

class _InteractionScreen extends State<InteractionScreen> {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.white);
    var cardTextStyle1 =
        TextStyle(fontFamily: "Montserrat Regular", fontSize: 14);
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Hasil Interaksi',
          style: fontFamily,
        ),
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<InteractionProvider>(context, listen: false)
                  .getInteraction(InteractionItem(widget.nik)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<InteractionProvider>(context, listen: false)
                  .getInteraction(InteractionItem(widget.nik)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<InteractionProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteraction.length);
                    if (data.dataInteraction.length == 0) {
                      return Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.directions_walk_outlined,
                                        size: 70),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Interaksi Yuk!',
                                style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Dapatkan keuntungan besar di setiap interaksimu.',
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
                                              PlanningInteractionScreen(
                                                  widget.username,
                                                  widget.nik,
                                                  widget.hakAkses)));
                                },
                                child: Text(
                                  'Lihat Rencana Interaksi',
                                  style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.dataInteraction.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  elevation: 4,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InteractionViewScreen(
                                                    data.dataInteraction[i]
                                                        .calonDebitur,
                                                    data.dataInteraction[i]
                                                        .alamat,
                                                    data.dataInteraction[i]
                                                        .email,
                                                    data.dataInteraction[i]
                                                        .telepon,
                                                    data.dataInteraction[i]
                                                        .plafond,
                                                    data.dataInteraction[i]
                                                        .salesFeedback,
                                                    data.dataInteraction[i]
                                                        .foto,
                                                    data.dataInteraction[i]
                                                        .tanggalInteraksi,
                                                    data.dataInteraction[i]
                                                        .jamInteraksi,
                                                    data.dataInteraction[i]
                                                        .statusInteraksi,
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Tooltip(
                                            message: messageStatus(
                                                '${data.dataInteraction[i].statusInteraksi}'),
                                            child: Icon(
                                              iconStatus(
                                                  '${data.dataInteraction[i].statusInteraksi}'),
                                              color: colorStatus(
                                                  '${data.dataInteraction[i].statusInteraksi}'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            data.dataInteraction[i]
                                                .calonDebitur,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    'Montserrat Regular'),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Plafond: ${data.dataInteraction[i].plafond}',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Montserrat Regular'),
                                      ),
                                      trailing: Text(
                                        '${data.dataInteraction[i].tanggalInteraksi}',
                                        style: fontFamily,
                                      ),
                                    ),
                                  ),
                                );
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
    );
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Sudah di interaksi';
    } else if (status == '1') {
      return 'Disetujui Sales Leader';
    } else if (status == '11') {
      return 'Ditolak Sales Leader ';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Icons.info;
    } else if (status == '1') {
      return Icons.check;
    } else if (status == '11') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == '0') {
      return Colors.blue;
    } else if (status == '1') {
      return Colors.green;
    } else if (status == '11') {
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
