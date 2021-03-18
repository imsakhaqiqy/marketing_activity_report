import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/filter_interaction_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_interaction_sl_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class FilterInteractionSlReportScreen extends StatefulWidget {
  @override
  _FilterInteractionSlReportScreen createState() =>
      _FilterInteractionSlReportScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  FilterInteractionSlReportScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _FilterInteractionSlReportScreen
    extends State<FilterInteractionSlReportScreen> {
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
          onRefresh: () => Provider.of<FilterReportInteractionSlProvider>(
                  context,
                  listen: false)
              .getInteractionFilterSlReport(FilterReportInteractionSlItem(
                  widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Provider.of<FilterReportInteractionSlProvider>(context,
                      listen: false)
                  .getInteractionFilterSlReport(FilterReportInteractionSlItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<FilterReportInteractionSlProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteractionFilterSlReport.length);
                    if (data.dataInteractionFilterSlReport.length == 0) {
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
                          itemCount: data.dataInteractionFilterSlReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataInteractionFilterSlReport[i]
                                    .calonDebitur.length >
                                15) {
                              calonDebitur = data
                                  .dataInteractionFilterSlReport[i].calonDebitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur = data
                                  .dataInteractionFilterSlReport[i]
                                  .calonDebitur;
                            }

                            if (data.dataInteractionFilterSlReport[i].plafond !=
                                '') {
                              if (data.dataInteractionFilterSlReport[i].plafond
                                      .length >
                                  15) {
                                rencanaPinjaman = data
                                    .dataInteractionFilterSlReport[i].plafond;
                              } else {
                                rencanaPinjaman = data
                                    .dataInteractionFilterSlReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
                            }

                            if (data.dataInteractionFilterSlReport[i].alamat !=
                                '') {
                              if (data.dataInteractionFilterSlReport[i].alamat
                                      .length >
                                  15) {
                                alamat = data
                                    .dataInteractionFilterSlReport[i].alamat;
                              } else {
                                alamat = data
                                    .dataInteractionFilterSlReport[i].alamat;
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
                                      builder: (context) => InteractionViewScreen(
                                          data.dataInteractionFilterSlReport[i]
                                              .calonDebitur,
                                          data.dataInteractionFilterSlReport[i]
                                              .alamat,
                                          data.dataInteractionFilterSlReport[i]
                                              .email,
                                          data.dataInteractionFilterSlReport[i]
                                              .telepon,
                                          data.dataInteractionFilterSlReport[i]
                                              .plafond,
                                          data.dataInteractionFilterSlReport[i]
                                              .salesFeedback,
                                          data.dataInteractionFilterSlReport[i]
                                              .foto,
                                          data.dataInteractionFilterSlReport[i]
                                              .tanggalInteraksi,
                                          data.dataInteractionFilterSlReport[i]
                                              .jamInteraksi,
                                          data.dataInteractionFilterSlReport[i]
                                              .statusInteraksi)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.network(
                                          'https://www.nabasa.co.id/marsit/${data.dataInteractionFilterSlReport[i].foto}',
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
                                            '${data.dataInteractionFilterSlReport[i].tanggalInteraksi}',
                                            style: cardTextStyleFooter1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${data.dataInteractionFilterSlReport[i].namaSales}',
                                            style: cardTextStyleFooter1,
                                          ),
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
