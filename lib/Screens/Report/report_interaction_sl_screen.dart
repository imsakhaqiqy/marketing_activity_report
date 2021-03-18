import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/filter_interaction_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_interaction_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportInteractionSlScreen extends StatefulWidget {
  @override
  _ReportInteractionSlScreen createState() => _ReportInteractionSlScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportInteractionSlScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportInteractionSlScreen extends State<ReportInteractionSlScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 13,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.bold);
    var cardTextStyleFooter1 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 12,
        color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyleFooter2 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 9,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Laporan Interaksi',
          style: fontFamily,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FilterInteractionSlScreen(widget.nik)));
                },
                child: Icon(Icons.filter_list),
              )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ReportInteractionSlProvider>(context, listen: false)
                  .getInteractionSlReport(ReportInteractionSlItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<ReportInteractionSlProvider>(context,
                      listen: false)
                  .getInteractionSlReport(ReportInteractionSlItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<ReportInteractionSlProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteractionSlReport.length);
                    if (data.dataInteractionSlReport.length == 0) {
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
                                    child: Icon(Icons.hourglass_empty_outlined,
                                        size: 70),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Interaksi Tidak Ditemukan!',
                                style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      );
                    } else {
                      return GridView.builder(
                          itemCount: data.dataInteractionSlReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataInteractionSlReport[i].calonDebitur
                                    .length >
                                15) {
                              calonDebitur = data
                                  .dataInteractionSlReport[i].calonDebitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur =
                                  data.dataInteractionSlReport[i].calonDebitur;
                            }

                            if (data.dataInteractionSlReport[i].plafond != '') {
                              if (data.dataInteractionSlReport[i].plafond
                                      .length >
                                  15) {
                                rencanaPinjaman =
                                    data.dataInteractionSlReport[i].plafond;
                              } else {
                                rencanaPinjaman =
                                    data.dataInteractionSlReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
                            }

                            if (data.dataInteractionSlReport[i].alamat != '') {
                              if (data.dataInteractionSlReport[i].alamat
                                      .length >
                                  15) {
                                alamat = data.dataInteractionSlReport[i].alamat;
                              } else {
                                alamat = data.dataInteractionSlReport[i].alamat;
                              }
                            } else {
                              alamat = '';
                            }

                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          InteractionViewScreen(
                                              data.dataInteractionSlReport[i]
                                                  .calonDebitur,
                                              data.dataInteractionSlReport[i]
                                                  .alamat,
                                              data.dataInteractionSlReport[i]
                                                  .email,
                                              data.dataInteractionSlReport[i]
                                                  .telepon,
                                              data.dataInteractionSlReport[i]
                                                  .plafond,
                                              data.dataInteractionSlReport[i]
                                                  .salesFeedback,
                                              data.dataInteractionSlReport[i]
                                                  .foto,
                                              data.dataInteractionSlReport[i]
                                                  .tanggalInteraksi,
                                              data.dataInteractionSlReport[i]
                                                  .jamInteraksi,
                                              data.dataInteractionSlReport[i]
                                                  .statusInteraksi)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.network(
                                          'https://www.nabasa.co.id/marsit/${data.dataInteractionSlReport[i].foto}',
                                          fit: BoxFit.contain,
                                        ),
                                        height: 100.0,
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$calonDebitur',
                                            style: cardTextStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$rencanaPinjaman',
                                            style: cardTextStyleChild,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataInteractionSlReport[i].tanggalInteraksi}',
                                            style: cardTextStyleFooter1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_outline,
                                                color: kPrimaryColor),
                                            Expanded(
                                              child: Text(
                                                '${data.dataInteractionSlReport[i].namasales}',
                                                style: cardTextStyleFooter2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                  },
                );
              },
            ),
          )),
    );
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
