import 'package:flutter/material.dart';

AppBar header(context , { String strTitle ,bool disappearBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    automaticallyImplyLeading: disappearBackButton ? false : true ,
    title: Text(strTitle,
      style: TextStyle(
        fontFamily: 'Amiri',
        fontSize: 22,
        color: Colors.white
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Colors.blue,
  );
}
