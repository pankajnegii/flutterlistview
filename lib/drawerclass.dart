import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottombar.dart';
import 'forclasses.dart';
import 'home.dart';
import 'listbuilderpage.dart';
import 'loginapi.dart';
import 'savingobject.dart';
import 'uscreelogin.dart';
import 'uscreen_home.dart';
import 'values.dart';

class MyDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyDrawer();
  }
}

class _MyDrawer extends State<MyDrawer> {

  bool _showOtherListItems = false;
  bool alreadyLogin = false;
  String _accountName = "";
  String _accountEmail = "";

  //static const String _AccountName = 'Pankaj Negi';
  //static const String _AccountEmail = 'test@examples.com';

  @override
  _MyDrawer() {
    //checkSharedPreferences();
    setDetails();
  }


  @override
  Widget build(BuildContext context) {
    //checkSharedPreferences(context);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          // This is drawee header....
          // HELP From:https://engineering.classpro.in/flutter-1-navigation-drawer-routes-8b43a201251e
          //Drawee header starts
          new UserAccountsDrawerHeader(
              decoration: new BoxDecoration( //header box decoration
                shape: BoxShape.rectangle,
                color: drawerHeaderColor(),
              ),
              accountName: Text(_accountName),
              accountEmail: Text(_accountEmail),
              currentAccountPicture: new Container( //for circular image
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/DP.png'),
                      )
                  )),
              otherAccountsPictures: <Widget>[
                new GestureDetector(
                  onTap: () => _onTapOtherAccounts(context),
                  child: new Semantics(
                    label: 'Switch Account',
                    child: new CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: new Text(
                        'PJ', style: TextStyle(color: Color(0xFFFFFFFF)),),
                    ),
                  ),
                )
              ]

          ), //Drawee header ends
          //Drawer items

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Uscreen Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyUscreenHome()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Uscreen Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyUscreenLogin()));
            },
          ),

          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      FavoratePage(
                          receivedtext: 'Text From Favorite menu click')));
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Logout'),
            onTap: () {
              //Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('You will be logged out.'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            clearSharedPreferences();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    MyUscreenLogin()));
                          },
                          child: new Text('Yes'),
                        ),
                        new FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: new Text('No'),
                        ),
                      ],
                    );
                  }
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_drop_down, size: 40.0, color: themeColor(),),
            contentPadding: EdgeInsets.only(left: 50.0, right: 50.0),
            title: Text(
              'Show Other Pages', style: TextStyle(color: themeColor()),),
            onTap: () {
              setState(() {
                _showOtherListItems = !_showOtherListItems;
              });
            },
          ),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              //The MaterialPageRoute is handy because it transitions to the new screen using a platform-specific animation.
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(
                          title: 'Basic List')));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.tab),
            title: Text('TabBar Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      TabBarPage()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.search),
            title: Text('Swipe to refresh page image'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      SwipeToRefreshExample()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.pages),
            title: Text('Swipe to refresh page list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      SwipeToRefreshList()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Login Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyLoginPage()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Login Page with API'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyLoginPageAPI()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('RecyclerLike'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyListBuilder()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.save),
            title: Text('Saving List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MySavingObject()));
            },
          ) : new Container(),
          _showOtherListItems ? ListTile(
            leading: Icon(Icons.tablet),
            title: Text('Bottom Navigation'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyBottomBar()));
            },
          ) : new Container(),
        ],
      ),
    );
  }

  //------------------Methods--------------------

  void checkSharedPreferences() async {
    SharedPreferences prefSave = await SharedPreferences.getInstance();
    _accountEmail = prefSave.get('email2');
    _accountName = prefSave.get('userName');
    print(_accountEmail + _accountName);
  }

  _onTapOtherAccounts(BuildContext context) {
    _onTapOtherAccounts(BuildContext context) {
      Navigator.of(context).pop();
      showDialog<Null>(
        context: context,

        child: new AlertDialog(
          title: const Text('Account switching not implemented.'),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void setDetails() {
    _accountName = getUserName();
    _accountEmail = getUserEmail();
  }

  void clearSharedPreferences() async {
    SharedPreferences prefSave = await SharedPreferences.getInstance();
    prefSave.clear();
  }
}