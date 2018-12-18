import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'drawerclass.dart';
List<CameraDescription> cameras;

Future<void> main() async {
cameras = await availableCameras();
runApp(MyCameraPage());
}

class MyCameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraPage();
  }
}

class _CameraPage extends State<MyCameraPage> {

  CameraController controller;
  @override
  void initState() {
      super.initState();
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!controller.value.isInitialized) {
return Container();
}
return AspectRatio(
aspectRatio:
controller.value.aspectRatio,
child: CameraPreview(controller));
}
    /*return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          //backgroundColor: appBarColor(),
          title: Text("Camera Preview"),
        ),

        body:
        Text("Some thing here")
    );*/
  }


