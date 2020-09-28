import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shqlny_aliraq/models/DropDownMenu.dart';
import 'package:shqlny_aliraq/widgets/AlertWidget.dart';
import 'package:shqlny_aliraq/widgets/HeaderWidget.dart';

import 'HomePage.dart';
import 'SuccessSendDataPaget.dart';

class BusinessOwnerPage extends StatefulWidget {
  @override
  _BusinessOwnerPageState createState() => _BusinessOwnerPageState();
}

class _BusinessOwnerPageState extends State<BusinessOwnerPage> {
  static const double fontSize = 18;
  final _formKey = GlobalKey<FormState>();

  String _radioGenderValue = "ذكر", _radioCurrencyValue = "دينار";
  bool isSelectProfileImage = false;
  File imageFile;

  String id = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString() +
      "-" +
      DateTime.now().hour.toString() +
      "-" +
      DateTime.now().millisecondsSinceEpoch.toString();

  ProgressDialog pr;

  TextEditingController nameController,
      phoneNumberController,
      locationJobController,
      locationJobNameController,
      addressLocationJobController,
      jobRequiredController,
      specializationRequiredController,
      expertiseRequiredController,
      workingTimesController,
      daysRestPerMonthController,
      salaryController,
      percentageController,
      ageRequiredFromController,
      ageRequiredToController,
      moreInfoController;

  List<DropdownMenuItem<DropDownMenu>> _dropdownAcademicAchievementMenuItems;

  DropDownMenu _selectedAcademicAchievementItem;

  List<DropDownMenu> _dropdownAcademicAchievementItems = [
    DropDownMenu(1, "ابتدائية"),
    DropDownMenu(2, "متوسطة"),
    DropDownMenu(3, "اعدادية"),
    DropDownMenu(4, "دبلوم(معهد)"),
    DropDownMenu(5, "بكلوريوس"),
    DropDownMenu(5, "ماجستير"),
    DropDownMenu(5, "دكتوره")
  ];

