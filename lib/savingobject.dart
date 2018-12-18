import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'drawerclass.dart';
import 'values.dart';

class MySavingObject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavingObject();
  }
}

class _SavingObject extends State<MySavingObject> {

  List<FavouriteLocation> myFavouriteLocations = new List<FavouriteLocation>();
  _SavingObject(){
    prepareListData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("Saving Objects List"),
      ),
      floatingActionButton:

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(left: 30.0),
            child: RaisedButton(

              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),),
              color: themeColor(),
              child: Text('Save List', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400),),
              onPressed: () {
                _saveList();
              },
            ),
          ),

          RaisedButton(

            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),),
            color: themeColor(),
            child: Text('Retrieve List', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400),),
            onPressed: () {
              _retrieveList();
            },
          ),
        ],
      ),
      body:
       // new Text("List here"),
      ListView.builder(
        itemBuilder: (context, position) {
          return Column(//
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          myFavouriteLocations[position].title,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          myFavouriteLocations[position].description,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
          );//
        },
        itemCount: myFavouriteLocations.length,
      ),

    );
  }

  //------------------Methods-------------------
  void prepareListData() {
    for (int i = 0; i < 6; i++) {
      myFavouriteLocations.add(
          new FavouriteLocation(i, 'Title' + i.toString(), 'Description' + i.toString(), 28.630896 + i/1000, 77.286937 + i/1000));
    }
    //For checking response
    //printList('prepareListData', myFavouriteLocations);
  }

  void _saveList()  async {
    int i = myFavouriteLocations.length  ;
    final String listkey = 'MyfavouriteLocations';
    myFavouriteLocations.add(new FavouriteLocation(i, 'Title' + i.toString(), 'Description' + i.toString(), 28.630896 + i/1000, 77.286937 + i/1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(listkey, json.encode(myFavouriteLocations));
    //For checking response
    //print(prefs.get(listkey));
  }

  void _retrieveList() async{
    final String listkey = 'MyfavouriteLocations';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myFavouriteLocations = [];
    json
        .decode(prefs.getString(listkey))
        .forEach((map) => myFavouriteLocations.add(new FavouriteLocation.fromJson(map))
    );
    //For checking response
    //printList('_retrieveList', myFavouriteLocations);
    // don't forget to call setState((){}) to update the Widgets
    setState(() {

    });
  }

  void printList(String calledFrom , List<FavouriteLocation> fl){
    print(calledFrom);
    for(int i = 0 ; i<fl.length ; i++){
      print(fl[i].title);
      print(fl[i].description);

    }
  }

}

class FavouriteLocation {
  int _index;
  String _title, _description;
  double _laty;
  double _longy;

  FavouriteLocation(this._index, this._title, this._description, this._laty,
      this._longy);

  //getter methods (generated using right click in class name)
  int get index => _index;

  double get longy => _longy;

  double get laty => _laty;

  String get description => _description;

  String get title => _title;

  FavouriteLocation.fromJson(Map<String, dynamic> json){
    _index = json['index'];
    _title = json['title'];
    _description = json['description'];
    _longy = json['longy'];
    _laty = json['laty'];
  }

  Map<String, dynamic> toJson() =>
      {
        'index' : _index,
        'title' : _title,
        'description' : _description,
        'laty'  : _laty,
        'longy' : _longy,
      };

}

