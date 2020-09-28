import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shqlny_aliraq/models/message.dart';
import 'package:shqlny_aliraq/pages/HomePage.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
      gradient: new LinearGradient(
      colors: [
          const Color(0xFF256ad9),
        const Color(0xFF6c98e0),

        ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
    ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createSplashIcon(),
                createSplashText(),
                createSplashButton()
                ],
    ),)
    ,
    );
  }

  createSplashIcon() {
    return Center(
      child:  Image(image: AssetImage('assets/images/logo.png'),width:350,height: 310,),
    );
  }

  createSplashText() {
    return Center(
      child: Text("اهلا بكم\n في تطبيق شغلني للوظائف في العراق للاستمرار اضغط التالي",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Amiri",fontSize: 29),textAlign: TextAlign.center,) ,
    );
  }

  createSplashButton() {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Material(  //Wrap with Material
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
        elevation: 18.0,
        color: Color(0xFF801E48),
        clipBehavior: Clip.antiAlias, // Add This
        child: MaterialButton(
          minWidth: 300.0,
          height: 60,
          color: Color(0xFF801E48),
          child: new Text('التالي', style: new TextStyle(fontSize: 25.0, color: Colors.white,fontFamily: "Amiri",fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          },
        ),
      ),
    );
  }

}
