import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';

import 'drawerclass.dart';
import 'values.dart';


class MyFlareAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlareAnimation();
  }
}

class _FlareAnimation extends State<MyFlareAnimation> {

  String _animations = "Build and Fade Out";
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyPlaceholderWidget(Colors.red),
    MyPlaceholderWidget(Colors.yellow),
    MyPlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Complete with bottom tabs

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Flare Animation Tabs"),
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
              child: Text('A1', style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),),
              onPressed: () {
                setState(() {
                  _animations = "Build";
                });
              },
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
            child: Text('A2', style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),),
            onPressed: () {
              setState(() {
                _animations = "Build";
              });
            },

          ),
        ],
      ),

      body:
      FlareActor(
        "assets/Pj2.flr",
        animation: _animations,
      ),

    );
  }

//------------------Methods-------------------

}

//Classes for BottomNavigationBar children widget list
class MyPlaceholderWidget extends StatelessWidget {

  final Color color;

  MyPlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

