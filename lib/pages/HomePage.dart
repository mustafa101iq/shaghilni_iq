import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shqlny_aliraq/pages/AboutPage.dart';
import 'package:shqlny_aliraq/pages/JopSearcherPage.dart';
import 'package:shqlny_aliraq/pages/NotePage.dart';
import 'package:shqlny_aliraq/widgets/HeaderWidget.dart';
import 'BusinessOwnerPage.dart';


final jopSearcherReference = Firestore.instance.collection("jopSearcher");
final StorageReference storageReference = FirebaseStorage.instance.ref().child("Personal Pictures");
final businessOwnerReference = Firestore.instance.collection("businessOwner");
final notesReference = Firestore.instance.collection("notes");

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context,
            strTitle: "الصفحة الرئيسية", disappearBackButton: true),
        body: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF3366FF),
                    const Color(0xFF00CCFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      createButton(
                          title: "باحث عن وظيفة",
                          imgUrl: 'assets/images/search_job.png',
                          page: JopSearcherPage(),
                          startColor: Colors.amber,
                          endColor: Colors.amberAccent),
                      createButton(
                          title: "صاحب عمل",
                          imgUrl: 'assets/images/business.png',
                          page: BusinessOwnerPage(),
                          startColor: Colors.lightGreen,
                          endColor: Colors.green),
                      createButton(
                          title: "ارسال ملاحظات",
                          imgUrl: 'assets/images/note.png',
                          page: NotePage(),
                          startColor: Colors.pink,
                          endColor: Colors.red),
                      createButton(
                          title: "حول شغلني",
                          imgUrl: 'assets/images/about.png',
                          page:AboutPage(),
                          startColor: Colors.purple,
                          endColor: Colors.deepPurpleAccent),
                    ],
                  )
                ],
              ),
            )));
  }

//  createButton1({String title, Widget page}) {
//    return Padding(
//      padding: EdgeInsets.only(top: 50),
//      child: Material(
//        //Wrap with Material
//        shape:
//            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
//        elevation: 18.0,
//        color: Color(0xFF801E48),
//        clipBehavior: Clip.antiAlias,
//        // Add This
//        child: MaterialButton(
//          minWidth: 300.0,
//          height: 60,
//          color: Color(0xFF801E48),
//          child: new Text(title,
//              style: new TextStyle(
//                  fontSize: 25.0,
//                  color: Colors.white,
//                  fontFamily: "Amiri",
//                  fontWeight: FontWeight.bold)),
//          onPressed: () {
//            Navigator.push(context,
//                new MaterialPageRoute(builder: (BuildContext context) => page));
//          },
//        ),
//      ),
//    );
//  }

  createButton(
      {String title,
      String imgUrl,
      Widget page,
      Color startColor,
      Color endColor}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => page)),
        child: Stack(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                      colors: [startColor, endColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: endColor,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    )
                  ]),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter: customCardShapePaint(24, startColor, endColor),
              ),
            ),
            Positioned(
              top: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  Image(image: AssetImage(imgUrl), width: 70, height: 120),
                  SizedBox(width: 35),
                  Text(title,
                      style: new TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontFamily: "Amiri",
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class customCardShapePaint extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  customCardShapePaint(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
