import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'drawerclass.dart';

//Help : https://pub.dartlang.org/packages/video_player

class MyVideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayer();
  }
}

class _VideoPlayer extends State<MyVideoPlayer> {

  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(new File('/storage/emulated/0/162678.mp4'))
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Video player"),
      ),

      body:
      Center(
        child: _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.value.isPlaying
            ? _controller.pause
            : _controller.play,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

//------------------Methods-------------------


}