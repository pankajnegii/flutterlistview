import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'values.dart';


class MyUscreenLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UscreenLogin();
  }
}

class _UscreenLogin extends State<MyUscreenLogin> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();        //to use snakebar without scaffold
  bool _obscureText = true;
  bool tryLogin = false;
  bool createNewAccount = false;
  Categories categories = new Categories();
  User userDetails  = new User(username: 'DefaultName' , email: 'DefaultEmail' , token: 'DefaultToken');
  // String _password = "";
  final TextEditingController controllerPassword = new TextEditingController(
      /*text: '87654321'*/); // way to get/set value of textformfield
  final TextEditingController controllerEmail = new TextEditingController(
      /*text: 'pnkjng88@gmail.com'*/);
  final TextEditingController controllerUserName = new TextEditingController(
    /*text: 'Pankaj Negi'*/);
  final TextEditingController controllerConfirmPassword = new TextEditingController(
    /*text: 'pnkjng88@gmail.com'*/);

  _UscreenLogin(){
    checkSharedPreferences();
  }

  Widget build(BuildContext context) {
    //Something new here
    final logo = Center( //Center is also used to be able to change the container size irrespective of other childs.
        child: Container(
            margin: EdgeInsets.all(20.0),

            height: 200.0,
            decoration: new BoxDecoration(
              /*shape: BoxShape.rectangle,
                border: Border.all(
                    color: themeColor(), width: 1.0, style: BorderStyle.solid),*/
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/logo.png'),
                )
            )
        )
    );

    final email = new Container(

      height: 45.0,
      color: Colors.white,

      child: new TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controllerEmail,
        style: TextStyle(color: editTextColor(), fontSize: 15.0),
        decoration: new InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.grey,),
          hintStyle: TextStyle(color: hintColor()),
          //hintText: 'UserName',
          labelText: 'Email',
          labelStyle: TextStyle(color: buttonColor()),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: InputBorder.none,
          // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
        ),
      ),
    );

    final password = new Container(

      height: 45.0,
     color: Colors.white,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 6, //to adjust size
            child: new TextFormField(
              textAlign: TextAlign.left,
              controller: controllerPassword,
              style: TextStyle(color: editTextColor(), fontSize: 15.0),
              obscureText: _obscureText,
              decoration: new InputDecoration(
                prefixIcon: Icon(Icons.vpn_key, color: Colors.grey,),
                hintStyle: TextStyle(color: hintColor()),
                labelText: 'Password',
                labelStyle: TextStyle(color: buttonColor()),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: new IconButton(
                icon: _obscureText ? Icon(Icons.visibility_off ,color: Colors.grey,) : Icon(
                    Icons.visibility,
                    color: boxBorder()),
                onPressed: _toggle,
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              )
          ),
        ],

      ),
    );

    //--------------------Sign Up Fields---------------------

    final userName = new Container(

      height: 45.0,
      color: Colors.white,
      alignment: Alignment.centerLeft,

      child: new TextFormField(
        keyboardType: TextInputType.text,
        controller: controllerUserName,
        style: TextStyle(color: editTextColor(), fontSize: 15.0),
        decoration: new InputDecoration(
          hintStyle: TextStyle(color: hintColor()),
          hintText: 'User Name',
          labelText: 'User Name',
          labelStyle: TextStyle(color: buttonColor()),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: InputBorder.none,
          // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
        ),
      ),
    );

    final signUpEmail = new Container(

      height: 45.0,
      color: Colors.white,
      alignment: Alignment.centerLeft,

      child: new TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controllerEmail,
        style: TextStyle(color: editTextColor(), fontSize: 15.0),
        decoration: new InputDecoration(
          hintStyle: TextStyle(color: hintColor()),
          hintText: 'Email',
          labelText: 'Email',
          labelStyle: TextStyle(color: buttonColor()),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: InputBorder.none,
          // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
        ),
      ),
    );

    final signUpPassword = new Container(

      height: 45.0,
      color: Colors.white,
      alignment: Alignment.centerLeft,

      child: new TextFormField(
        textAlign: TextAlign.left,
        controller: controllerPassword,
        style: TextStyle(color: editTextColor(), fontSize: 15.0),
        obscureText: _obscureText,
        decoration: new InputDecoration(
          hintText:'Password',
          hintStyle: TextStyle(color: hintColor()),
          labelText: 'Password',
          labelStyle: TextStyle(color: buttonColor()),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: InputBorder.none,
          // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
        ),
      ),
    );

    final confirmPassword = new Container(

      height: 45.0,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: new TextFormField(
        textAlign: TextAlign.left,
        controller: controllerConfirmPassword,
        style: TextStyle(color: editTextColor(), fontSize: 15.0),
        obscureText: _obscureText,
        decoration: new InputDecoration(
          hintText: 'Confirm Password',
          hintStyle: TextStyle(color: hintColor()),
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: buttonColor()),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: InputBorder.none,
          // border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),),     //to check size
        ),
      ),
    );

    final loginButton = new RaisedButton(
      color: buttonColor(),

      child:
      Padding(
        padding: EdgeInsets.all(12.0),
        child:   Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16.0),),

      ),
      // On login click
      onPressed: () {
        SystemChannels.textInput.invokeMethod(
            'TextInput.hide'); //to hide keyboard when clicked outside

        _validateLogin();
        //fetchPost();
        //getCatogories();
      },

    );

    final forgotLabel = new Container(
        margin: EdgeInsets.only(bottom: 120.0),
        child: new FlatButton(
          child: Text(
            'Forgot Password?', style: TextStyle(color: Colors.white),),
          onPressed: () {
            _showToast('Not done yet');
          },
        )
    );

    final loginApiCallOrProgressBar =
    Center (
        child:
        SizedBox( height: 35.0,
            child:
            tryLogin? CircularProgressIndicator(strokeWidth: 3.0, backgroundColor: buttonColor(),) :  new Container()
        )

    ) ;

    final signUpButton = new RaisedButton(

      color: buttonColor(),
      child:
      Padding(
          padding: EdgeInsets.all(12.0),
          child:   Text('Create New Account', style: TextStyle(color: Colors.white, fontSize: 16.0),),

      ),

      onPressed: () {
        SystemChannels.textInput.invokeMethod(
            'TextInput.hide'); //to hide keyboard when clicked outside
        //_showToast('Not done yet');
        _showSignUpPage();
      },

    );

    final signInContainer = new Column(
      children: <Widget>[
        email,
        password,
      ],
    );

    final signUpContainer =new Column(
      children: <Widget>[
        userName,
        signUpEmail,
        signUpPassword,
        confirmPassword,
      ],
    );
    //

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      //to avoid page resizing when keyboard opens
      body: GestureDetector(
          onTap: () {

            SystemChannels.textInput.invokeMethod(
                'TextInput.hide'); //to hide keyboard when clicked outside
          },
          child: new Container(
            color: containerColor(),
            child: Center(
              child:
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0 ,top: 50),
                children: <Widget>[
                  logo,
                  createNewAccount ? signUpContainer : signInContainer,
                  SizedBox(height: 16.0),
                  createNewAccount ? new Container() : loginButton,
                  SizedBox(height: 8.0),
                  signUpButton,
                  SizedBox(height: 8.0),
                  createNewAccount ? new Container() : forgotLabel,
                  loginApiCallOrProgressBar,
                ],
              ),

            ), //
          )
      ),
    );
  }

