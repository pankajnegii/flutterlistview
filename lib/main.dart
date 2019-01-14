import 'package:flutter/material.dart';
import 'values.dart';
import 'uscreelogin.dart';


void main(){

  print("Start");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      theme: ThemeData(
        primaryColor: themeColor(),         // to make all appbar color to themecolor
      ),
      home: MyUscreenLogin(),

    );
  }
}

