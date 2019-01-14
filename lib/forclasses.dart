import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'drawerclass.dart';
import 'home.dart';
import 'values.dart'; //to hide keyboard when clicked outside
// decode json data


class FavoratePage extends StatelessWidget {


  final String receivedtext;

  FavoratePage({Key key, @required this.receivedtext}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),         //no need as theme data-primary color is changed to themeColor()
        title: Text("Favorite Page Screen"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              // Navigate back to first screen when tapped!
              Navigator.pop(context);
            },
            child: Text(receivedtext, style: TextStyle(
                inherit: true, color: Colors.white, fontSize: 20.0),),
            color: buttonColor(),
          ),
          Image.asset('assets/images1.png'),
        ],),

    );
  }
}

class SwipeToRefreshExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState();
  }
}

class _SwipeToRefreshState extends State<SwipeToRefreshExample> {
  User user = User("Default User",
      "https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg");
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
// Implementation later
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Swipe To Refresh Pages"),
      ),
      body:
      RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.network(user.image, height: 128.0, width: 128.0),
                    SizedBox(height: 24.0),
                    Text(user.name, style: TextStyle(color: themeColor()),),
                  ],
                ),
              ),
            )
          ])),
    );
  }

  Future<Null> _refresh() {
    return getUser().then((_user) {
      setState(() => user = _user);
    });
  }
}


class User {
  final String name, image;

  User(this.name, this.image);

  factory User.fromJson(Map<String, dynamic> json) {
    //dynamic?  check saved page 'Parsing complex JSON in Flutter – Flutter Community – Medium'
    json =
    json['results'][0]; //only in case this json file. Else use lines something like below one
    String fullName, fname, lname, title;
    title = json['name']['title'];
    fname = json['name']['first'];
    lname = json['name']['last'];
    String image = json['picture']['large'];
    fullName =
        title.substring(0, 1).toUpperCase() + title.substring(1).toLowerCase() +
            " " + fname.substring(0, 1).toUpperCase() +
            fname.substring(1).toLowerCase() + " " +
            lname.substring(0, 1).toUpperCase() +
            lname.substring(1).toLowerCase();
    return User(fullName, image);
  }
}

Future<User> getUser() async {
  final response = await http.get("https://randomuser.me/api/");
  final responseJson = json.decode(response.body);
  return User.fromJson(responseJson);
}

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            //backgroundColor: appBarColor(),
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car),),
                  Tab(icon: Icon(Icons.directions_bike),),
                  Tab(icon: Icon(Icons.directions_run),),
                ]),
            title: Text("TabBar Page"),
          ),
          body: TabBarView(
              children: [
                CarTab(),
                BikeTab(),
                RunTab(),
              ]),
        )
    );
  }

}

class BikeTab extends StatelessWidget {
  BikeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
      "Bike tab is clicked ", style: TextStyle(
        color: themeColor()),)); // we can also return the whole layout page here
  }

/* getSharedPreferences();
    if(counter!=null)
      counter++;
    else
      counter=0;
    _saveValues();*/

/*_saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //counterStarted = prefs.
    prefs.setInt("Counter", counter);
  }

   getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    counter = prefs.getInt("Counter") ?? 0;     //if key isn't present that value = 0
    counter++;
  }*/
}

class RunTab extends StatelessWidget {

  RunTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
      "Run tab is clicked ", style: TextStyle(
        color: themeColor()),)); // we can also return the whole layout page here
  }
}

class CarTab extends StatelessWidget {

  CarTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
      "Car tab is clicked ", style: TextStyle(
        color: themeColor()),)); // we can also return the whole layout page here
  }
}

//For Login

class MyLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<MyLoginPage> {

  bool _obscureText = true;
  //bool _isSignUpButtonCLicked = false;

  // String _password = "";
  final TextEditingController controllerPassword = new TextEditingController(
      text: '87654321'); // way to get value of textformfield
  final TextEditingController controllerEmail = new TextEditingController(
      text: 'test@examples.com');

  //SharedPreferences pref = await SharedPreferences.getInstance();


