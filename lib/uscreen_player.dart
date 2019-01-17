import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'values.dart';
import 'drawerclass.dart';

//Help : https://github.com/brianegan/chewie/blob/master/example/lib/main.dart
//To play video files
class MyUscreenVideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UscreenVideoPlayer();
  }
}

class _UscreenVideoPlayer extends State<MyUscreenVideoPlayer> {

  VideoPlayerController _controller;
  TargetPlatform _platform; // used for theme
  String _filePath;
  bool isFileLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Video player"),
      ),

      body:
      new Column(

        children: <Widget>[
          new Expanded(
            child: new Center(
              child: isFileLoaded ? new Chewie(
                _controller,
                aspectRatio: 16 / 9,
                autoPlay: true,
                looping: true,
                //fullScreenByDefault: true,

                //showControls: false,
                materialProgressColors: new ChewieProgressColors(
                  playedColor: Colors.red,
                  //seekbar completed duration color
                  handleColor: Colors.blue,
                  //seekbar handle color
                  backgroundColor: Colors.grey,
                  //seekbar remaining duration color
                  bufferedColor: Colors.lightGreen,
                ),
                placeholder: new Container(
                  color: Colors.grey, //video container color
                ),
                autoInitialize: true,
              ) : new Container(),
            ),
          ),
        ],
      ),
      floatingActionButton:

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(left: 30.0),
            child: RaisedButton(
              padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 10.0,
                  bottom: 10.0),
              shape: CircleBorder(side: BorderSide.none),
              color: themeColor(),
              child: new Icon(Icons.edit , color: Colors.white,),
              onPressed: volumeUp,
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0),
            shape: CircleBorder(side: BorderSide.none),
            color: themeColor(),
            child: new Icon(Icons.video_library , color: Colors.white,),
            onPressed: playNetworkVideo,

          ),

          RaisedButton(
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0),
            shape: CircleBorder(side: BorderSide.none),
            color: themeColor(),
            child: new Icon(Icons.sd_storage , color: Colors.white,),
            onPressed: getFilePath,

          ),
        ],
      ),
    );
  }

//------------------Methods-------------------

  void getFilePath() async {

    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
        isFileLoaded = true;
        _controller = new VideoPlayerController.file(new File(_filePath,));

      });
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  void playNetworkVideo(){

    setState(() {
      //this._filePath = filePath;
      isFileLoaded = true;
      _controller = new VideoPlayerController.network(
        'https://gcs-vimeo.akamaized.net/exp=1547565788~acl=%2A%2F1153541087.mp4%2A~hmac=39cf74126ba85f73cd00a3db04656dc742ad7e43e15c326f0e157f5b7edb7099/vimeo-prod-skyfire-std-us/01/335/12/301675391/1153541087.mp4',
      );

    });

  }

  void volumeUp()
  {
    if(_controller!=null)
    {
      print(_controller.seekTo(Duration(minutes: 10)));
      _controller.seekTo(Duration(minutes: 10));
      _controller.setVolume(0.9);
    }
  }


}