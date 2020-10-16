import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/WebView/webview_container_screen.dart';

class Home extends StatelessWidget {
  final _links = 'https://www.nabasa.co.id/recruitment/marketing.html';
  final _links1 = 'https://www.nabasa.co.id/recruitment/agen.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'LOWONGAN PEKERJAAN',
          style:
              TextStyle(color: Colors.black, fontFamily: 'Montserrat Regular'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _urlButtonMarketing(context, _links),
                _urlButtonAgen(context, _links1),
              ]),
        ),
      ),
    );
  }

  Widget _urlButtonMarketing(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: FlatButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Card(
              elevation: 2,
              child: Container(
                padding: new EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'SALES LEADER',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat Regular'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/mr.png'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Jadilah Sales Leader, Capai Targetmu, Raih Insentifmu.')
                  ],
                ),
              )),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }

  Widget _urlButtonAgen(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: FlatButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Card(
            child: Container(
              padding: new EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'MARKETING AGENT',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Montserrat Regular'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/agen.png'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Jadilah Marketing Agent, Kerja Fleksibel, Booking, Langsung Bayar.')
                ],
              ),
            ),
          ),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
