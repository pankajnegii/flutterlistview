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

  String _animations = "Build and Fade Out";      //Must : for first animation
  bool animation2ButtonClicked = false;
  int _currentIndex = 0;
  List<Animations> anime = new List<Animations>();
   /*List<Widget> _children = [
    MyPlaceholderWidget(anime[0]),
    MyPlaceholderWidget(anime[1]),
    MyPlaceholderWidget(anime[2])
  ];*/


   _FlareAnimation(){
     anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));
     anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));
     anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));
   }

  @override
  Widget build(BuildContext context) {
    // TODO: Complete with bottom tabs as animations of other shows error
    //_listBuilder();
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
                  //_animations = anime[_currentIndex]._animationType1;
                  animation2ButtonClicked = false;
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
                //_animations = anime[_currentIndex]._animationType2;
                animation2ButtonClicked = true;
              });
            },

          ),
        ],
      ),

      body:
      MyPlaceholderWidget(anime[_currentIndex]._animation , animation2ButtonClicked ? anime[_currentIndex]._animationType2 : anime[_currentIndex]._animationType1),

      /*FlareActor(
        "assets/Pj2.flr",
        animation: _animations,
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

//------------------Methods-------------------
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /*void _listBuilder() {

    anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));
    anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));
    anime.add(new Animations("assets/Pj2.flr", "Build and Fade Out", "Build"));

  }*/
}

//Classes for BottomNavigationBar children widget list
class MyPlaceholderWidget extends StatelessWidget {

  String animations, _animationType1;
  MyPlaceholderWidget(this.animations , this._animationType1);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: new FlareActor(
        animations,
        animation: _animationType1,
      ),
    );
  }

//------------------Methods-------------------

}

class Animations {
  String _animation, _animationType1 ,_animationType2;
  Animations(this._animation, this._animationType1 , this._animationType2);

}

