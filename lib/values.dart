import 'package:flutter/material.dart';

//Using classes
/*class myColor {                 //To be tested
  static Color themeColor() {
    return Color(0xFFFF0000);
  }
  //we can call this method from anywhere using
  //myColor.themeColor();

}*/
String username = "";
String useremail = "";
void setUserName(String name){
  username = name;
  print(username);
}
String getUserName(){
  return username;
}
void setUserEmail(String name){
  useremail = name;
  print(useremail);

}
String getUserEmail(){
  return useremail;
}

String getChapterTitle(){
  return 'Dirt Knights Season 1';
}

String getChaptorDetails(){
  return 'The first ever season of Dirt Knights features drivers Corey Dripps, Ryan Gustin, Al Hejna, Mike Spaulding, Jon Tesch, and Derek Ramirez as they travel across the midwest on the United States Modified Touring Series (USMTS) circuit.';
}

Color themeColor() {
  return Color(0xFFFF0000);
}

Color lightThemeColor(){
  return Color(0xFFFF2F2F);
}

Color drawerHeaderColor() {
  return themeColor();
}

Color appBarColor() {
  return themeColor();
}

Color buttonColor() {
  return themeColor();
}

Color containerColor(){
  return Color(0xFF000000);
}

Color editTextColor(){
  return Color(0xFF000000);
}
Color hintColor(){
  return Color(0xFFD2D4D3);
}
Color boxBorder(){
  return Color(0xFF3EA7DC);
}
Color greenColor(){
  return Color(0xFF2CA260);
}
Color pageBackground(){
  return Color(0xFF1D1D1D);
}

Color transparentBlack(){
  return Color(0xFF000000);
}

Color transparent(){
  return Color(0x16FFFFFF);
}

Color transparentBlack60(){
  return Color(0xA6000000);
}

Color transparentBlack80(){
  return Color(0x73000000);
}