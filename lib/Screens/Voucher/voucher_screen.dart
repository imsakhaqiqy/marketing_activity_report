import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/constants.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  String username;
  String nik;
  String tarif;

  VoucherScreen(this.username, this.nik, this.tarif);
  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle1 = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.grey);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'VOUCHER',
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () =>
                Provider.of<DisbursmentProvider>(context, listen: false)
                    .getDisbursment(DisbursmentItem(widget.nik)),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                future: Provider.of<DisbursmentProvider>(context, listen: false)
                    .getDisbursment(DisbursmentItem(widget.nik)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                    );
                  }
                  return Consumer<DisbursmentProvider>(
                    builder: (context, data, _) {
                      if (data.dataDisbursment.length == 0) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading:
                                      Icon(Icons.hourglass_empty, size: 50),
                                  title: Text(
                                    'DATA TIDAK DITEMUKAN',
                                    style: cardTextStyle1,
                                  ),
                                  subtitle: Text(''),
                                ),
                              ]),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.dataDisbursment.length,
                            itemBuilder: (context, i) {
                              double nominal =
                                  double.parse(data.dataDisbursment[i].plafond);
                              double jumlah =
                                  nominal * double.parse(widget.tarif) / 100;
                              return Card(
                                color: Colors.tealAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.attach_money,
                                                size: 50,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        title: Text(
                                          '${formatRupiah(jumlah.toString())}',
                                          style: TextStyle(
                                              fontFamily: "Montserrat Regular",
                                              fontSize: 30,
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                            'KODE : ${data.dataDisbursment[i].id}'),
                                        trailing: Tooltip(
                                            message: messageStatus(data
                                                .dataDisbursment[i]
                                                .statusBayar),
                                            child: iconStatus(data
                                                .dataDisbursment[i]
                                                .statusBayar)),
                                      ),
                                    ]),
                              );
                            });
                      }
                    },
                  );
                },
              ),
            )));
  }

  messageStatus(String status) {
    if (status == '0') {
      return 'Belum Dibayar';
    } else {
      return 'Sudah Dibayar';
    }
  }

  iconStatus(String status) {
    if (status == '0') {
      return Icon(
        Icons.info,
        size: 30,
      );
    } else {
      return Icon(
        Icons.check,
        size: 30,
      );
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
