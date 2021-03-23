import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ImageApp extends StatefulWidget {
  @override
  _ImageApp createState() => _ImageApp();

  String path;
  String title;

  ImageApp(this.path, this.title);
}

class _ImageApp extends State<ImageApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: PhotoView(
            imageProvider:
                NetworkImage('https://nabasa.co.id/marsit/' + widget.path),
          ),
        ));
  }
}
