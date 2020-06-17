import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class ProjectResource{

  static String baseUrl = "https://rcapp.utech.dev/api/";
  static String currentValidUserToken;


  static double screenWidth = 0;
  static double screenHeight = 0;
  static BuildContext currentContext;
  static BuildContext loaderContext;
  static Color loginBackColor =
  Color.fromARGB(255, 14, 36, 82);
  static Color brandOrangeColor = Color(0xffF9A219);
  static Color deepOrangeColor = Colors.deepOrange;
  static Color whiteColor = Colors.white;
  static Color darkBlueColor = Color(0xff0F2654);
  static Color blueColor = Color(0xff0079C1);
  static Color fontColor = Color(0xff666666);
  static Color darkColor = Colors.black;
  static Color greenColor = Color(0xff28C844);
  static Color darkGreenColor = Color(0xff148d1d);
  static Color darkRedColor = Color(0xffA94442);
  static Color greyColor = Color(0xffE5E8E8);
  static Color shadowColor = Color(0xff7E92C8).withOpacity(0.2);
  static var pagePadding = EdgeInsets.only(top: 5,left: 20,right: 20);
  static BorderRadiusGeometry roundedBorder = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));

  static FontWeight fontSemiBold = FontWeight.w600;
  static double bodyFontSize;
  static double headerFontSize;
  static double appBarFontSize;
  static double dialogBoxFontSize;

  static void statusBar (){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
    ));
  }



  static void setScreenSize(BuildContext context) {
    currentContext = context;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    screenHeight = screenWidth < screenHeight
        ? screenHeight
        : (screenWidth / screenHeight) * screenWidth;
    bodyFontSize = screenWidth*0.035;
    headerFontSize = screenWidth*0.04;
    appBarFontSize = screenWidth*0.05;
    dialogBoxFontSize = screenWidth*0.03;
  }

  static showToast(String text, bool isError, [String gravity]) {
    Color textColor = Colors.white;
    Color backColor = Colors.green;
    if (isError) {
      textColor = Colors.white;
      backColor = Colors.red;
    }
    if (gravity == "top") {
      Toast.show(text, currentContext,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: backColor,
          textColor: textColor);
    } else if (gravity == "willpop") {
      Toast.show(text, currentContext,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else {
      Toast.show(text, currentContext,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: backColor,
          textColor: textColor);
    }
  }
}