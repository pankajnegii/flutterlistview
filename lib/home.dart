import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CameraPage.dart';
import 'FlareAnimation.dart';
import 'animatedtab.dart';
import 'audioplayer.dart';
import 'drawerclass.dart';
import 'filemanager.dart';
import 'uscreen_detail_mobile.dart';
import 'uscreen_player.dart';
import 'values.dart';
import 'videoplayer.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  State<StatefulWidget> createState() {
    return _HomePage(newTitle: title);
  }
}

class _HomePage extends State<MyHomePage> {
  final String newTitle;
  bool _showOtherListItems = false;

  /* final TextStyle _biggerfont = const TextStyle(
      fontSize: 18.0); //Not in use inside header*/
  //Drawer drawer = new Drawer()
  _HomePage({this.newTitle});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          //calling MyDrawer class of drawerclass.dart
          //Help : https://stackoverflow.com/questions/51659805/persisting-appbar-drawer-across-all-pages-flutter
          drawer: MyDrawer(),

          appBar: AppBar(
            title: Text(newTitle),
            // backgroundColor: appBarColor(),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Uscreen Video Player'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyUscreenVideoPlayer()));
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Chapter Details Page'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyUscreenDetailMobile()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_drop_down,
                  size: 40.0,
                  color: themeColor(),
                ),
                title: Text(
                  'Show Other Pages',
                  style: TextStyle(color: themeColor()),
                ),
                onTap: () {
                  setState(() {
                    _showOtherListItems = !_showOtherListItems;
                  });
                },
              ),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.save),
                      title: Text('Save Shared Preferences'),
                      onTap: _saveSharedPreferences,
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.audiotrack),
                      title: Text('Play Audio'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAudioPlayer()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.music_video),
                      title: Text('Play Video'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyVideoPlayer()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.video_library),
                      title: Text('Uscreen Video Player'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyUscreenVideoPlayer()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.sd_storage),
                      title: Text('File Manager'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyFileManager()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.add_a_photo),
                      title: Text('Photo'),
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.games),
                      title: Text('Animations'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyFlareAnimation()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.tablet),
                      title: Text('Animated Bottom Tab Bar'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAnimatedTabBar()));
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.add_alert),
                      title: Text('Alert Box'),
                      onTap: () {
                        _showDialog(context);
                      },
                    )
                  : new Container(),
              _showOtherListItems
                  ? Builder(
                      builder: (context) => ListTile(
                          leading: Icon(Icons.local_bar),
                          title: Text('Snake Bar'),
                          onTap: () {
                            print("Should show snakebar");
                            final snackBar = SnackBar(
                              content: Text('Yay! A SnackBar!'),
                              backgroundColor: themeColor(),
                              behavior: SnackBarBehavior.floating,
                              /*action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change!
                            },
                          ),*/
                            );
                            // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                            Scaffold.of(context).showSnackBar(snackBar);
                          }))
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                          leading: Icon(Icons.local_bar),
                          title: Text('Flush Bar'),
                          onTap: () {
                            Flushbar(
                              title:  "Flush Bar",
                              message:  "This is a substitute to snakebar and toast",
                              duration:  Duration(seconds: 3),
                              backgroundColor: lightThemeColor(),
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              flushbarPosition: FlushbarPosition.TOP,
                            )..show(context);
                          })
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.open_in_new),
                      title: Text('Toast'),
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "This is Short Toast at Center",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: themeColor(),
                          textColor: Colors.white,
                        );
                      })
                  : new Container(),
              _showOtherListItems
                  ? ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCameraPage()));
                      },
                    )
                  : new Container(),
            ],
          ), //End : Listview
        )); //End : Scaffold
  } //End : Build

  Future<bool> _onWillPop() {
    //To close app on back key press
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Your app will be closed.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => exit(0), //Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog"),
          content: new Text("Alert Box is clicked"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } // End : _showDialog(context)

  void _saveSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', 'test@examples.com');
    pref.setString('password', '87654321');
  }
}
