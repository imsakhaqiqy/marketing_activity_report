import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  String judul = "";
  PDFScreen(this.pathPDF, this.judul);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(this.judul),
          actions: <Widget>[],
        ),
        path: pathPDF);
  }
}
