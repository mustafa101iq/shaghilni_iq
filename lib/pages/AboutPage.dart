import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shqlny_aliraq/widgets/HeaderWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final phoneNumber = "07719448442";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            header(context, strTitle: "حول شغلني", disappearBackButton: false),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'نهدف في شغلني للوظائف في العراق ان نكون حلقة الوصل بين الباحثين عن عمل واصحاب العمل يمكنك التواصل معنا عبر :',
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                          fontFamily: "Amiri",
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  elevation: 5),
              Card(
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'رقم الهاتف : $phoneNumber',
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
                                fontFamily: "Amiri",
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                      color: Colors.blueAccent,
                      iconSize: 30,
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.phone),
                      onPressed: () {
                      callNumber(phoneNumber);
                      }),
                      )
                    ],
                  ),
                  elevation: 5),
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                                child: IconButton(
                                    color: Colors.blueAccent,
                                    iconSize: 40,
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.facebook),
                                    onPressed: () {
                                      openFacebookPage();
                                    })),
                            Flexible(
                                child: IconButton(
                                    color: Colors.pink,
                                    iconSize: 40,
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.instagram),
                                    onPressed: () {
                                      openInstagramPage();
                                    })),
                            Flexible(
                                child: IconButton(
                                    iconSize: 40,
                                    color: Colors.blueAccent,
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.envelope),
                                    onPressed: () {
                                    sendMessageByEmail("shaghilni.iq@gmail.com", "تطبيق شغلني العراق", "");
                                    })),
                            Flexible(
                                child: IconButton(
                                    iconSize: 40,
                                    color: Colors.green,
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                                    onPressed: () {
                                      openWhatsApp();
                                    })),
                            Flexible(
                                child: IconButton(
                                    iconSize: 40,
                                    color: Colors.blueAccent,
                                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                    icon: FaIcon(FontAwesomeIcons.telegram),
                                    onPressed: () {
                                    openTelegram();
                                    })),
                          ],
                        ),
                      )),
                  elevation: 5),
            ]),
          ),
        ));
  }

  void openFacebookPage() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/shaghilni.iq';
    } else {
      fbProtocolUrl = 'fb://page/shaghilni.iq';
    }

    String fallbackUrl = 'https://www.facebook.com/shaghilni.iq';

    try {
//    bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      bool launched = false;

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  void openInstagramPage() async {
    var url = 'https://www.instagram.com/shaghilni_iq/';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
        forceSafariVC: true,
enableJavaScript: true,
enableDomStorage: true
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  void openWhatsApp() async {
    var whatsappUrl ="whatsapp://send?phone=+964$phoneNumber";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
  void openTelegram() async {
    var whatsappUrl ="https://telegram.me/shaghilni_iraq";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  sendMessageByEmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  callNumber(String number){
    launch("tel://$number");
  }
}
