import 'package:flutter/material.dart';
import 'package:shqlny_aliraq/pages/HomePage.dart';


class SuccessSendDataWidget extends StatefulWidget {
  final String msg;
  SuccessSendDataWidget(this.msg);

  @override
  _SuccessSendDataWidgetState createState() => _SuccessSendDataWidgetState(msg);
}

class _SuccessSendDataWidgetState extends State<SuccessSendDataWidget> {

  final String msg;
  _SuccessSendDataWidgetState(this.msg);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [
        const Color(0xFF0D324D),
        const Color(0xFF7F5A83),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
                child: Text(msg ,
                style: new TextStyle(
                    fontSize:30.0,
                    color: Colors.white,
                    fontFamily: "Amiri",
                    fontWeight: FontWeight.bold) ,textAlign: TextAlign.center,),
            ),
          ),
            MaterialButton(
              minWidth: 300.0,
              height: 60,
              color: Color(0xFF0D324D),
              child: new Text('العودة الى القائمة الرئيسية', style: new TextStyle(fontSize: 25.0, color: Colors.lightGreen,fontFamily: "Amiri",fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    ));
  }
}
