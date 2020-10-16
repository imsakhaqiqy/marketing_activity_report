import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Modul/view_modul_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/modul_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/constants.dart';
import 'package:provider/provider.dart';

class ModulScreen extends StatefulWidget {
  @override
  _ModulScreenState createState() => _ModulScreenState();
}

class _ModulScreenState extends State<ModulScreen> {
  bool _isLoading = true;
  String pathPDF = "";
  File file;
  Future<File> createFileOfPdfUrl(final url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyle1 = TextStyle(
        fontFamily: "Montserrat Regular", fontSize: 14, color: Colors.grey);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'DOCUMENT',
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () =>
                Provider.of<ModulProvider>(context, listen: false).getModul(),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                future: Provider.of<ModulProvider>(context, listen: false)
                    .getModul(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                    );
                  }
                  return Consumer<ModulProvider>(
                    builder: (context, data, _) {
                      if (data.dataModul.length == 0) {
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
                            itemCount: data.dataModul.length,
                            itemBuilder: (context, i) {
                              final path = 'https://nabasa.co.id/marsit/' +
                                  data.dataModul[i].path;
                              return Card(
                                  elevation: 4,
                                  child: InkWell(
                                    onTap: () {
                                      createFileOfPdfUrl(path).then((f) {
                                        pathPDF = f.path;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PDFScreen(pathPDF)));
                                      });
                                    },
                                    child: ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              data.dataModul[i].title,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Montserrat Regular'),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Path: ${data.dataModul[i].path}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Montserrat Regular'),
                                        ),
                                        trailing: null),
                                  ));
                            });
                      }
                    },
                  );
                },
              ),
            )));
  }
}
