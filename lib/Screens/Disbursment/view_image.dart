import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  @override
  _ImageView createState() => _ImageView();

  String path;
  String title;

  ImageView(this.path, this.title);
}

class _ImageView extends State<ImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            child: PhotoView(
              imageProvider: NetworkImage(widget.path),
            ),
          )),
    );
  }
}
