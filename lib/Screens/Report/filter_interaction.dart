import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../constants.dart';
import 'filter_interaction_screen.dart';

// ignore: must_be_immutable
class FilterInteractionReportScreen extends StatefulWidget {
  @override
  _FilterInteractionReportScreen createState() =>
      _FilterInteractionReportScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  FilterInteractionReportScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _FilterInteractionReportScreen
    extends State<FilterInteractionReportScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 13,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.bold);
    var cardTextStyleFooter1 = TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 12,
        color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyleFooter2 = TextStyle(
        fontFamily: "Roboto-Regular",
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
                              FilterInteractionScreen(widget.nik)));
                },
                child: Icon(Icons.filter_list),
              )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () => Provider.of<FilterReportInteractionProvider>(context,
                  listen: false)
              .getInteractionFilterReport(FilterReportInteractionItem(
                  widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            child: FutureBuilder(
              future: Provider.of<FilterReportInteractionProvider>(context,
                      listen: false)
                  .getInteractionFilterReport(FilterReportInteractionItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<FilterReportInteractionProvider>(
                  builder: (context, data, _) {
                    print(data.dataInteractionFilterReport.length);
                    if (data.dataInteractionFilterReport.length == 0) {
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
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      );
                    } else {
                      return GridView.builder(
                          itemCount: data.dataInteractionFilterReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataInteractionFilterReport[i].calonDebitur
                                    .length >
                                15) {
                              calonDebitur = data
                                  .dataInteractionFilterReport[i].calonDebitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur = data
                                  .dataInteractionFilterReport[i].calonDebitur;
                            }

                            if (data.dataInteractionFilterReport[i].plafond !=
                                '') {
                              if (data.dataInteractionFilterReport[i].plafond
                                      .length >
                                  15) {
                                rencanaPinjaman =
                                    data.dataInteractionFilterReport[i].plafond;
                              } else {
                                rencanaPinjaman =
                                    data.dataInteractionFilterReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
                            }

                            if (data.dataInteractionFilterReport[i].alamat !=
                                '') {
                              if (data.dataInteractionFilterReport[i].alamat
                                      .length >
                                  15) {
                                alamat =
                                    data.dataInteractionFilterReport[i].alamat;
                              } else {
                                alamat =
                                    data.dataInteractionFilterReport[i].alamat;
                              }
                            } else {
                              alamat = '';
                            }

                            return Card(
                              elevation: 0,
                              child: GridTile(
                                footer: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: kPrimaryColor,
                                        size: 12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '$alamat',
                                          style: cardTextStyleFooter2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InteractionViewScreen(
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .calonDebitur,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .alamat,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .email,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .telepon,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .plafond,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .salesFeedback,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .foto,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .tanggalInteraksi,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .jamInteraksi,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .statusInteraksi,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .kelurahan,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .kecamatan,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .kabupaten,
                                                    data
                                                        .dataInteractionFilterReport[
                                                            i]
                                                        .propinsi,
                                                  )));
                                    },
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            child: Image.network(
                                              'https://www.nabasa.co.id/marsit/${data.dataInteractionFilterReport[i].foto}',
                                              fit: BoxFit.cover,
                                            ),
                                            height: 100.0,
                                            width: double.infinity,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '$calonDebitur',
                                              style: cardTextStyle,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              formatRupiah(rencanaPinjaman),
                                              style: cardTextStyleChild,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${data.dataInteractionFilterReport[i].tanggalInteraksi}',
                                              style: cardTextStyleFooter1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ]),
                                  ),
                                ),
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
