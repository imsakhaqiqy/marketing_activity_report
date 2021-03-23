import 'dart:convert';
import 'dart:io';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kreditpensiun_apps/Screens/models/image_upload_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineAkadScreen extends StatefulWidget {
  String username;
  String nik;
  String id;
  String debitur;
  String noKtp;
  String telepon;
  String nominal;
  String cabang;
  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String nominalPinjaman;
  String jenisProduk;
  String informasiSales;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String fotoAkad1;
  String fotoAkad2;

  PipelineAkadScreen(
    this.username,
    this.nik,
    this.id,
    this.debitur,
    this.noKtp,
    this.telepon,
    this.nominal,
    this.cabang,
    this.tanggalPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.tanggalAkad,
    this.nomorAplikasi,
    this.nomorPerjanjian,
    this.nominalPinjaman,
    this.jenisProduk,
    this.informasiSales,
    this.namaPetugasBank,
    this.jabatanPetugasBank,
    this.teleponPetugasBank,
    this.fotoAkad1,
    this.fotoAkad2,
  );
  @override
  _PipelineAkadScreen createState() => _PipelineAkadScreen();
}

class _PipelineAkadScreen extends State<PipelineAkadScreen> {
  bool visible = false;
  final formKey = GlobalKey<FormState>();
  String image1, image2;
  String base64Image1, base64Image2;
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  var selectedJenisProduk;
  List<String> _jenisProdukType = <String>[
    'Fleksi BNI',
    'KP74 BTPN',
    'KP74 BJB'
  ];
  var selectedJenisInfo;
  List<String> _jenisInfoType = <String>[
    'REFERAL',
    'WALK IN',
    'INTERAKSI',
    'SMS BLAST PUSAT',
    'SOSIAL MEDIA',
    'SOSIALISASI INSTANSI',
    'TELEMARKETING PUSAT'
  ];
  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    images.add("Add Image");
    super.initState();
    this.setDataPipeline();
  }

  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String plafond;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String path1 = '';
  String path2 = '';
  String action = 'Simpan';

  final tanggalPerjanjianController = TextEditingController();
  final nomorAplikasiController = TextEditingController();
  final nomorPerjanjianController = TextEditingController();
  final plafondController = TextEditingController();

  final namaPetugasBankController = TextEditingController();
  final jabatanPetugasBankController = TextEditingController();
  final teleponPetugasBankController = TextEditingController();

  Future setDataPipeline() async {
    setState(() {
      print(widget.tanggalPenyerahan);
      if (widget.tanggalPenyerahan == "null") {
      } else {
        tanggalAkad = widget.tanggalAkad;
        tanggalPerjanjianController.text = widget.tanggalAkad;
        nomorAplikasiController.text = widget.nomorAplikasi;
        nomorPerjanjianController.text = widget.nomorPerjanjian;
        plafondController.text = widget.nominalPinjaman;
        if (widget.jenisProduk == 'Flexi') {
          selectedJenisProduk = 'Fleksi BNI';
        } else if (widget.jenisProduk == 'KP74') {
          selectedJenisProduk = 'KP74 BTPN';
        } else {
          selectedJenisProduk = 'KP74 BJB';
        }
        selectedJenisInfo = widget.informasiSales;
        namaPetugasBankController.text = widget.namaPetugasBank;
        jabatanPetugasBankController.text = widget.jabatanPetugasBank;
        teleponPetugasBankController.text = widget.teleponPetugasBank;
        path1 =
            'https://www.nabasa.co.id/marsit/assets/images/pencairan_sales/' +
                widget.fotoAkad1;
        path2 =
            'https://www.nabasa.co.id/marsit/assets/images/pencairan_sales/' +
                widget.fotoAkad2;
        images.replaceRange(0, 0 + 1, [path1]);
        image1 =
            'https://www.nabasa.co.id/marsit/assets/images/pencairan_sales/' +
                widget.fotoAkad1;
        images.replaceRange(1, 1 + 1, [path2]);
        image2 =
            'https://www.nabasa.co.id/marsit/assets/images/pencairan_sales/' +
                widget.fotoAkad2;
        action = 'Update';
      }
    });
  }

  Future submitPipeline() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    tanggalAkad = tanggalPerjanjianController.text;
    nomorAplikasi = nomorAplikasiController.text;
    nomorPerjanjian = nomorPerjanjianController.text;
    plafond = plafondController.text;
    namaPetugasBank = namaPetugasBankController.text;
    jabatanPetugasBank = jabatanPetugasBankController.text;
    teleponPetugasBank = teleponPetugasBankController.text;

    //server save api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/tes.php/akadPipeline';

    //starting web api call
    var response;
    if (path1 != '' && path2 != '') {
      response = await http.post(url, body: {
        'niksales': widget.nik,
        'telepon': widget.telepon,
        'id_pipeline': widget.id,
        'tanggal_akad': tanggalAkad,
        'nomor_aplikasi': nomorAplikasi,
        'nomor_perjanjian': nomorPerjanjian,
        'nominal_pinjaman': plafond,
        'jenis_produk': selectedJenisProduk,
        'sales_info': selectedJenisInfo,
        'nama_petugas_bank': namaPetugasBank,
        'jabatan_petugas_bank': jabatanPetugasBank,
        'telepon_petugas_bank': teleponPetugasBank,
        'image': '1'
      });
    } else {
      response = await http.post(url, body: {
        'niksales': widget.nik,
        'telepon': widget.telepon,
        'id_pipeline': widget.id,
        'tanggal_akad': tanggalAkad,
        'nomor_aplikasi': nomorAplikasi,
        'nomor_perjanjian': nomorPerjanjian,
        'nominal_pinjaman': plafond,
        'jenis_produk': selectedJenisProduk,
        'sales_info': selectedJenisInfo,
        'nama_petugas_bank': namaPetugasBank,
        'jabatan_petugas_bank': jabatanPetugasBank,
        'telepon_petugas_bank': teleponPetugasBank,
        'file_name': 'akad',
        'image1': base64Image1,
        'name1': image1,
        'image2': base64Image2,
        'name2': image2,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Akad'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          namaPetugasBankController.clear();
          jabatanPetugasBankController.clear();
          teleponPetugasBankController.clear();
        });
        Toast.show(
          'Sukses akad kredit debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PipelineScreen(widget.username, widget.nik)));
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal akad kredit debitur ' + widget.debitur,
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PipelineScreen(widget.username, widget.nik)));
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        visible
            ? Toast.show(
                'Mohon menunggu, sedang proses akad kredit...' + widget.debitur,
                context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.red,
              )
            : Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Akad Kredit',
            style: TextStyle(fontFamily: 'Montserrat Regular'),
          ),
          actions: [
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.white,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  submitPipeline();
                }
              },
              child: visible
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      ),
                      height: 20.0,
                      width: 20.0,
                    )
                  : Text(
                      '$action',
                      style: TextStyle(
                          color: Colors.teal,
                          fontFamily: 'Montserrat Regular',
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
        body: Container(
            color: Colors.grey[200],
            child: Form(
              key: formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Informasi Pipeline',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            fieldDebitur('No KTP', widget.noKtp, 70),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Debitur', widget.debitur, 70),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Telepon', widget.telepon, 70),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur(
                                'Nominal', formatRupiah(widget.nominal), 70),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Cabang', widget.cabang, 70),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Informasi Submit',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            fieldDebitur('Tanggal Penyerahan',
                                widget.tanggalPenyerahan, 150),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur(
                                'Nama Penerima', widget.namaPenerima, 150),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Telepon Penerima',
                                widget.teleponPenerima, 150),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Data Akad',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        fieldTanggalAkad(),
                        fieldNomorAplikasi(),
                        fieldNomorPerjanjian(),
                        fieldNominalPinjaman(),
                        fieldKodeProduk(),
                        fieldSalesInfo(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Data Petugas Bank',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        fieldPetugasBank(),
                        fieldJabatanBank(),
                        fieldNoTeleponBank(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Dokumen Akad',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                          widget.fotoAkad1 != 'null' &&
                                  widget.fotoAkad2 != 'null'
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          path1 = '';
                                        });
                                      },
                                      child: Tooltip(
                                        message: 'Reset Photo',
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                        ),
                                      )))
                              : Text('')
                        ],
                      )),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    //color: Colors.white,
                    child: Row(
                      children: <Widget>[Expanded(child: buildGridView())],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget fieldDebitur(title, value, double size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat Regular', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Montserrat Regular',
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget fieldTanggalAkad() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPerjanjianController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalAkad == null) {
              return 'Tanggal akad wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Akad'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Montserrat Regular')),
    ]);
  }

  Widget fieldNomorAplikasi() {
    return TextFormField(
        controller: nomorAplikasiController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nomor aplikasi wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nomor Aplikasi'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontFamily: 'Montserrat Regular'));
  }

  Widget fieldNomorPerjanjian() {
    return TextFormField(
      controller: nomorPerjanjianController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nomor perjanjian wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nomor Perjanjian'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldNominalPinjaman() {
    return TextFormField(
        controller: plafondController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Nominal pinjaman wajib diisi...';
          } else if (value.length < 8) {
            return 'Nominal pinjaman minimal 8 digit...';
          } else if (value.length > 9) {
            return 'Nominal pinjaman maksimal 9 digit';
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Nominal Pinjaman'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontFamily: 'Montserrat Regular'));
  }

  Widget fieldKodeProduk() {
    return DropdownButtonFormField(
        items: _jenisProdukType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisProdukType) {
          setState(() {
            selectedJenisProduk = selectedJenisProdukType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Jenis Produk',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedJenisProduk,
        isExpanded: true);
  }

  Widget fieldSalesInfo() {
    return DropdownButtonFormField(
        items: _jenisInfoType
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat Regular',
                    ),
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (selectedJenisInfoType) {
          setState(() {
            selectedJenisInfo = selectedJenisInfoType;
          });
        },
        decoration: InputDecoration(
            labelText: 'Informasi Sales',
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            labelStyle: TextStyle(
              fontFamily: 'Montserrat Regular',
            )),
        value: selectedJenisInfo,
        isExpanded: true);
  }

  Widget fieldPetugasBank() {
    return TextFormField(
      controller: namaPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldJabatanBank() {
    return TextFormField(
      controller: jabatanPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Jabatan wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Jabatan'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldNoTeleponBank() {
    return TextFormField(
      controller: teleponPetugasBankController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon wajib diisi...';
        } else if (value.length < 10) {
          return 'No Telepon minimal 10 angka...';
        } else if (value.length > 13) {
          return 'No Telepon maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'No. Telepon'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
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

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: PhotoView(
                          imageProvider: FileImage(uploadModel.imageFile),
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          if (path1 != '' && path2 != '') {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: PhotoView(
                            imageProvider: NetworkImage(images[index]),
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      images[index],
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            );
          } else {
            String titled;
            Color colored;
            if (index == 0) {
              titled = 'Foto SKK';
              colored = Colors.teal;
            } else {
              titled = 'Foto Tanda Tangan Akad';
              colored = Colors.teal;
            }
            return Card(
                shape: RoundedRectangleBorder(
                    side: new BorderSide(color: colored, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titled,
                      style: TextStyle(
                          fontSize: 8.0, fontFamily: 'Montserrat Regular'),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _onAddImageClick(index);
                      },
                    ),
                  ],
                ));
          }
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        if (file == null) {
        } else {
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          String base64Image =
              base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          } else {
            image2 = fileName;
            base64Image2 = base64Image;
          }
        }
      });
    });
  }
}