//--------------Methods---------------------

  //To hide/show password......
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: "Result : " + text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Color(0xFFFF0000),
      textColor: Colors.white,
    );
  }

  void _showSnakeBar(String text){
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: themeColor(),
      duration: Duration(seconds: 3),
    );
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showSignUpPage() {
    //TODO later
    //Make rest of the login widgets visibility gone.
    if(createNewAccount)
      {
        //Validate inputs
        if(controllerUserName.text.isEmpty || controllerEmail.text.isEmpty || controllerPassword.text.isEmpty || controllerConfirmPassword.text.isEmpty)
        {
          _showSnakeBar("Please fill all the details");
          return;
        }
        
        //To validate Email
        RegExp emailPattern = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if(!emailPattern.hasMatch(controllerEmail.text)){
          _showSnakeBar("Please enter valid Email address");
          return;
        }
        
        //To validate password
        if(controllerPassword.text.length < 8){
          _showSnakeBar("Please enter valid password");
          return;
        }
        
        if(controllerPassword.text != controllerConfirmPassword.text){

          _showSnakeBar("Password and Confirm Password doesn't match");
          return;
        }

        createNewAccount = false;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> MyHomePage( title: "From Uscreen Login Page",))
        );
      }
    setState(() {
      createNewAccount = true;
    });
  }

  void _validateLogin(){
    //Validate inputs
    if(controllerPassword.text.isEmpty || controllerEmail.text.isEmpty)
    {
      _showSnakeBar("Email and Password can not be empty");
      return;
    }

    //To validate Email
    RegExp emailPattern = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(!emailPattern.hasMatch(controllerEmail.text)){
      _showSnakeBar("Please enter valid Email address");
      return;
    }

    //To validate password
    if(controllerPassword.text.length < 8){
      _showSnakeBar("Please enter valid password");
      return;
    }

    setState(() {
      tryLogin = true;
    });
    //Call Login API
    fetchPost();

  }

  void checkSharedPreferences() async {

    SharedPreferences prefSave = await SharedPreferences.getInstance();
    String email = prefSave.get('email2');
    String userName = prefSave.get('userName');
    print(email);
    print(userName);
    setUserEmail(email);
    setUserName(userName);
    if(email!= null){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=> MyHomePage( title: "Direct Home Page",))
      );
    }

  }



