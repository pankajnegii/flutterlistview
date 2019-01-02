import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'drawerclass.dart';
import 'values.dart';
import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

//Help : https://pub.dartlang.org/packages/file_picker
//Help : https://pub.dartlang.org/packages/audioplayers#-example-tab-

class MyAudioPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AudioPlayers();
  }
}

class _AudioPlayers extends State<MyAudioPlayer> {
  String _filePath;
  bool _filePathReceived = false;
  AudioCache audioCache = new AudioCache();
  String localFilePath;
  AudioPlayer audioPlayer = new AudioPlayer();

  /* Widget localFile() {
    return audioPlayer(url: localFilePath, isLocal: true);
  }*/

  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = new AudioPlayer();
    AudioPlayer.logEnabled = true;

    final myContainer = new IconButton( iconSize: 64,
        icon: Icon(Icons.play_arrow),
        onPressed: playLocal);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("File Manager Page"),
      ),

      body: new Center(
          child:
          Column(
            children: <Widget>[
              _filePath == null
                  ? new Text('No file selected.')
                  : new Text('Path : ' + _filePath),
              _filePathReceived ? myContainer : new Container(),
            ],
          )

      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getFilePath,
        tooltip: 'Select file',
        child: new Icon(Icons.sd_storage),
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
      setState(()
      {
        this._filePath = filePath;
        _filePathReceived = true;
      });
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  Future<int> playLocal() async {
    int result = await audioPlayer.play(_filePath, isLocal: true);
   //String
    /*if (result == 1) {
      //On  success

    }
    return result;*/
  }
}


