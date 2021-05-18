import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_add.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_akad.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_edit.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_submit.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_akad_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_submit_provider.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class PipelineRootPage extends StatefulWidget {
  String username;
  String nik;

  PipelineRootPage(this.username, this.nik);
  @override
  _PipelinePageState createState() => new _PipelinePageState();
}

class _PipelinePageState extends State<PipelineRootPage> {
  bool visiblex = false;

  var selectedKeterangan;
  final String url =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getKeteranganPipeline';
  List datax = List();

  @override
  void initState() {
    super.initState();
    this.getKeteranganPipeline();
  }

  Future<String> getKeteranganPipeline() async {
    setState(() {
      visiblex = true;
    });
    // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});

    if (res.statusCode == 200) {
      var resBody = json.decode(res.body)['Daftar_Keluhan'];
      setState(() {
        datax = resBody;
        visiblex = false;
        print(datax);
      });
    } else {
      throw Exception();
    }
  }

  bool visible = false;
  Future deletePipeline(String id) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/deletePipeline';
    var response = await http.post(url, body: {'id_pipeline': id});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Pipeline'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses delete pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    }
  }

  Future simpanKeteranganPipeline(
      String idKeterangan, String idPipeline) async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/simpanKeteranganPipeline';
    var response = await http.post(url,
        body: {'id_keterangan': idKeterangan, 'id_pipeline': idPipeline});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Kondisi_Pipeline'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Sukses simpan kondisi pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal simpan kondisi pipeline',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                PipelineRootPage(widget.username, widget.nik)));
      }
    }
  }

  _showPopupMenu(
          String id,
          String namaNasabah,
          String noKtp,
          String telepon,
          String plafond,
          String cabang,
          String tanggalPenyerahan,
          String namaPenerima,
          String teleponPenerima,
          String statusPipeline,
          String fotoSubmit,
          String tanggalAkad,
          String nomorAplikasi,
          String nomorPerjanjian,
          String nominalPinjaman,
          String jenisProduk,
          String informasiSales,
          String namaPetugasBank,
          String jabatanPetugasBank,
          String teleponPetugasBank,
          String fotoAkad1,
          String fotoAkad2) =>
      PopupMenuButton<int>(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PipelineEditScreen(
                              widget.username, widget.nik, id)));
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa ubah pipeline',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Ubah',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ubah',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PipelineSubmitScreen(
                              widget.username,
                              widget.nik,
                              id,
                              namaNasabah,
                              noKtp,
                              telepon,
                              plafond,
                              cabang,
                              tanggalPenyerahan,
                              namaPenerima,
                              teleponPenerima,
                              fotoSubmit)));
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa submit dokumen kembali',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Submit Dokumen',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.send,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Submit Dokumen',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  if (statusPipeline == '3' || statusPipeline == '4') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PipelineAkadScreen(
                                widget.username,
                                widget.nik,
                                id,
                                namaNasabah,
                                noKtp,
                                telepon,
                                plafond,
                                cabang,
                                tanggalPenyerahan,
                                namaPenerima,
                                teleponPenerima,
                                tanggalAkad,
                                nomorAplikasi,
                                nomorPerjanjian,
                                nominalPinjaman,
                                jenisProduk,
                                informasiSales,
                                namaPetugasBank,
                                jabatanPetugasBank,
                                teleponPetugasBank,
                                fotoAkad1,
                                fotoAkad2)));
                  } else {
                    Toast.show(
                      'Silahkan submit dokumen terlebih dahulu',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa akad kredit kembali',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Akad Kredit',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Akad Kredit',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 4,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Apakah anda ingin menghapus pipeline debitur ' +
                            namaNasabah +
                            ' ?',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Tidak',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            deletePipeline(
                              id,
                            );
                          },
                          child: Text(
                            'Ya',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa di hapus',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Delete',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hapus',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          ),
          PopupMenuItem(
            value: 5,
            child: GestureDetector(
              onTap: () {
                if (statusPipeline != '2') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Kondisi Pipeline',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (selectedKeterangan == null) {
                              Toast.show(
                                'silahkan pilih kondisi pipeline terlebih dahulu...',
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.red,
                              );
                            } else {
                              Navigator.of(context).pop();
                              simpanKeteranganPipeline(selectedKeterangan, id);
                            }
                          },
                          child: visiblex
                              ? CircularProgressIndicator(
                                  //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kPrimaryColor),
                                )
                              : Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                  ),
                                ),
                        ),
                      ],
                      content: fieldKeteranganPipeline(),
                    ),
                  );
                } else {
                  Toast.show(
                    'Pipeline sudah pencairan dan tidak bisa ubah kondisi kembali',
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Tooltip(
                  message: 'Kondisi',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notes_outlined,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Kondisi',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
        icon: Icon(Icons.more_vert),
        offset: Offset(0, 30),
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            titleSpacing: 0.0,
            backgroundColor: kPrimaryColor,
            title: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Pipeline',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Toast.show(
                          'Pipeline ' + bulan + ' ' + tahun,
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.CENTER,
                          backgroundColor: Colors.blueAccent,
                        );
                      },
                    ),
                  ],
                )),
            actions: <Widget>[
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PipelineAddScreen(widget.username, widget.nik)));
                },
              )
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.bold), //For Selected tab
              unselectedLabelStyle: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.bold), //For Un-selected Tabs
              tabs: <Widget>[
                Tab(
                  text: 'SEMUA',
                ),
                Tab(
                  text: 'SUBMIT DOKUMEN',
                ),
                Tab(
                  text: 'AKAD KREDIT',
                )
              ],
            ),
          ),
        ),
        body: TabBarView(children: <Widget>[
          Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: Provider.of<PipelineProvider>(context, listen: false)
                      .getPipeline(PipelineItem(widget.nik)),
                  builder: (context, snapshot) {
                    if (snapshot.data == null &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                      );
                    } else if (snapshot.data == null) {
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
                                    child: Icon(
                                      Icons.hourglass_empty,
                                      size: 70,
                                      color: Colors.black54,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Pipeline belum tersedia',
                                style: TextStyle(
                                  fontFamily: "Roboto-Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Consumer<PipelineProvider>(
                          builder: (context, data, _) {
                        print(data.dataPipeline.length);
                        if (data.dataPipeline.length == 0) {
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
                                        child: Icon(
                                          Icons.hourglass_empty,
                                          size: 70,
                                          color: Colors.black54,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Pipeline belum tersedia',
                                    style: TextStyle(
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ]),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.dataPipeline.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PipelineViewScreen(
                                                      data.dataPipeline[i]
                                                          .namaNasabah,
                                                      data.dataPipeline[i]
                                                          .tglPipeline,
                                                      data.dataPipeline[i]
                                                          .alamat,
                                                      data.dataPipeline[i]
                                                          .telepon,
                                                      data.dataPipeline[i]
                                                          .jenisProduk,
                                                      data.dataPipeline[i]
                                                          .plafond,
                                                      data.dataPipeline[i]
                                                          .cabang,
                                                      data.dataPipeline[i]
                                                          .keterangan,
                                                      data.dataPipeline[i]
                                                          .status,
                                                      data.dataPipeline[i]
                                                          .tempatLahir,
                                                      data.dataPipeline[i]
                                                          .tanggalLahir,
                                                      data.dataPipeline[i]
                                                          .jenisKelamin,
                                                      data.dataPipeline[i]
                                                          .noKtp,
                                                      data.dataPipeline[i].npwp,
                                                      data.dataPipeline[i]
                                                          .statusKredit,
                                                      data.dataPipeline[i]
                                                          .pengelolaPensiun,
                                                      data.dataPipeline[i]
                                                          .bankTakeover,
                                                      data.dataPipeline[i]
                                                          .foto1,
                                                      data.dataPipeline[i]
                                                          .foto2,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: ListTile(
                                          title: Text(
                                            data.dataPipeline[i].namaNasabah,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Plafond',
                                                    child: Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${formatRupiah(data.dataPipeline[i].plafond)}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Tanggal Input',
                                                    child: Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].tglPipeline}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Status Pipeline',
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    messageStatus(
                                                        '${data.dataPipeline[i].status}'),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}')),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Kondisi Pipeline',
                                                    child: Icon(
                                                      MdiIcons.tag,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].keluhan}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Regular',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              _showPopupMenu(
                                                data.dataPipeline[i].id
                                                    .toString(),
                                                data.dataPipeline[i].namaNasabah
                                                    .toString(),
                                                data.dataPipeline[i].noKtp
                                                    .toString(),
                                                data.dataPipeline[i].telepon
                                                    .toString(),
                                                data.dataPipeline[i].plafond
                                                    .toString(),
                                                data.dataPipeline[i].cabang
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .tglPenyerahan
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .namaPenerima
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .teleponPenerima
                                                    .toString(),
                                                data.dataPipeline[i].status,
                                                data.dataPipeline[i]
                                                    .fotoTandaTerima,
                                                data.dataPipeline[i]
                                                    .tanggalAkad,
                                                data.dataPipeline[i]
                                                    .nomorAplikasi,
                                                data.dataPipeline[i]
                                                    .nomorPerjanjian,
                                                data.dataPipeline[i]
                                                    .nominalPinjaman,
                                                data.dataPipeline[i].akadProduk,
                                                data.dataPipeline[i].salesInfo,
                                                data.dataPipeline[i]
                                                    .namaPetugasBank,
                                                data.dataPipeline[i]
                                                    .jabatanPetugasBank,
                                                data.dataPipeline[i]
                                                    .teleponPetugasBank,
                                                data.dataPipeline[i].fotoAkad1,
                                                data.dataPipeline[i].fotoAkad2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      });
                    }
                  })),
          Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: Provider.of<PipelineSubmitProvider>(context,
                          listen: false)
                      .getPipeline(PipelineSubmitItem(widget.nik)),
                  builder: (context, snapshot) {
                    if (snapshot.data == null &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                      );
                    } else if (snapshot.data == null) {
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
                                    child: Icon(
                                      Icons.hourglass_empty,
                                      size: 70,
                                      color: Colors.black54,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Submit dokumen belum tersedia',
                                style: TextStyle(
                                  fontFamily: "Roboto-Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Consumer<PipelineSubmitProvider>(
                          builder: (context, data, _) {
                        print(data.dataPipeline.length);
                        if (data.dataPipeline.length == 0) {
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
                                        child: Icon(
                                          Icons.hourglass_empty,
                                          size: 70,
                                          color: Colors.black54,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Submit dokumen belum tersedia',
                                    style: TextStyle(
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ]),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.dataPipeline.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PipelineViewScreen(
                                                      data.dataPipeline[i]
                                                          .namaNasabah,
                                                      data.dataPipeline[i]
                                                          .tglPipeline,
                                                      data.dataPipeline[i]
                                                          .alamat,
                                                      data.dataPipeline[i]
                                                          .telepon,
                                                      data.dataPipeline[i]
                                                          .jenisProduk,
                                                      data.dataPipeline[i]
                                                          .plafond,
                                                      data.dataPipeline[i]
                                                          .cabang,
                                                      data.dataPipeline[i]
                                                          .keterangan,
                                                      data.dataPipeline[i]
                                                          .status,
                                                      data.dataPipeline[i]
                                                          .tempatLahir,
                                                      data.dataPipeline[i]
                                                          .tanggalLahir,
                                                      data.dataPipeline[i]
                                                          .jenisKelamin,
                                                      data.dataPipeline[i]
                                                          .noKtp,
                                                      data.dataPipeline[i].npwp,
                                                      data.dataPipeline[i]
                                                          .statusKredit,
                                                      data.dataPipeline[i]
                                                          .pengelolaPensiun,
                                                      data.dataPipeline[i]
                                                          .bankTakeover,
                                                      data.dataPipeline[i]
                                                          .foto1,
                                                      data.dataPipeline[i]
                                                          .foto2,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: ListTile(
                                          title: Text(
                                            data.dataPipeline[i].namaNasabah,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Plafond',
                                                    child: Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${formatRupiah(data.dataPipeline[i].plafond)}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Tanggal Input',
                                                    child: Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].tglPipeline}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Status Pipeline',
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    messageStatus(
                                                        '${data.dataPipeline[i].status}'),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}')),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Kondisi Pipeline',
                                                    child: Icon(
                                                      MdiIcons.tag,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].keluhan}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Regular',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              _showPopupMenu(
                                                data.dataPipeline[i].id
                                                    .toString(),
                                                data.dataPipeline[i].namaNasabah
                                                    .toString(),
                                                data.dataPipeline[i].noKtp
                                                    .toString(),
                                                data.dataPipeline[i].telepon
                                                    .toString(),
                                                data.dataPipeline[i].plafond
                                                    .toString(),
                                                data.dataPipeline[i].cabang
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .tglPenyerahan
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .namaPenerima
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .teleponPenerima
                                                    .toString(),
                                                data.dataPipeline[i].status,
                                                data.dataPipeline[i]
                                                    .fotoTandaTerima,
                                                data.dataPipeline[i]
                                                    .tanggalAkad,
                                                data.dataPipeline[i]
                                                    .nomorAplikasi,
                                                data.dataPipeline[i]
                                                    .nomorPerjanjian,
                                                data.dataPipeline[i]
                                                    .nominalPinjaman,
                                                data.dataPipeline[i].akadProduk,
                                                data.dataPipeline[i].salesInfo,
                                                data.dataPipeline[i]
                                                    .namaPetugasBank,
                                                data.dataPipeline[i]
                                                    .jabatanPetugasBank,
                                                data.dataPipeline[i]
                                                    .teleponPetugasBank,
                                                data.dataPipeline[i].fotoAkad1,
                                                data.dataPipeline[i].fotoAkad2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      });
                    }
                  })),
          Container(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future:
                      Provider.of<PipelineAkadProvider>(context, listen: false)
                          .getPipeline(PipelineAkadItem(widget.nik)),
                  builder: (context, snapshot) {
                    if (snapshot.data == null &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                      );
                    } else if (snapshot.data == null) {
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
                                    child: Icon(
                                      Icons.hourglass_empty,
                                      size: 70,
                                      color: Colors.black54,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Akad kredit belum tersedia',
                                style: TextStyle(
                                  fontFamily: "Roboto-Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Consumer<PipelineAkadProvider>(
                          builder: (context, data, _) {
                        print(data.dataPipeline.length);
                        if (data.dataPipeline.length == 0) {
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
                                        child: Icon(
                                          Icons.hourglass_empty,
                                          size: 70,
                                          color: Colors.black54,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Akad kredit belum tersedia',
                                    style: TextStyle(
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ]),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.dataPipeline.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.black12,
                                    ))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PipelineViewScreen(
                                                      data.dataPipeline[i]
                                                          .namaNasabah,
                                                      data.dataPipeline[i]
                                                          .tglPipeline,
                                                      data.dataPipeline[i]
                                                          .alamat,
                                                      data.dataPipeline[i]
                                                          .telepon,
                                                      data.dataPipeline[i]
                                                          .jenisProduk,
                                                      data.dataPipeline[i]
                                                          .plafond,
                                                      data.dataPipeline[i]
                                                          .cabang,
                                                      data.dataPipeline[i]
                                                          .keterangan,
                                                      data.dataPipeline[i]
                                                          .status,
                                                      data.dataPipeline[i]
                                                          .tempatLahir,
                                                      data.dataPipeline[i]
                                                          .tanggalLahir,
                                                      data.dataPipeline[i]
                                                          .jenisKelamin,
                                                      data.dataPipeline[i]
                                                          .noKtp,
                                                      data.dataPipeline[i].npwp,
                                                      data.dataPipeline[i]
                                                          .statusKredit,
                                                      data.dataPipeline[i]
                                                          .pengelolaPensiun,
                                                      data.dataPipeline[i]
                                                          .bankTakeover,
                                                      data.dataPipeline[i]
                                                          .foto1,
                                                      data.dataPipeline[i]
                                                          .foto2,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: ListTile(
                                          title: Text(
                                            data.dataPipeline[i].namaNasabah,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Regular'),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Plafond',
                                                    child: Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${formatRupiah(data.dataPipeline[i].plafond)}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Tanggal Input',
                                                    child: Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].tglPipeline}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Status Pipeline',
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    messageStatus(
                                                        '${data.dataPipeline[i].status}'),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto-Regular',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colorStatus(
                                                            '${data.dataPipeline[i].status}')),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Tooltip(
                                                    message: 'Kondisi Pipeline',
                                                    child: Icon(
                                                      MdiIcons.tag,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${data.dataPipeline[i].keluhan}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Regular',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              _showPopupMenu(
                                                data.dataPipeline[i].id
                                                    .toString(),
                                                data.dataPipeline[i].namaNasabah
                                                    .toString(),
                                                data.dataPipeline[i].noKtp
                                                    .toString(),
                                                data.dataPipeline[i].telepon
                                                    .toString(),
                                                data.dataPipeline[i].plafond
                                                    .toString(),
                                                data.dataPipeline[i].cabang
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .tglPenyerahan
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .namaPenerima
                                                    .toString(),
                                                data.dataPipeline[i]
                                                    .teleponPenerima
                                                    .toString(),
                                                data.dataPipeline[i].status,
                                                data.dataPipeline[i]
                                                    .fotoTandaTerima,
                                                data.dataPipeline[i]
                                                    .tanggalAkad,
                                                data.dataPipeline[i]
                                                    .nomorAplikasi,
                                                data.dataPipeline[i]
                                                    .nomorPerjanjian,
                                                data.dataPipeline[i]
                                                    .nominalPinjaman,
                                                data.dataPipeline[i].akadProduk,
                                                data.dataPipeline[i].salesInfo,
                                                data.dataPipeline[i]
                                                    .namaPetugasBank,
                                                data.dataPipeline[i]
                                                    .jabatanPetugasBank,
                                                data.dataPipeline[i]
                                                    .teleponPetugasBank,
                                                data.dataPipeline[i].fotoAkad1,
                                                data.dataPipeline[i].fotoAkad2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      });
                    }
                  })),
        ]),
      ),
    );
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.redAccent;
    } else if (status == '2') {
      return Colors.blueAccent;
    } else if (status == '3') {
      return kPrimaryColor;
    } else if (status == '4') {
      return Colors.orangeAccent;
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

  Widget fieldKeteranganPipeline() {
    return DropdownButtonFormField(
        items: datax
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value['keluhan'],
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  value: value['id'].toString(),
                ))
            .toList(),
        onChanged: (selectedKeteranganType) {
          setState(() {
            selectedKeterangan = selectedKeteranganType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Kondisi Pipeline',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Roboto-Regular',
            )),
        value: selectedKeterangan,
        isExpanded: true);
  }
}
