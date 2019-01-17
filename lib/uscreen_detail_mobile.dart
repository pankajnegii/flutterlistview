import 'package:flutter/material.dart';

import 'drawerclass.dart';
import 'values.dart';


class MyUscreenDetailMobile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UscreenDetailMobile();
  }
}

class _UscreenDetailMobile extends State<MyUscreenDetailMobile> {

  bool contentReady = false;
  bool favorite = false;
  bool isLocked = true;

  @override
  Widget build(BuildContext context) {

    final chapterTitle = Padding(
      padding: EdgeInsets.only(
          right: 10.0, left: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child:
        Text(getChapterTitle(), style: TextStyle(fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,),),
      ),
    );

    final chapterDetails = Padding(
      padding: EdgeInsets.only(
          right: 10.0, left: 10.0),
      child: Text(getChaptorDetails(),
        style: TextStyle(fontSize: 15.0, color: Colors.white),),
    );

    final episodeList =new Expanded( //In column , ListView.builder must be inside Expanded Help : https://stackoverflow.com/questions/50794021/flutter-listview-builder-in-scrollable-column-with-other-widgets
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: 20,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return MyPlayingRowItem(position + 1);
        },
      ),
    );

    final chapterImage_n_DownloadButton = Container(
      child: new Stack( //TODO column to stack
        children: <Widget>[
          Positioned(
            child: contentReady
                ? Image.asset('assets/images1.png')
                : Image.asset(
                'assets/place_holder.png'),
          ),
          Positioned(
            right: 15.0,
            bottom: 0.0,
            child: RaisedButton(
              shape: CircleBorder(side: BorderSide.none,),
              color: themeColor(),
              child: new Image.asset(
                'assets/dl.png', color: Colors.white, height: 60.0,),
              onPressed: startDownload,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Chapter Page"),
      ),

      body: new Column(

        children: <Widget>[

          chapterImage_n_DownloadButton,

          SizedBox(height: 10.0,),

          chapterTitle,

          SizedBox(height: 8.0,),

          chapterDetails,

          SizedBox(height: 8.0,),

          Divider(
            color: Colors.white,
            height: 2.0,
          ),

          SizedBox(height: 15.0,),

          episodeList,
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
    final playingRow = new Row(
      mainAxisSize: MainAxisSize.max, verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1, //to adjust size
          child: IconButton(color: transparent(), padding: EdgeInsets.all(2.0),
            icon: Icon(
              Icons.play_circle_outline, color: Colors.white, size: 45.0,),
            onPressed: () {
              //TODO for playing
            },
          ),
        ),
        Expanded(
          flex: 4,
          child: Text('Video Name ' + _currentPosition.toString(),
            style: TextStyle(color: Colors.white, fontSize: 20.0),),
        ),
        Expanded(
          flex: 1, //to adjust size
          child: Icon(Icons.lock_outline, color: Colors.white, size: 27.0,),
        ),
        Expanded(
          flex: 1, //to adjust size
          child: IconButton(color: transparent(), padding: EdgeInsets.all(2.0),
            icon: new Icon(
              favorite ? Icons.star : Icons.star_border, size: 32.0,
              color: Colors.orange,),
            onPressed: () {
              setState(() {
                favorite = !favorite;
              });
            },
          ),
        ),
      ],
    );

    return playingRow;
  }
}
