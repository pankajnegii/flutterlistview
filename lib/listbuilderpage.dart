import 'package:flutter/material.dart';

import 'drawerclass.dart';
import 'values.dart';

class MyListBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListBuilder();
  }
}

class _ListBuilder extends State<MyListBuilder> {

  List<String> androidVersionName = new List<String>();
  List<AndroidVersionDetails> androidVersionsDetails = new List<
      AndroidVersionDetails>();
  bool favorite = false;

  _ListBuilder() {
    prepareListData();
    androidVersionName.add('Cupcake1');
    androidVersionName.add('Cupcake2');
    androidVersionName.add('Cupcake3');
    androidVersionName.add('Cupcake4');
    androidVersionName.add('Cupcake5');
    androidVersionName.add('Cupcake6');
    androidVersionName.add('Cupcake7');
    androidVersionName.add('Cupcake8');
    androidVersionName.add('Cupcake9');
    androidVersionName.add('Cupcake10');
    androidVersionName.add('Cupcake11');
    androidVersionName.add('Cupcake12');
    androidVersionName.add('Cupcake13');
    androidVersionName.add('Cupcake14');
    androidVersionName.add('Cupcake15');
    androidVersionName.add('Cupcake16');
    androidVersionName.add('Cupcake17');
    androidVersionName.add('Cupcake18');
    androidVersionName.add('Cupcake19');
    androidVersionName.add('Cupcake20');
    androidVersionName.add('Cupcake21');
  }

  @override
  Widget build(BuildContext context) {
// Implementation later
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //backgroundColor: appBarColor(),
        title: Text("List Builder page (RecyclerView)"),
      ),
      body:
      /*ListView.builder(
        itemBuilder: (context, position) {
          return Card(
            color: Colors.grey,
            child: Text(
              androidVersionName[position], style: TextStyle(fontSize: 25.0),),
          );
        },
        itemCount: androidVersionName.length,
      ),*/

      /*GridView.builder(
        itemBuilder: (context, position) {
          return Card(
            color: Colors.grey,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                  color: themeColor(), width: 1.0),),
            child: Text(
              androidVersionName[position], style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,),
          );
        },
        itemCount: androidVersionName.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
      ),*/

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
                          androidVersionsDetails[position].myAndroidVersionName,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          androidVersionsDetails[position].myAndroidVersionID,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "5m",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton( 
                            icon: new Icon(favorite ? Icons.star : Icons.star_border , size: 35.0 , color: themeColor(),),
                            onPressed: (){
                              setState(() {
                                favorite = !favorite;           //TODO Issue : changing all star to red :solved in quincusflutter
                              });
                            },
                          ),
                        ),
                      ],
                    ),
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
        itemCount: androidVersionsDetails.length,
      ),

    );
  }

  //------------------Methods---------------

  void prepareListData() {
    for (int i = 0; i < 20; i++) {
      androidVersionsDetails.add(
          new AndroidVersionDetails(i.toString(), 'Cupcake' + i.toString()));
    }
  }

}

class AndroidVersionDetails {

  String myAndroidVersionName, myAndroidVersionID;

  //Constructor.....
  AndroidVersionDetails(this.myAndroidVersionID, this.myAndroidVersionName);


}