//---------------------API------------------------


  //for login check
  Future<Null> fetchPost() async {

    //For Login Post method
    final response =
    await http.post('http://uscreen.io/api/v1/sessions/', headers: {'x-store-token' : 'DK/Ml+cOGvUFyQ=='},
        body: {"email": controllerEmail.text, "password": controllerPassword.text});
    //print(response.statusCode);
    //print(response.headers);
    //print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201 ) {

      SharedPreferences prefSave = await SharedPreferences.getInstance();
      //prefSave.setString('email2', controllerPassword.text);
      //prefSave.setString('password2', controllerPassword.text);
      _showToast("Successfully Login");
      print(response.body);
      final responseJson = json.decode(response.body);
      userDetails = User.fromJson(responseJson);
      //Test print
      print(userDetails.username + ' , ' + userDetails.email  + ' , ' + userDetails.token);
      prefSave.setString('userName', userDetails.username);
      prefSave.setString('email2', userDetails.email);
      setUserName(userDetails.username);
      setUserEmail(userDetails.email);

      //Test
      //getCatogories();

       Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              MyHomePage(title: 'From API Login',)));
    } else {
      // If that response was not OK, throw an error.
      print(response.toString());
      print('Failed to load post');
      _showToast("Invalid Credentials");
      setState(() {
        tryLogin = false;
      });
      //throw Exception('Failed to load post');

    }
  }

  Future<Null> getCatogories() async {

    //For Categories Get Method
    final categoriesResponse = await http.get('http://uscreen.io/api/v1/categories' , headers: {'x-store-token' : 'DK/Ml+cOGvUFyQ=='} );
    print(categoriesResponse.body);
    if(categoriesResponse.statusCode == 200)
    {
      final responseJson = json.decode(categoriesResponse.body);
      print("Get Successfully");
      var list = responseJson as List;
      print(list.runtimeType);
      List<Categories> categoryList = list.map((i) => Categories.fromJson(i)).toList();
      //Categories.fromJson(responseJson);
    } else {
      // If that response was not OK, throw an error.
      print(categoriesResponse.toString());
      print('Failed to load post');
      _showToast("Failed to load post");
      throw Exception('Failed to load post');

    }
  }
}

