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

class MyFileManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FileManager();
  }
}

class _FileManager extends State<MyFileManager> {
  String _filePath;

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(()
      {this._filePath = filePath;});
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("File Manager Page"),
      ),

      body: new Center(
        child: _filePath == null
            ? new Text('No file selected.')
            : new Text('Path : ' + _filePath),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getFilePath,
        tooltip: 'Select file',
        child: new Icon(Icons.sd_storage),
      ),
    );
  }

//------------------Methods-------------------

}