  @override
  void initState() {
    super.initState();

    // setup academic achievement menu
    _dropdownAcademicAchievementMenuItems =
        buildDropDownMenuItems(_dropdownAcademicAchievementItems);
    _selectedAcademicAchievementItem =
        _dropdownAcademicAchievementMenuItems[0].value;

    pr = new ProgressDialog(context,
        showLogs: true, textDirection: TextDirection.rtl, isDismissible: false);

    pr.style(message: 'الرجاء الانتظار\n     جاري ارسال البيانات');

    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    locationJobController = TextEditingController();
    locationJobNameController = TextEditingController();
    addressLocationJobController = TextEditingController();
    specializationRequiredController = TextEditingController();
    expertiseRequiredController = TextEditingController();
    workingTimesController = TextEditingController();
    daysRestPerMonthController = TextEditingController();
    salaryController = TextEditingController();
    percentageController = TextEditingController();
    ageRequiredFromController = TextEditingController();
    ageRequiredToController = TextEditingController();
    moreInfoController = TextEditingController();
    jobRequiredController =TextEditingController();

    Timer(
        Duration(milliseconds: 500),
        () => termsOfUseAlert(context,
            "عزيزي صاحب العمل نحن نعمل جاهدين لتوفير افضل الموظفين لك من الناحية العلمية والعملية ولكن لا نكفل اي شخص من ناحية الثقة والامانة حيث نعمل كحلقة وصل بينك وبين الباحثين عن عمل"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "صاحب عمل", disappearBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "معلومات خاصة بصاحب العمل",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: fontSize + 2,
                              fontFamily: "Amiri",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    nameWidget(),
                    SizedBox(height: 7),
                    phoneNumberWidget(),
                    SizedBox(height: 7),
                    locationJop(),
                    SizedBox(height: 7),
                    locationJopName(),
                    SizedBox(height: 7),
                    addressLocationJop(),
                    SizedBox(height: 7),
                    jobAdPicture(),
                    SizedBox(height: 7),
                    Divider(),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "معلومات خاصة بالموظف المطلوب",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: fontSize + 2,
                            fontFamily: "Amiri",
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    jobRequired(),
                    SizedBox(height: 7),
                    academicAchievementWidget(),
                    SizedBox(height: 7),
                    specializationRequired(),
                    SizedBox(height: 7),
                    expertiseRequired(),
                    SizedBox(height: 7),
                    workingTimes(),
                    SizedBox(height: 7),
                    daysRestPerMonth(),
                    SizedBox(height: 7),
                    salary(),
                    SizedBox(height: 7),
                    genderRequired(),
                    SizedBox(height: 7),
                    ageRequired(),
                    SizedBox(height: 7),
                    moreInfoWidget(),
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
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<DropDownMenu>> items = List();
    for (DropDownMenu listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  handleRadioGenderValueChange(value) {
    setState(() {
      _radioGenderValue = value;
    });
  }

  handleRadioCurrencyValueChange(value) {
    setState(() {
      _radioCurrencyValue = value;
    });
  }

  nameWidget() {
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

  phoneNumberWidget() {
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

  locationJop() {
    return TextFormField(
      controller: locationJobController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الموقع الوظيفي",
          hintText: "ادخل الموقع الوظيفي هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  locationJopName() {
    return TextFormField(
      controller: locationJobNameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "اسم مكان العمل",
          hintText: "ادخل اسم مكان العمل هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  addressLocationJop() {
    return TextFormField(
      controller: addressLocationJobController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "عنوان مكان العمل",
          hintText: "ادخل عنوان مكان العمل هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }
  jobRequired() {
    return TextFormField(
      controller: jobRequiredController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الوظيفة المطلوبة",
          hintText: "ادخل الوظيفة المطلوبة هنا",
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }
  academicAchievementWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "التحصيل الدراسي :",
              style: TextStyle(fontSize: fontSize),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedAcademicAchievementItem,
                  items: _dropdownAcademicAchievementMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedAcademicAchievementItem = value;
                    });
                  }),
            ),
          ],
        ));
  }

  specializationRequired() {
    return TextFormField(
      controller: specializationRequiredController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الاختصاص المطلوب",
          hintText: "ادخل الاختصاص المطلوب هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  expertiseRequired() {
    return TextFormField(
      controller: expertiseRequiredController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الخبرات المطلوبة",
          hintText: "ادخل الخبرات المطلوبة هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  workingTimes() {
    return TextFormField(
      controller: workingTimesController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "اوقات العمل",
          hintText: "ادخل اوقات العمل هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  daysRestPerMonth() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: daysRestPerMonthController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "عدد ايام الاستراحة بالشهر",
          hintText: "ادخل عدد ايام الاستراحة بالشهر هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  salary() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 2),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: salaryController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'مطلوب';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "الراتب",
                  hintText: "ادخل الراتب هنا",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                new Radio(
                  value: "دينار",
                  groupValue: _radioCurrencyValue,
                  onChanged: handleRadioCurrencyValueChange,
                ),
                new Text(
                  'دينار',
                  style: new TextStyle(fontSize: fontSize),
                ),
                new Radio(
                  value: "دولار",
                  groupValue: _radioCurrencyValue,
                  onChanged: handleRadioCurrencyValueChange,
                ),
                new Text(
                  'دولار',
                  style: new TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  percentage() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: percentageController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "النسبة",
          hintText: "ادخل النسبة هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  genderRequired() {
    return Container(
      height: 70,
      padding: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'الجنس : ',
            style: new TextStyle(
              fontSize: fontSize,
            ),
          ),
          new Radio(
            value: "ذكر",
            groupValue: _radioGenderValue,
            onChanged: handleRadioGenderValueChange,
          ),
          new Text(
            'ذكر',
            style: new TextStyle(fontSize: fontSize),
          ),
          new Radio(
            value: "انثى",
            groupValue: _radioGenderValue,
            onChanged: handleRadioGenderValueChange,
          ),
          new Text(
            'انثى',
            style: new TextStyle(
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  ageRequired() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "العمر المطلوب :",
                style: TextStyle(fontSize: fontSize),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 4,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'مطلوب';
                        }
                        return null;
                      },
                      controller: ageRequiredFromController,
                      decoration: InputDecoration(
                          labelText: "من",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  SizedBox(width: 4),
                  Flexible(
                      child: Text(
                    "سنة",
                    style: TextStyle(fontSize: fontSize),
                  )),
                  SizedBox(width: 5),
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'مطلوب';
                        }
                        return null;
                      },
                      controller: ageRequiredToController,
                      decoration: InputDecoration(
                          labelText: "الى",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                      flex: 3,
                      child: Text(
                        "سنة",
                        style: TextStyle(fontSize: fontSize),
                      )),
                ],
              ),
            ],
          )),
    );
  }

  moreInfoWidget() {
    return TextFormField(
      controller: moreInfoController,
      maxLines: 7,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "معلومات اضافية",
          //   hintText: "معلومات اضافية" ,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  jobAdPicture() {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 8, left: 8, top: 20),
      child: Column(
        children: [
          Image(
            image: isSelectProfileImage
                ? FileImage(imageFile)
                : AssetImage("assets/images/image_ads.png"),
            width: MediaQuery.of(context).size.width,
            height: 180,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: InkWell(
              child: Text(" تحديد صورة لنشرها مع الاعلان",
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
              onTap: () => pickImageFromGallery(),
            ),
          )
        ],
      ),
    );
  }

  pickImageFromGallery() async {
    File file = (await ImagePicker.pickImage(source: ImageSource.gallery));
    setState(() {
      imageFile = file;

      if (imageFile != null)
        isSelectProfileImage = true;
      else
        isSelectProfileImage = false;
    });
  }

  Future<String> uploadPhoto() async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("job ads pictures");
    if (isSelectProfileImage) {
      StorageUploadTask storageUploadTask =
          storageReference.child("post_$id.jpg").putFile(imageFile);
      StorageTaskSnapshot storageTaskSnapshot =
          await storageUploadTask.onComplete;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return "";
    }
  }

  void saveDataToFireStore() async {
    pr.show();
    var imgUrl = await uploadPhoto();
    businessOwnerReference.document(id).setData({
      "id": id,
      "name": nameController.text,
      "gender": _radioGenderValue,
      "phoneNumber": phoneNumberController.text,
      "locationJop": locationJobController.text,
      "locationJopName": locationJobNameController.text,
      "addressLocationJop": addressLocationJobController.text,
      "academicAchievement": _selectedAcademicAchievementItem.name,
      "jobRequired" : jobRequiredController.text,
      "specializationRequired": specializationRequiredController.text,
      "expertiseRequired": expertiseRequiredController.text,
      "workingTimes": workingTimesController.text,
      "daysRestPerMonth": daysRestPerMonthController.text,
      "salary":  "${salaryController.text + " " +_radioCurrencyValue}" ,
      "ageRequired": " من " +
          ageRequiredFromController.text +
          " الى " +
          ageRequiredToController.text,

      "moreInfo": moreInfoController.text,
      "imgUrl": imgUrl
    }).then((value) => {
          pr.hide().whenComplete(() => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessSendDataWidget(
                            "شكرا لتسجيل معلوماتك سنتواصل معك في اقرب وقت ممكن")))
              })
        });
  }



}
