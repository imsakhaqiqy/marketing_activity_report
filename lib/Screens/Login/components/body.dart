import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/Login/components/background.dart';
import 'package:kreditpensiun_apps/Screens/Signup/signup_screen.dart';
import 'package:kreditpensiun_apps/Screens/forget/forget_password_screen.dart';
import 'package:kreditpensiun_apps/components/already_have_an_account_acheck.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  String currentLocation;
  String currentLatitude;
  String currentLongitude;
  Body(this.currentLocation, this.currentLatitude, this.currentLongitude);
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<Body> {
  var personalData = new List(34);
  bool visible = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool checkedValue = false;
  String usernamePref;
  String passwordPref;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  Future<void> setPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
    prefs.setString('password', passwordController.text);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    usernamePref = preferences.getString("username");
    passwordPref = preferences.getString("password");
    if (usernamePref != null && passwordPref != null) {
      if (usernamePref == 'ADMIN181' && passwordPref == '317510240') {
        removePref();
      } else {
        setState(() {
          usernameController.text = usernamePref;
          passwordController.text = passwordPref;
          checkedValue = true;
        });
      }
    }
  }

  removePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("username");
    preferences.remove("password");
  }

  Future userLogin() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    String username = usernameController.text;
    String password = passwordController.text;

    //server login api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/getLogin';

    //starting web api call
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
      'location': widget.currentLocation,
      'latitude': widget.currentLatitude,
      'longitude': widget.currentLongitude
    });

    if (username == '' || password == '') {
      setState(() {
        visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
                'Login gagal, mohon masukkan username atau password yang benar'),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message);
        if (message['message'].toString() == 'Login Success') {
          if (message['status_account'] == 'SUSPEND') {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text(
                      'Login gagal, Account kamu di suspend, mohon hubungi sales leader'),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              visible = false;
              personalData[0] = message['nik'];
              personalData[1] = message['full_name'];
              personalData[2] = message['marital_status'];
              personalData[3] = message['date_of_birth'];
              personalData[4] = message['place_of_birth'];
              personalData[5] = message['no_ktp'];
              personalData[6] = message['gender'];
              personalData[7] = message['religion'];
              personalData[8] = message['email_address'];
              personalData[9] = message['phone_number'];
              personalData[10] = message['education'];
              personalData[11] = message['alamat'];
              personalData[12] = message['kelurahan'];
              personalData[13] = message['kecamatan'];
              personalData[14] = message['kabupaten'];
              personalData[15] = message['kode_pos'];
              personalData[16] = message['propinsi'];
              personalData[17] = message['no_rekening'];
              personalData[18] = message['nama_bank'];
              personalData[19] = message['nama_rekening'];
              personalData[20] = message['divisi_karyawan'];
              personalData[21] = message['jabatan_karyawan'];
              personalData[22] = message['wilayah_karyawan'];
              personalData[23] = message['branch'];
              personalData[24] = message['status_karyawan'];
              personalData[25] = message['grade_karyawan'];
              personalData[26] = message['gaji_pokok'];
              personalData[27] = message['tunjangan_tkd'];
              personalData[28] = message['tunjangan_jabatan'];
              personalData[29] = message['tunjangan_perumahan'];
              personalData[30] = message['tunjangan_telepon'];
              personalData[31] = message['tunjangan_kinerja'];
              personalData[32] = message['nik_marsit'];
              personalData[33] = message['diamond'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                      username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            }
            Size size = MediaQuery.of(context).size;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(''),
                        CloseButton(
                            color: Color(0xFFD5D3D3),
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(''),
                                        CloseButton(
                                          color: Color(0xFFD5D3D3),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                    titlePadding: EdgeInsets.all(0.0),
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      height: size.width * 0.70,
                                      child: Column(children: [
                                        Image.asset(
                                          "assets/images/warning-03.png",
                                          height: size.width * 0.70,
                                          width: size.width * 0.70,
                                        )
                                      ]),
                                    ),
                                  );
                                },
                              );
                            })
                      ]),
                  titlePadding: EdgeInsets.all(0.0),
                  backgroundColor: Colors.transparent,
                  content: Container(
                    height: size.width * 0.70,
                    width: size.width * 0.70,
                    child: Column(children: [
                      Image.asset(
                        "assets/images/Pipeline-01.jpg",
                        height: size.width * 0.70,
                        width: size.width * 0.70,
                      )
                    ]),
                  ),
                );
              },
            );
          }
        } else {
          if (message['status_account'] == 'NOTSET') {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text(
                      'Login Failed, Your Account is Notset, Please Contact Kantor Pusat'),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              visible = false;
            });
            // Showing Alert Dialog with Response JSON Message.
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text(
                      'Login Failed, Please Check Your Username or Password'),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else {
        print('error');
      }
    }
  }

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void initState() {
    super.initState();
    this.getPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selamat Datang",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto-Regular',
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset(
              "assets/images/welcome.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                controller: usernameController,
                decoration: InputDecoration(
                  //Add th Hint text here.
                  hintText: "Username",
                  hintStyle: TextStyle(fontFamily: 'Roboto-Regular'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: _isHidden,
                controller: passwordController,
                decoration: InputDecoration(
                  //Add th Hint text here.
                  hintText: "Password",
                  hintStyle: TextStyle(fontFamily: 'Roboto-Regular'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _toggleVisibility();
                    },
                    icon: Icon(Icons.visibility_off),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CheckboxListTile(
                title: Text(
                  'Simpan username',
                  style: TextStyle(
                      color: Colors.blue, fontFamily: 'Roboto-Regular'),
                ),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = !checkedValue;
                  });
                  if (checkedValue == true) {
                    setPref();
                  } else {
                    removePref();
                  }
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  color: kPrimaryColor, //MENGATUR WARNA TOMBOL
                  onPressed: () {
                    //PERINTAH YANG AKAN DIEKSEKUSI KETIKA TOMBOL DITEKAN
                    userLogin();
                  },
                  child: visible
                      ? SizedBox(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          height: 20.0,
                          width: 20.0,
                        )
                      : Text(
                          'Masuk',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto-Regular',
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen()));
                  },
                  child: Text(
                    'Lupa password ?',
                    style: TextStyle(
                        color: Colors.blue, fontFamily: 'Roboto-Regular'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
