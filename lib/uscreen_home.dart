import 'package:flutter/material.dart';

import 'drawerclass.dart';
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

  @override
  Widget build(BuildContext context) {
    final categoryTitle = Padding(
      padding: EdgeInsets.only(
          right: 10.0, left: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Category Title",
            style: TextStyle(fontSize: 18.0, color: Colors.white),),
          RaisedButton(
            color: transparentBlack(),
            child: new Text('See All',
              style: TextStyle(fontSize: 18.0, color: themeColor()),),
            onPressed: startDownload,
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

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Category"),
      ),

      body:

      /* Expanded( //In column , ListView.builder must be inside Expanded Help : https://stackoverflow.com/questions/50794021/flutter-listview-builder-in-scrollable-column-with-other-widgets
        child:
        ListView.builder(
          //shrinkWrap: true,
          itemCount: 8,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return MyPlayingRowItem(position + 1);
          },
        ),
      ),*/

      new ListView(
        children: <Widget>[

          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,

          SizedBox(height: 8.0,),
          categoryTitle,
          chapterList,


        ],

      ),
    );
  }

//------------------Methods-------------------


  void startDownload() {
    //TODO
  }

  void favoriteButton() {
    favorite = !favorite;
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
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images1.png',),
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(getChapterTitle(), style: TextStyle(fontSize: 15.0, color: Colors.white),),
            ),
          ],
        )
    );

    return chapterImage;
  }
}


class MyCategoryList extends StatefulWidget {
  int _position;

  MyCategoryList(this._position);

  @override
  State<StatefulWidget> createState() {
    return _MyCategoryList(_position);
  }
}

class _MyCategoryList extends State<MyCategoryList> {

  int _currentPosition;
  bool favorite = false;

  _MyCategoryList(this._currentPosition);

  @override
  Widget build(BuildContext context) {
    final chapterImage = new Container(
        height: 200.0,
        width: 280.0,
        margin: EdgeInsets.only(left: 15.0,),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images1.png',),
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(getChapterTitle(), style: TextStyle(fontSize: 15.0, color: Colors.white),),
            ),
          ],
        )
    );

    return chapterImage;
  }
}
