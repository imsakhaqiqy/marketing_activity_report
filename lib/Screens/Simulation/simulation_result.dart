import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kreditpensiun_apps/Screens/provider/simulation_provider.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

// ignore: must_be_immutable
class SimulationResult extends StatefulWidget {
  String simulasiJenis;
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String jenisSimulasi;
  String jenisKredit;
  String bankBayarPensiun;
  String plafondPinjaman;
  String jangkaWaktu;
  String jenisAsuransi;
  String blokirAngsuran;
  String takeoverBankLain;
  String angsuranPerbulan;
  String batasUsiaPensiun;
  String tht;
  String niksales;
  SimulationResult(
    this.simulasiJenis,
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.jenisSimulasi,
    this.jenisKredit,
    this.bankBayarPensiun,
    this.plafondPinjaman,
    this.jangkaWaktu,
    this.jenisAsuransi,
    this.blokirAngsuran,
    this.takeoverBankLain,
    this.angsuranPerbulan,
    this.batasUsiaPensiun,
    this.tht,
    this.niksales,
  );

  @override
  _SimulationResultState createState() => _SimulationResultState();
}

class _SimulationResultState extends State<SimulationResult> {
  void initState() {
    //print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hasil Simulasi',
            style: TextStyle(fontFamily: 'Roboto-Regular'),
          ),
          actions: <Widget>[],
        ),
        body: FutureBuilder(
          future: Provider.of<SimulationProvider>(context, listen: false)
              .getSimulation(simulationItem(
                  widget.simulasiJenis,
                  widget.namaPensiun,
                  widget.gajiPensiun,
                  widget.tanggalLahir,
                  widget.jenisSimulasi,
                  widget.jenisKredit,
                  widget.bankBayarPensiun,
                  widget.plafondPinjaman,
                  widget.jangkaWaktu,
                  widget.jenisAsuransi,
                  widget.blokirAngsuran,
                  widget.takeoverBankLain,
                  widget.angsuranPerbulan,
                  widget.batasUsiaPensiun,
                  widget.tht,
                  widget.niksales)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              );
            }
            return Consumer<SimulationProvider>(builder: (context, data, _) {
              print(data.dataSimulation.length);
              if (data.dataSimulation[0].messageText == "dsr_tinggi") {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Text(
                      'Simulasi gagal, DSR ${data.dataSimulation[0].nilai} % melebihi 90.00 %, silahkan coba lagi...'),
                );
              } else if (data.dataSimulation[0].messageText ==
                  "jangka_waktu_tinggi") {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Text(
                      'Simulasi gagal, jangka waktu maksimal ${data.dataSimulation[0].nilai} bulan, silahkan coba lagi...'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'DATA PRIBADI',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto-Regular',
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nama Lengkap',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].namaPensiun}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Gaji Terakhir',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].gajiPensiun)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tanggal Lahir',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].tanggalLahir}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Usia Saat Ini',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].umur} TAHUN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Usia (pembulatan)',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].umurPembulatan} TAHUN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jenis Simulasi',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].jenisSimulasi}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jenis Kredit',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].jenisKredit}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Bank Ambil Gaji',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].bankBayarPensiun}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            widget.simulasiJenis == 'gp' ||
                                    widget.simulasiJenis == 'tht'
                                ? Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Lama Grace Period',
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${data.dataSimulation[0].lamaGracePeriod} BULAN',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Regular'),
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('PERHITUNGAN PINJAMAN',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto-Regular',
                                          color: kPrimaryColor)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nominal Pinjaman',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].plafondMaksimal)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            widget.simulasiJenis == 'tht'
                                ? SizedBox(height: 10)
                                : SizedBox(height: 0),
                            widget.simulasiJenis == 'tht'
                                ? Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'THT',
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${formatRupiah(data.dataSimulation[0].tht)}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Regular'),
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jangka Waktu',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].jangWaktu} BULAN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Angsuran per Bulan',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].angsuranPerbulan)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'DSR Pinjaman',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].iirPinjaman} %',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Bunga Anuitas',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].bungaAnuitas} %',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Bunga Efektif',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${data.dataSimulation[0].bungaEfektif} %',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Sisa Gaji Pensiun',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].sisaGaji)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Status Pinjaman',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: Colors.blue,
                                        child: Text(
                                          "${data.dataSimulation[0].messageText}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'PERHITUNGAN TERIMA BERSIH',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto-Regular',
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jenis Asuransi',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${data.dataSimulation[0].jenisAsuransi}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Provisi',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaProvisi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Administrasi',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaAdministrasi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Materai',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaMaterai)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biaya Asuransi',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].biayaAsuransi)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Biaya',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].totalBiaya)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Blokir Angsuran',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].blokirAngsuran)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            widget.simulasiJenis == 'gp' ||
                                    widget.simulasiJenis == 'tht'
                                ? SizedBox(height: 10)
                                : SizedBox(height: 0),
                            widget.simulasiJenis == 'gp' ||
                                    widget.simulasiJenis == 'tht'
                                ? Container(
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Blokir Grace Period',
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${formatRupiah(data.dataSimulation[0].gracePeriod)}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Regular'),
                                            )),
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Hutang Bank Lain',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].takeoverBankLain)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Potongan',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${formatRupiah(data.dataSimulation[0].totalPotongan)}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Regular'),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Terima Bersih',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular'),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        color: Colors.blue,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          '${formatRupiah(data.dataSimulation[0].terimaBersih)}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
            });
          },
        ),
      ),
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
