import 'package:kreditpensiun_apps/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoApp createState() => _VideoApp();

  String path;
  String title;

  VideoApp(this.path, this.title);
}

class _VideoApp extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.nabasa.co.id/marsit/' + widget.path)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
