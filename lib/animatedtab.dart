import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:flutter/material.dart';

import 'drawerclass.dart';

class MyAnimatedTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedTabBar();
  }
}

class _AnimatedTabBar extends State<MyAnimatedTabBar> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Animated Bottom Tab Bar"),
      ),

      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //new Text(_index.toString()),
            Image.asset('assets/Mario' + (_index + 1).toString() + '.png',
              fit: BoxFit.cover,filterQuality: FilterQuality.low,),
          ],
        ),
      ),

      // Used : https://pub.dartlang.org/packages/flip_box_bar#-example-tab-
      bottomNavigationBar: FlipBoxBar(
        items: [
          FlipBarItem(
              icon: Icon(Icons.map),
              text: Text("Map"),
              frontColor: Colors.blue,
              backColor: Colors.blueAccent),
          FlipBarItem(
              icon: Icon(Icons.add),
              text: Text("Add"),
              frontColor: Colors.cyan,
              backColor: Colors.cyanAccent),
          FlipBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              text: Text("Read"),
              frontColor: Colors.orange,
              backColor: Colors.orangeAccent),
          FlipBarItem(
              icon: Icon(Icons.print),
              text: Text("Print"),
              frontColor: Colors.purple,
              backColor: Colors.purpleAccent),
          FlipBarItem(
              icon: Icon(Icons.print),
              text: Text("Print"),
              frontColor: Colors.pink,
              backColor: Colors.pinkAccent),
        ],
        onIndexChanged: (newIndex) {
          // Change content here
          setState(() {
            _index = newIndex;
          });
          print(newIndex);
          print('assets/Mario' + (_index + 1).toString() + '.png');
        },
      ),

    );
  }

//------------------Methods-------------------

}