  Widget build(BuildContext context) {
    //Something new here
    final logo = Center( //Center is also used to be able to change the container size irrespective of other childs.
        child: Container(
            width: 150.0,
            height: 150.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: themeColor(), width: 1.0, style: BorderStyle.solid),
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/DP.png'),
                )
            )
        )
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      //autofocus: false,
      controller: controllerEmail,
      style: TextStyle(color: themeColor()),
      //initialValue: 'test@examples.com',
      decoration: new InputDecoration(
        hintText: 'Email',
        //labelText: 'Email',
        //enabledBorder: ,
        focusedBorder: OutlineInputBorder( //if focused
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: themeColor(), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: themeColor(), width: 1.0),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), ),
      ),
    );

    final password = new Container(

      height: 40.0,
      decoration: new BoxDecoration(
        border: new Border.all(
            color: themeColor(),
            width: 1.0,
            style: BorderStyle.solid
        ),

        borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 6, //to adjust size
            child: new TextFormField(
              //autofocus: false,
              // onFieldSubmitted: focusNode.unfocus(),
              textAlign: TextAlign.left,
              controller: controllerPassword,
              style: TextStyle(color: themeColor()),
              // validator: (val) => val.length < 6 ? 'Password too short.' : null,
              // onSaved: (val) => _password = val,
              obscureText: _obscureText,
              decoration: new InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                //border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: new IconButton(icon: Icon(Icons.remove_red_eye,
                  color: _obscureText ? Colors.grey : themeColor()),
                onPressed: _toggle,
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              )
          ),
        ],

      ),
    );

    /* // Toggles the password show status
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    new Container(
        child: new Stack(
          children: <Widget>[
            new Positioned(
              left: 0.0,
              bottom: 0.0,
              child: new TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock))),
                validator: (val) => val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: _obscureText,
              ),
            ),
            new Positioned(
              right: 0.0,
              bottom: 0.0,
              child: new Icon(Icons.star),
            ),
          ],
        )
    )


    //Use this tomorrow
     new Container(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock))),
                validator: (val) => val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: _obscureText,
              ),
              new FlatButton(
                  onPressed: _toggle,
                  child: new Text(_obscureText ? "Show" : "Hide"))
            ],
          ),
        ),

*/
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: new RaisedButton(
        child: Text('Log In', style: TextStyle(color: Colors.white)),
        onPressed: () {
          //toast for testing
          //_showToast(controllerPassword.text);
          SystemChannels.textInput.invokeMethod(
              'TextInput.hide'); //to hide keyboard when clicked outside
          _checkLoginSuccess();
        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),),
        color: buttonColor(),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text('Forgot Password?', style: TextStyle(color: Colors.black54),),
      onPressed: () {},
    );


    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: new RaisedButton(
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
        onPressed: () {
          //Make rest of the login widgets visibility gone.

        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),),
        color: buttonColor(),
      ),
    );
    //

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //to avoid page resizing when keyboard opens
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Login Page Screen"),
      ),
      body: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod(
              'TextInput.hide'); //to hide keyboard when clicked outside
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              SizedBox(height: 8.0),
              signUpButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _checkLoginSuccess() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (controllerEmail.text == pref.get('email') &&
        controllerPassword.text == pref.get('password')) {
      _showToast("Successfully Login");
      Navigator.pop(context);
      //The MaterialPageRoute is handy because it transitions to the new screen using a platform-specific animation.
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              MyHomePage(
                  title: 'Basic List')));
    }
    else {
      _showToast("Some Login Issue");
    }
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: "Result : " + text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

 /* void _showSignUpPage() {
    //Make rest of the login widgets visibility gone.


  }*/
}

//----------------  Refresh List Page ----------------------

// Better method than Tab/Bike/ car classes as only one class need to be defined here and by changing parameter to constructer data can be changed.
class SwipeToRefreshList extends StatefulWidget {
  @override
  _SwipeToRefreshListState createState() => new _SwipeToRefreshListState();
}

class _SwipeToRefreshListState extends State<SwipeToRefreshList> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyPlaceholderWidget(Colors.red),
    MyPlaceholderWidget(Colors.yellow),
    MyPlaceholderWidget(Colors.green)
  ];
  int _count = 1;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        // backgroundColor: appBarColor(),
        title: Text("Swipe To Refresh List Page"),
      ),
      body:
      _children[_currentIndex],
      /*new RefreshIndicator(
          child: new ListView(
            children: _getItems(),
          ),
          onRefresh: _handleRefresh),*/

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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _getItems() {
    var items = <Widget>[];
    for (int i = _count; i < _count + 15; i++) {
      var item = new Column(
        children: <Widget>[
          new ListTile(
            title: new Text("Item $i"),
          ),
          new Divider(
            height: 2.0,
          )
        ],
      );

      items.add(item);
    }
    return items;
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 2));

    setState(() {
      _count += 15;
    });

    return null;
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
