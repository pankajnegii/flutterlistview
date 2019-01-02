import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'drawerclass.dart';
import 'values.dart';
import 'animatedtab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CameraPage.dart';
import 'filemanager.dart';
import 'FlareAnimation.dart';
import 'audioplayer.dart';
import 'videoplayer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Basic List';
    // final TextStyle _biggerfont = const TextStyle(fontSize: 18.0);
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: themeColor(),         // to make all appbar color to themecolor
      ),
      //home: MyHomePage(title: appTitle,),
      home: new Scaffold(
          body: new MyHomePage(title: appTitle,)),

    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;
 /* final TextStyle _biggerfont = const TextStyle(
      fontSize: 18.0); //Not in use inside header*/
  //Drawer drawer = new Drawer()
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //calling MyDrawer class of drawerclass.dart
      //Help : https://stackoverflow.com/questions/51659805/persisting-appbar-drawer-across-all-pages-flutter
      drawer: MyDrawer(),

      appBar: AppBar(
        title: Text(title),
       // backgroundColor: appBarColor(),
      ),
      body:
      ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Save Shared Preferences'),
            onTap: _saveSharedPreferences,
          ),
          ListTile(
            leading: Icon(Icons.audiotrack),
            title: Text('Play Audio'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyAudioPlayer()));
            },
          ),
          ListTile(
            leading: Icon(Icons.music_video),
            title: Text('Play Video'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyVideoPlayer()));
            },
          ),
          ListTile(
            leading: Icon(Icons.sd_storage),
            title: Text('File Manager'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyFileManager()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Photo'),
          ),
          ListTile(
            leading: Icon(Icons.games),
            title: Text('Animations'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyFlareAnimation()));
            },
          ),
          ListTile(
            leading: Icon(Icons.tablet),
            title: Text('Animated Bottom Tab Bar'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyAnimatedTabBar()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Alert Box'),
            onTap: () {
              _showDialog(context);
            },
          ),
          ListTile(
              leading: Icon(Icons.local_bar),
              title: Text('Snake Bar'),
              onTap: () {
                final snackBar = SnackBar(
                  content: Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change!
                    },
                  ),
                );
                // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                Scaffold.of(context).showSnackBar(snackBar);
              }
          ), ListTile(
              leading: Icon(Icons.open_in_new),
              title: Text('Toast'),
              onTap: () {
                Fluttertoast.showToast(
                  msg: "This is Short Toast at Center",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Color(0xFFFF0000),
                  textColor: Colors.white,
                );
              }
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyCameraPage()));
            },
          ),
        ],
      ),      //End : Listview
    );      //End : Scaffold
  }     //End : Build

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

  void _saveSharedPreferences() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', 'test@examples.com');
    pref.setString('password', '87654321');

  }

}