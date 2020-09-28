import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shqlny_aliraq/pages/HomePage.dart';


void termsOfUseAlert(context,content) {
  Alert(
      closeFunction: () => Navigator.pop(context),
      context: context,
      title: "شروط الاستخدام",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              content,
              style: TextStyle(fontSize: 20, fontFamily: "Amiri"),textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "موافق",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ModalRoute.withName('/'));
          },
          child: Text(
            "غير موافق",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
