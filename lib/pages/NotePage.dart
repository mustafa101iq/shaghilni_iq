import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shqlny_aliraq/pages/HomePage.dart';
import 'package:shqlny_aliraq/widgets/HeaderWidget.dart';

import 'SuccessSendDataPaget.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  static const double fontSize = 18;
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;

  String id = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString() +
      "-" +
      DateTime.now().hour.toString() +
      "-" +
      DateTime.now().millisecondsSinceEpoch.toString();

  TextEditingController noteController, nameController, phoneNumberController;

  @override
  void initState() {
    super.initState();

    noteController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();

    pr = new ProgressDialog(context,
        showLogs: true, textDirection: TextDirection.rtl, isDismissible: false);
    pr.style(message: 'الرجاء الانتظار\n     جاري ارسال البيانات');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          strTitle: "ارسال ملاحظات", disappearBackButton: false),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  note(),
                  SizedBox(height: 7),
                  name(),
                  SizedBox(height: 7),
                  phoneNumber(),
                  SizedBox(height: 7),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 30),
                      child: Material(
                        //Wrap with Material
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        elevation: 18.0,
                        color: Colors.blue,
                        clipBehavior: Clip.antiAlias,
                        // Add This
                        child: MaterialButton(
                          minWidth: 300.0,
                          height: 60,
                          color: Colors.blue,
                          child: new Text('ارسال',
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontFamily: "Amiri",
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              saveDataToFireStore();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }

  note() {
    return TextFormField(
      controller: noteController,
      maxLines: 9,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الملاحظة",
          hintText: "ادخل محلاحظتك هنا ...",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  name() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الاسم الثلاثي",
          hintText: "ادخل اسمك الثلاثي هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  phoneNumber() {
    return TextFormField(
      controller: phoneNumberController,
      maxLength: 11,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        } else if (int.parse(value) < 11) {
          return 'الرقم غير صحيح';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "رقم الهاتف",
          hintText: "ادخل رقم الهاتف هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  void saveDataToFireStore() async {
    pr.show();

    notesReference.document(id).setData({
      "id": id,
      "note": noteController.text,
      "name": nameController.text,
      "phoneNumber": phoneNumberController.text,
    }).then((value) => {
          pr.hide().whenComplete(() => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessSendDataWidget(
                            "نشكرك على اهتمامك وارسال الملاحضات لنا .. سيتم اخذها بنظر الاعتبار والتواصل معك في حال احتجنا الى ذلك")))
              })
        });
  }
}
