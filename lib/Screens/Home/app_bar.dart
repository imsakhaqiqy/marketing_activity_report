import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/Screens/Home/history_income_screen.dart';
import 'package:kreditpensiun_apps/Screens/News/news_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';

class MarsytAppBar extends AppBar {
  int income;
  String nik;

  MarsytAppBar(this.income, this.nik, BuildContext context)
      : super(
            elevation: 0.25,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace:
                _buildMarsytAppBar(income.toString(), nik.toString(), context));

  static Widget _buildMarsytAppBar(
      String income, String nik, BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    return new Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: new BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(5.0)),
                      color: Colors.lightBlueAccent),
                  child: Tooltip(
                    message: 'Terhitung periode $bulan $tahun',
                    child: Text(
                      "${formatRupiah(income)}",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
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