class User {

  final String token, username, email ;


  User({this.username, this.email , this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    String _username , _email, _token;
    _username = json['user']['name'];
    _email = json['user']['email'];
    _token = json['auth']['token'];

    //Test
    Fluttertoast.showToast(
      msg: "Result : " + _username,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Color(0xFFFF0000),
      textColor: Colors.white,
    );

    return User(username: _username ,email: _email , token: _token);

  }
}

class Categories {

  //TODO : Check https://github.com/PoojaB26/ParsingJSON-Flutter/blob/master/lib/model/product_model.dart
  int id;
  final String title , image , featured ;


  Categories({this.id, this.title , this.image , this.featured});

  factory Categories.fromJson(Map<String, dynamic> json) {
    //json = json['results'][0]; //only in case this json file. Else use lines something like below one
    int _id;
    String _title, _image , _featured;
    _id = json['id'];
    print(_id);
    _title = json['title'];
    _image = json['image'];
    _featured = json['featured'];
    return Categories(id: _id ,title: _title , image: _image ,featured: _featured );

  }
}





/*

POST http://uscreen.io/api/v1/sessions http/1.1
01-04 18:01:13.586 2074-2317/tv.megamace.android D/OkHttp: Content-Type: application/json; charset=UTF-8
01-04 18:01:13.586 2074-2317/tv.megamace.android D/OkHttp: Content-Length: 52
01-04 18:01:13.586 2074-2317/tv.megamace.android D/OkHttp: Accept: application/json
01-04 18:01:13.586 2074-2317/tv.megamace.android D/OkHttp: Accept-Language:
01-04 18:01:13.586 2074-2317/tv.megamace.android D/OkHttp: x-store-token: DK/Ml+cOGvUFyQ==
01-04 18:01:13.587 2074-2317/tv.megamace.android D/OkHttp: {"password":"87654321","email":"pnkjng88@gmail.com"}
01-04 18:01:13.587 2074-2317/tv.megamace.android D/OkHttp: --> END POST (52-byte body)
01-04 18:01:14.166 2074-2317/tv.megamace.android D/OkHttp: <-- 201 Created http://uscreen.io/api/v1/sessions (578ms)
01-04 18:01:14.166 2074-2317/tv.megamace.android D/OkHttp: Server: nginx/1.10.3 (Ubuntu)
01-04 18:01:14.166 2074-2317/tv.megamace.android D/OkHttp: Date: Fri, 04 Jan 2019 12:31:14 GMT
01-04 18:01:14.166 2074-2317/tv.megamace.android D/OkHttp: Content-Type: application/json; charset=utf-8
01-04 18:01:14.166 2074-2317/tv.megamace.android D/OkHttp: Transfer-Encoding: chunked
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: Connection: keep-alive
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: X-Frame-Options: ALLOWALL
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: Vary: Origin
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: Etag: W/"3447ac5a8716fe43bb0986bae18211c9"
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: Cache-Control: max-age=0, private, must-revalidate
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: X-Request-Id: ba005a59-4f3b-44af-925c-53cd23aa371c
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: X-Runtime: 0.165470
01-04 18:01:14.167 2074-2317/tv.megamace.android D/OkHttp: Via: 1.1 vegur
01-04 18:01:14.173 2074-2317/tv.megamace.android D/OkHttp: {"user":{"id":1008760,"name":"Pankaj negi","email":"pnkjng88@gmail.com","avatar_url":null,"custom_fields":[],"subscribed":false},"auth":{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NzgxNDEwNzQsInN1YiI6MTAwODc2MH0.C8Pe-zxzROChHKP4HXxezHilK7RyDcQL9z4OWNeB7LA"}}
01-04 18:01:14.173 2074-2317/tv.megamace.android D/OkHttp: <-- END HTTP (273-byte body)*/
