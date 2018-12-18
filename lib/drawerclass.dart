import 'package:flutter/material.dart';
import 'forclasses.dart';
import 'main.dart ';
import 'values.dart';
import 'listbuilderpage.dart';
import 'savingobject.dart';
class MyDrawer extends StatelessWidget {
  static const String _AccountName = 'Pankaj Negi';
  static const String _AccountEmail = 'test@examples.com';
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          // This is drawee header....
          // HELP From:https://engineering.classpro.in/flutter-1-navigation-drawer-routes-8b43a201251e
          //Drawee header starts
          new UserAccountsDrawerHeader(
              decoration: new BoxDecoration(    //header box decoration
                shape: BoxShape.rectangle,
                color: drawerHeaderColor(),
              ),
              accountName: const Text(_AccountName),
              accountEmail: const Text(_AccountEmail),
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
                      child: new Text('PJ',  style: TextStyle(color: Color(0xFFFFFFFF)),),
                    ),
                  ),
                )
              ]

          ),    //Drawee header ends
          //Drawer items
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              //The MaterialPageRoute is handy because it transitions to the new screen using a platform-specific animation.
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(
                          title : 'Basic List')));
            },
          ),
          ListTile(
            leading: Icon(Icons.tab),
            title: Text('TabBar Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      TabBarPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Swipe to refresh page image'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      SwipeToRefreshExample()));
            },
          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Swipe to refresh page list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      SwipeToRefreshList()));
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
            leading: Icon(Icons.account_box),
            title: Text('Login Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyLoginPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('RecyclerLike'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyListBuilder()));
            },
          ),
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Saving List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MySavingObject()));
            },
          ),
        ],
      ),
    );
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
}