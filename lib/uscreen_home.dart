import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'drawerclass.dart';
import 'see_all_list.dart';
import 'uscreen_detail_mobile.dart';
import 'values.dart';

class MyUscreenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UscreenHome();
  }
}

class _UscreenHome extends State<MyUscreenHome> {

  bool contentReady = false;
  bool favorite = false;
  bool isLocked = true;
  bool isCategoryListLoaded = false;
  List<Categories> categoryList;
  int catePosition = 0;

  @override
  _UscreenHome() {
    getCatogories();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Category"),
      ),

      body:
      isCategoryListLoaded ?
      ListView.builder(
        //shrinkWrap: true,
        itemCount: categoryList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return new Column(
            children: <Widget>[
              MyCategoryList(categoryList[position]),
            ],
          );
        },
      ) : Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          backgroundColor: buttonColor(),
        ),
      ),
    );
  }

//------------------Methods-------------------


  void startDownload() {
    //TODO
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            MySeeAllList()));
  }

  void favoriteButton() {
    favorite = !favorite;
  }

  //---------------API--------------

//--------------Methods---------------------

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: "Result : " + text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Color(0xFFFF0000),
      textColor: Colors.white,
    );
  }

  Future<Null> getCatogories() async {
    //For Categories Get Method
    final categoriesResponse = await http.get(
        'http://uscreen.io/api/v1/categories',
        headers: {'x-store-token': '5msj4Bq+Vdhr0g=='});
    print(categoriesResponse.body);
    if (categoriesResponse.statusCode == 200) {
      final responseJson = json.decode(categoriesResponse.body);
      print("Get Successfully");
      var list = responseJson as List;
      print(list.runtimeType);
      categoryList = list.map((i) => Categories.fromJson(i)).toList();
      print(categoryList.length);
      if (categoryList.length != null) {
        setState(() {
          isCategoryListLoaded = true;
        });
      }
      //Categories.fromJson(responseJson);
    } else {
      // If that response was not OK, throw an error.
      print(categoriesResponse.toString());
      print('Failed to load post');
      _showToast("Failed to load post");
      throw Exception('Failed to load post');
    }
  }

}

class MyPlayingRowItem extends StatefulWidget {
  int _position;

  MyPlayingRowItem(this._position);

  @override
  State<StatefulWidget> createState() {
    return _PlayingRowItem(_position);
  }
}

class _PlayingRowItem extends State<MyPlayingRowItem> {

  int _currentPosition;
  bool favorite = false;

  _PlayingRowItem(this._currentPosition);

  @override
  Widget build(BuildContext context) {
    final chapterImage = new Container(
      height: 200.0,
      width: 280.0,
      margin: EdgeInsets.only(left: 15.0,),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  MyUscreenDetailMobile()));
        },
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images1.png',),
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(getChapterTitle(),
                style: TextStyle(fontSize: 15.0, color: Colors.white),),
            ),
          ],
        ),
      ),
    );

    return chapterImage;
  }
}


class MyCategoryList extends StatefulWidget {
  Categories current_catergory;

  MyCategoryList(this.current_catergory);

  @override
  State<StatefulWidget> createState() {
    return _CategoryList(current_catergory);
  }
}

class _CategoryList extends State<MyCategoryList> {

  Categories _current_catergory;
  bool favorite = false;

  _CategoryList(this._current_catergory);

  @override
  Widget build(BuildContext context) {
    final categoryTitle = Padding(
      padding: EdgeInsets.only(
          right: 10.0, left: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(_current_catergory.title,
            style: TextStyle(fontSize: 18.0, color: Colors.white),),
          RaisedButton(
            color: transparentBlack(),
            child: new Text('See All',
              style: TextStyle(fontSize: 18.0, color: themeColor()),),
            onPressed: () {},

          ),

        ],
      ),

    );

    final chapterList = new Container( //In column , ListView.builder must be inside Expanded Help : https://stackoverflow.com/questions/50794021/flutter-listview-builder-in-scrollable-column-with-other-widgets
      height: 200,
      child: ListView.builder(

        itemCount: 20,
        //physics: ,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          return MyPlayingRowItem(position + 1);
        },
      ),
    );

    return new Column(
      children: <Widget>[
        categoryTitle,
        chapterList,
        SizedBox(height: 8.0,),
      ],
    );
  }
}

class Categories {
  //TODO : Check https://github.com/PoojaB26/ParsingJSON-Flutter/blob/master/lib/model/product_model.dart
  int id;
  final String title, image, featured;

  Categories({this.id, this.title, this.image, this.featured});

  factory Categories.fromJson(Map<String, dynamic> json) {
    //json = json['results'][0]; //only in case this json file. Else use lines something like below one
    int _id;
    String _title, _image, _featured;
    _id = json['id'];
    print(_id);
    _title = json['title'];
    _image = json['image'];
    _featured = json['featured'];
    return Categories(
        id: _id, title: _title, image: _image, featured: _featured);
  }
}
