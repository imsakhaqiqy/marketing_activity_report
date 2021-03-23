import 'dart:convert';
import 'dart:io';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/Screens/Account/account_screen.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/Pipeline/pipeline_screen.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kreditpensiun_apps/Screens/models/image_upload_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class PipelineSubmitScreen extends StatefulWidget {
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
  String fotoTandaTerima;

  PipelineSubmitScreen(
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
      this.fotoTandaTerima);
  @override
  _PipelineSubmitScreen createState() => _PipelineSubmitScreen();
}

class _PipelineSubmitScreen extends State<PipelineSubmitScreen> {
  bool visible = false;
  final formKey = GlobalKey<FormState>();
  String image1;
  String base64Image1;
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    images.add("Add Image");
    super.initState();
    this.setDataPipeline();
  }

  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String path1 = '';
  String action = 'Simpan';

  final tanggalPenyerahanController = TextEditingController();
  final namaPenerimaController = TextEditingController();
  final teleponPenerimaController = TextEditingController();

  Future setDataPipeline() async {
    setState(() {
      print(widget.tanggalPenyerahan);
      if (widget.tanggalPenyerahan == "null") {
      } else {
        tanggalPenyerahan = widget.tanggalPenyerahan;
        tanggalPenyerahanController.text = widget.tanggalPenyerahan;
        namaPenerimaController.text = widget.namaPenerima;
        teleponPenerimaController.text = widget.teleponPenerima;
        path1 = 'https://www.nabasa.co.id/marsit/assets/images/submit/' +
            widget.fotoTandaTerima;
        images.replaceRange(0, 0 + 1, [path1]);
        image1 = 'https://www.nabasa.co.id/marsit/assets/images/submit/' +
            widget.fotoTandaTerima;
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
    tanggalPenyerahan = tanggalPenyerahanController.text;
    namaPenerima = namaPenerimaController.text;
    teleponPenerima = teleponPenerimaController.text;

    //server save api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/tes.php/submitPipeline';

    //starting web api call
    var response;
    if (path1 != '') {
      response = await http.post(url, body: {
        'id_pipeline': widget.id,
        'tanggal_penyerahan': tanggalPenyerahan,
        'nama_penerima': namaPenerima,
        'telepon_penerima': teleponPenerima,
        'image': '1'
      });
    } else {
      response = await http.post(url, body: {
        'id_pipeline': widget.id,
        'tanggal_penyerahan': tanggalPenyerahan,
        'nama_penerima': namaPenerima,
        'telepon_penerima': teleponPenerima,
        'file_name': 'submit',
        'image1': base64Image1,
        'name1': image1,
        'image': '0'
      });
    }

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Submit'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          tanggalPenyerahanController.clear();
          namaPenerimaController.clear();
          teleponPenerimaController.clear();
        });
        Toast.show(
          'Sukses submit dokumen debitur ' + widget.debitur,
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
          'Gagal submit dokumen debitur ' + widget.debitur,
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
                'Mohon menunggu, sedang proses submit dokumen...' +
                    widget.debitur,
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
            'Submit Dokumen',
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
                        fontWeight: FontWeight.bold,
                      ),
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
                            fieldDebitur('No KTP', widget.noKtp),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Debitur', widget.debitur),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Telepon', widget.telepon),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur(
                                'Nominal', formatRupiah(widget.nominal)),
                            SizedBox(
                              height: 10,
                            ),
                            fieldDebitur('Cabang', widget.cabang),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Data Submit',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        fieldTanggal(),
                        fieldPenerima(),
                        fieldTeleponPenerima(),
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
                              'Dokumen Submit',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                          widget.fotoTandaTerima != 'null'
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

  Widget fieldDebitur(title, value) {
    return Row(
      children: <Widget>[
        Container(
          width: 70,
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

  Widget fieldTanggal() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPenyerahanController,
          validator: (DateTime dateTime) {
            if (dateTime == null && tanggalPenyerahan == null) {
              return 'Tanggal penyerahan wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Penyerahan'),
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

  Widget fieldPenerima() {
    return TextFormField(
      controller: namaPenerimaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama penerima wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Nama Penerima'),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget fieldTeleponPenerima() {
    return TextFormField(
      controller: teleponPenerimaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'No telepon penerima wajib diisi...';
        } else if (value.length < 11) {
          return 'No Telepon penerima minimal 11 angka...';
        } else if (value.length > 13) {
          return 'No Telepon penerima maksimal 13 angka...';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'No Telepon Penerima'),
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
      crossAxisCount: 1,
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
          if (path1 != '') {
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
              titled = 'Foto Submit Dokumen ';
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
                      style: TextStyle(fontFamily: 'Montserrat Regular'),
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
          }
        }
      });
    });
  }
}
