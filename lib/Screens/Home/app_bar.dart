import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/Screens/Account/LogDiamond/lod_diamond_screen.dart';
import 'package:kreditpensiun_apps/Screens/Home/history_income_screen.dart';
import 'package:kreditpensiun_apps/Screens/News/news_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MarsytAppBar extends AppBar {
  int income;
  String nik;
  int diamond;

  MarsytAppBar(this.income, this.nik, this.diamond, BuildContext context)
      : super(
            elevation: 0.25,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: _buildMarsytAppBar(income.toString(), nik.toString(),
                diamond.toString(), context));

  static Widget _buildMarsytAppBar(
      String income, String nik, String diamond, BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    Size size = MediaQuery.of(context).size;
    return new Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Image.asset(
              "assets/imarsyt 2-03.png",
              fit: BoxFit.fill,
              width: size.width * 0.30,
            ),
          ),
          new Container(
            padding: EdgeInsets.only(top: 30.0),
            child: new Row(
              children: <Widget>[
                Icon(
                  MdiIcons.diamond,
                  color: Colors.black,
                  size: 20.0,
                ),
                new Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: new BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(5.0)),
                      color: Colors.black),
                  child: Tooltip(
                      message: 'Total Diamond',
                      child: InkWell(
                        child: Text(
                          "${diamond}",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LogDiamondScreen(nik)));
                        },
                      )),
                ),
                Icon(
                  Icons.attach_money_outlined,
                  color: Colors.black,
                  size: 20.0,
                ),
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
