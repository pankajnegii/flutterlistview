
import 'package:flutter/material.dart';

import 'drawerclass.dart';

class MyBottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBar();
  }
}

class _BottomBar extends State<MyBottomBar> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    MyPlaceholderWidget(Colors.red),
    MyPlaceholderWidget(Colors.yellow),
    MyPlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Bottom Bar Page"),
      ),

      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex:  _currentIndex,
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
