import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'values.dart';
import 'drawerclass.dart';

class MyUscreenDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UscreenDetails();
  }
}

class _UscreenDetails extends State<MyUscreenDetails> {


  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Video player"),
      ),

      body:
      Text('asd'),
    );
  }

//------------------Methods-------------------


}