import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shqlny_aliraq/models/DropDownMenu.dart';
import 'package:shqlny_aliraq/models/PreviousWorkControllerItem.dart';
import 'package:shqlny_aliraq/pages/HomePage.dart';
import 'package:shqlny_aliraq/widgets/AlertWidget.dart';
import 'package:shqlny_aliraq/widgets/HeaderWidget.dart';
import 'file:///C:/Users/mustafa/AndroidStudioProjects/FlutterProjects/shqlny_aliraq/lib/pages/SuccessSendDataPaget.dart';

class JopSearcherPage extends StatefulWidget {
  @override
  _JopSearcherPageState createState() => _JopSearcherPageState();
}

class _JopSearcherPageState extends State<JopSearcherPage> {
  int countPreviousWork = 1;

  List<Widget> previousWorkList;
  final _formKey = GlobalKey<FormState>();
  static const double fontSize = 18;

  bool checkedNationalityValue = true,
      isSelectProfileImage = false,
      isEnableOtherNationality = false,
      isEnableOtherSpecialization = false,
      isUniversityStudent = false,
      minusButtonVisible = false,
      loadingUploadData = false;

  String _radioGenderValue = "ذكر",
      _radioSpecializationValue = "ضمن اختصاصي",
      _radioNationalityValue = "عراقي";

  File imageFile;
  DateTime selectedDate = DateTime.now();

  TextEditingController nameController,
      nationalityController,
      phoneNumberController,
      addressController,
      emailController,
      universityController,
      collegeController,
      specializationController,
      graduationYearController,
      searchWorkController,
      timeStayWorkController,
      moreInfoController,
      previousWorkController1,
      previousWorkController2,
      previousWorkController3,
      previousWorkController4,
      previousWorkController5,
      previousWorkLengthController1,
      previousWorkLengthController2,
      previousWorkLengthController3,
      previousWorkLengthController4,
      previousWorkLengthController5;

  List<PreviousWorkControllerItem> textPreviousWorkControllerList = [];

  List<DropdownMenuItem<DropDownMenu>> _dropdownMarriageStatusManMenuItems,
      _dropdownMarriageStatusWomanMenuItems,
      _dropdownGovernorateMenuItems,
      _dropdownAcademicAchievementMenuItems,
      _dropdownWorkTypeMenuItems,
      _dropdownNumberMenuItems;
  DropDownMenu _selectedMarriageStatusItem,
      _selectedGovernorateItem,
      _selectedAcademicAchievementItem,
      _selectedWorkTypeItem,
      _selectedNumberOfficeItem,
      _selectedNumberDesignItem,
      _selectedNumberEnglishItem;

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

  List<DropDownMenu> _dropdownMarriageStatusManItems = [
    DropDownMenu(1, "اعزب"),
    DropDownMenu(2, "خاطب"),
    DropDownMenu(3, "متزوج"),
    DropDownMenu(4, "مطلق"),
    DropDownMenu(5, "ارمل")
  ];
  List<DropDownMenu> _dropdownMarriageStatusWomanItems = [
    DropDownMenu(1, "عزباء"),
    DropDownMenu(2, "مخطوبة"),
    DropDownMenu(3, "متزوجة"),
    DropDownMenu(4, "مطلقة"),
    DropDownMenu(5, "ارملة")
  ];
  List<DropDownMenu> _dropdownGovernorateItems = [
    DropDownMenu(1, "بغداد"),
    DropDownMenu(2, "كربلاء"),
    DropDownMenu(3, "ديالى"),
    DropDownMenu(4, "بابل"),
    DropDownMenu(5, "النجف"),
    DropDownMenu(6, "البصرة"),
    DropDownMenu(7, "ذي قار"),
    DropDownMenu(8, "كركوك"),
    DropDownMenu(9, "الانبار"),
    DropDownMenu(10, "نينوى"),
    DropDownMenu(11, "صلاح الدين"),
    DropDownMenu(12, "القادسية"),
    DropDownMenu(13, "واسط"),
    DropDownMenu(14, "ميسان"),
    DropDownMenu(15, "المثنى"),
    DropDownMenu(16, "اربيل"),
    DropDownMenu(17, "سليمانية"),
    DropDownMenu(18, "دهوك"),
  ];
  List<DropDownMenu> _dropdownAcademicAchievementItems = [
    DropDownMenu(1, "ابتدائية"),
    DropDownMenu(2, "متوسطة"),
    DropDownMenu(3, "اعدادية"),
    DropDownMenu(4, "دبلوم(معهد)"),
    DropDownMenu(5, "بكلوريوس"),
    DropDownMenu(5, "ماجستير"),
    DropDownMenu(5, "دكتوره")
  ];
  List<DropDownMenu> _dropdownWorkTypeItems = [
    DropDownMenu(1, "صباحي"),
    DropDownMenu(2, "مسائي"),
    DropDownMenu(3, "ليلي"),
    DropDownMenu(4, "اي وقت"),
  ];
  List<DropDownMenu> _dropdownNumberItems = [
    DropDownMenu(1, "1"),
    DropDownMenu(2, "2"),
    DropDownMenu(3, "3"),
    DropDownMenu(4, "4"),
    DropDownMenu(5, "5"),
    DropDownMenu(6, "6"),
    DropDownMenu(7, "7"),
    DropDownMenu(8, "8"),
    DropDownMenu(9, "9"),
    DropDownMenu(10, "10")
  ];

  @override
  void initState() {
    super.initState();

    // setup marriage status menu
    _dropdownMarriageStatusManMenuItems =
        buildDropDownMenuItems(_dropdownMarriageStatusManItems);
    _dropdownMarriageStatusWomanMenuItems =
        buildDropDownMenuItems(_dropdownMarriageStatusWomanItems);
    _selectedMarriageStatusItem = _dropdownMarriageStatusManMenuItems[0].value;

    // setup governorate menu
    _dropdownGovernorateMenuItems =
        buildDropDownMenuItems(_dropdownGovernorateItems);
    _selectedGovernorateItem = _dropdownGovernorateMenuItems[0].value;

    // setup academic achievement menu
    _dropdownAcademicAchievementMenuItems =
        buildDropDownMenuItems(_dropdownAcademicAchievementItems);
    _selectedAcademicAchievementItem =
        _dropdownAcademicAchievementMenuItems[0].value;

    // setup work type menu
    _dropdownWorkTypeMenuItems = buildDropDownMenuItems(_dropdownWorkTypeItems);
    _selectedWorkTypeItem = _dropdownWorkTypeMenuItems[0].value;

    // setup number menu
    _dropdownNumberMenuItems = buildDropDownMenuItems(_dropdownNumberItems);
    _selectedNumberOfficeItem = _dropdownNumberMenuItems[0].value;
    _selectedNumberDesignItem = _dropdownNumberMenuItems[0].value;
    _selectedNumberEnglishItem = _dropdownNumberMenuItems[0].value;

    //initialize text editing control
    nameController = TextEditingController();
    nationalityController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    universityController = TextEditingController();
    collegeController = TextEditingController();
    specializationController = TextEditingController();
    graduationYearController = TextEditingController();
    searchWorkController = TextEditingController();
    timeStayWorkController = TextEditingController();
    moreInfoController = TextEditingController();
    previousWorkController1 = TextEditingController();
    previousWorkController2 = TextEditingController();
    previousWorkController3 = TextEditingController();
    previousWorkController4 = TextEditingController();
    previousWorkController5 = TextEditingController();
    previousWorkLengthController1 = TextEditingController();
    previousWorkLengthController2 = TextEditingController();
    previousWorkLengthController3 = TextEditingController();
    previousWorkLengthController4 = TextEditingController();
    previousWorkLengthController5 = TextEditingController();

    textPreviousWorkControllerList.add(PreviousWorkControllerItem(
        previousWorkController1, previousWorkLengthController1));
    textPreviousWorkControllerList.add(PreviousWorkControllerItem(
        previousWorkController2, previousWorkLengthController2));
    textPreviousWorkControllerList.add(PreviousWorkControllerItem(
        previousWorkController3, previousWorkLengthController3));
    textPreviousWorkControllerList.add(PreviousWorkControllerItem(
        previousWorkController4, previousWorkLengthController4));
    textPreviousWorkControllerList.add(PreviousWorkControllerItem(
        previousWorkController5, previousWorkLengthController5));

    pr = new ProgressDialog(context,
        showLogs: true, textDirection: TextDirection.rtl, isDismissible: false);
    pr.style(message: 'الرجاء الانتظار\nجاري ارسال البيانات');

    Timer(
        Duration(milliseconds: 500),
        () => termsOfUseAlert(context,
            "اذا كنت تبحث عن عمل يجب ان تعلم بأننا سنكون حلقة الوصل بينك وبين صاحب العمل وقد تتطلب هذه العملية دفع بعض الاجور عند حصولك على العمل الذي ترغب به , كما أننا لسنا مسؤولين عن أي شئ سوى حصولك على فرصة العمل المطلوبة"));
  }

  @override
  Widget build(BuildContext context) {
    previousWorkList = List.generate(
        countPreviousWork,
        (index) => previousWorkRow(
            textPreviousWorkControllerList[index].previousWorkController,
            textPreviousWorkControllerList[index]
                .previousWorkLengthController));

    return Scaffold(
      appBar:
          header(context, strTitle: "باحث عن عمل", disappearBackButton: false),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    nameWidget(),
                    SizedBox(height: 7),
                    genderWidget(),
                    SizedBox(height: 7),
                    birthDateWidget(),
                    SizedBox(height: 7),
                    nationalityWidget(),
                    SizedBox(height: 7),
                    marriageStatusWidget(),
                    SizedBox(height: 7),
                    phoneNumberWidget(),
                    SizedBox(height: 7),
                    governorateWidget(),
                    SizedBox(height: 7),
                    addressWidget(),
                    SizedBox(height: 7),
                    emailWidget(),
                    SizedBox(height: 7),
                    academicAchievementWidget(),
                    SizedBox(height: 7),
                    universityWidget(),
                    SizedBox(height: 7),
                    collegeWidget(),
                    SizedBox(height: 7),
                    specializationWidget(),
                    SizedBox(height: 7),
                    graduationYearWidget(),
                    SizedBox(height: 7),
                    previousWorkPlacesWidget(),
                    SizedBox(height: 7),
                    searchWorkWidget(),
                    SizedBox(height: 7),
                    workTypeWidget(),
                    SizedBox(height: 7),
                    canWorkToWidget(),
                    SizedBox(height: 7),
                    microsoftOfficeKnownWidget(),
                    SizedBox(height: 7),
                    designProgramKnownWidget(),
                    SizedBox(height: 7),
                    englishKnownWidget(),
                    SizedBox(height: 7),
                    moreInfoWidget(),
                    SizedBox(height: 7),
                    profilePictureWidget(),
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
            ],
          )),
    );
  }

  void _handleRadioGenderValueChange(value) {
    setState(() {
      _radioGenderValue = value;
      //change Marriage Status list item value start
      _dropdownMarriageStatusManMenuItems =
          buildDropDownMenuItems(_dropdownMarriageStatusManItems);
      _dropdownMarriageStatusWomanMenuItems =
          buildDropDownMenuItems(_dropdownMarriageStatusWomanItems);
      if (_radioGenderValue == "ذكر") {
        _selectedMarriageStatusItem =
            _dropdownMarriageStatusManMenuItems[0].value;
      } else {
        _selectedMarriageStatusItem =
            _dropdownMarriageStatusWomanMenuItems[0].value;
      }
      //change Marriage Status list item value end
    });
  }

  _handleRadioSpecializationValueChange(value) {
    _radioSpecializationValue = value;

    // 0 is value of within Specialization  in radio button
    // 1 is value of other Specialization  in radio button
    if (_radioSpecializationValue == "ضمن اختصاصي") {
      setState(() {
        isEnableOtherSpecialization = false;
      });
    } else {
      setState(() {
        isEnableOtherSpecialization = true;
      });
    }
  }

  _handleRadioNationalityValueChange(value) {
    _radioNationalityValue = value;

    // 0 is value of within Specialization  in radio button
    // 1 is value of other Specialization  in radio button
    if (_radioNationalityValue == "عراقي") {
      setState(() {
        isEnableOtherNationality = false;
      });
    } else {
      setState(() {
        isEnableOtherNationality = true;
      });
    }
  }

  _selectDate(BuildContext context) async {
    var year = DateTime.now().year + 1;

    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950),
        maxTime: DateTime(year), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      setState(() {
        selectedDate = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.ar);
  }

  previousWorkRow(TextEditingController previousWorkController,
      TextEditingController previousWorkLengthController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: new TextField(
              controller: previousWorkController,
              decoration: InputDecoration(
                  labelText: "مكان العمل السابق",
                  hintText: "ادخل مكان عملك السابق هنا",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          SizedBox(width: 4),
          Flexible(
            flex: 1,
            child: TextField(
              controller: previousWorkLengthController,
              decoration: InputDecoration(
                  labelText: "المدة",
                  hintText: "المدة",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
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

  genderWidget() {
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
            onChanged: _handleRadioGenderValueChange,
          ),
          new Text(
            'ذكر',
            style: new TextStyle(fontSize: fontSize),
          ),
          new Radio(
            value: "انثى",
            groupValue: _radioGenderValue,
            onChanged: _handleRadioGenderValueChange,
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

  birthDateWidget() {
    return GestureDetector(
        child: Container(
          height: 70,
          padding: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Text(
                "تاريخ الميلاد : ",
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
            ],
          ),
        ),
        onTap: () => _selectDate(context));
  }

  nationalityWidget() {
    return Container(
      height: 130,
      padding: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            children: [
              Text(
                "الجنسية :",
                style: TextStyle(fontSize: fontSize),
              ),
              Radio(
                value: "عراقي",
                groupValue: _radioNationalityValue,
                onChanged: _handleRadioNationalityValueChange,
              ),
              Text(
                'عراقي',
                style: new TextStyle(fontSize: fontSize),
              ),
              Radio(
                value: "اخرى",
                groupValue: _radioNationalityValue,
                onChanged: _handleRadioNationalityValueChange,
              ),
              Text(
                'اخرى',
                style: new TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: nationalityController,
            enabled: isEnableOtherNationality,
            decoration: InputDecoration(
                labelText: "اخرى",
                hintText: "ادخل جنسيتك هنا",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          )
        ],
      ),
    );
  }

  marriageStatusWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "الحالة الزوجية :",
              style: TextStyle(fontSize: fontSize),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedMarriageStatusItem,
                  items: _radioGenderValue == "ذكر"
                      ? _dropdownMarriageStatusManMenuItems
                      : _dropdownMarriageStatusWomanMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedMarriageStatusItem = value;
                    });
                  }),
            ),
          ],
        ));
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

  governorateWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "المحافظة :",
              style: TextStyle(fontSize: fontSize),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedGovernorateItem,
                  items: _dropdownGovernorateMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedGovernorateItem = value;
                    });
                  }),
            ),
          ],
        ));
  }

  addressWidget() {
    return TextFormField(
      controller: addressController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "عنوان السكن الكامل",
          hintText: "ادخل عنوانك هنا ...",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  emailWidget() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "البريد الالكتروني (اختياري)",
          hintText: "ادخل بريدك الالكتروني هنا ...",
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
                      if (_selectedAcademicAchievementItem.name == "ابتدائية" ||
                          _selectedAcademicAchievementItem.name == "متوسطة" ||
                          _selectedAcademicAchievementItem.name == "اعدادية") {
                        isUniversityStudent = false;
                      } else {
                        isUniversityStudent = true;
                      }

                    });
                  }),
            ),
          ],
        ));
  }

  universityWidget() {
    return TextFormField(
      controller: universityController,
      enabled: isUniversityStudent,
      validator: (value) {
        if (value.isEmpty && isUniversityStudent == true) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الجامعة",
          hintText: "ادخل جامعتك هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  collegeWidget() {
    return TextFormField(
      controller: collegeController,
      enabled: isUniversityStudent,
      validator: (value) {
        if (value.isEmpty && isUniversityStudent == true) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "الكلية",
          hintText: "ادخل كليتك هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  specializationWidget() {
    return TextFormField(
      controller: specializationController,
      enabled: isUniversityStudent,
      validator: (value) {
        if (value.isEmpty && isUniversityStudent == true) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "التخصص",
          hintText: "ادخل تخصصك هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  graduationYearWidget() {
    return TextFormField(
      controller: graduationYearController,
      enabled: isUniversityStudent,
      validator: (value) {
        if (value.isEmpty && isUniversityStudent == true) {
          return 'مطلوب';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "سنة التخرج",
          hintText: "ادخل سنة التخرج هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  previousWorkPlacesWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أماكن العمل السابقة :',
              style: new TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              )),
          Column(
            children: previousWorkList,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlineButton(
                shape: CircleBorder(side: BorderSide()),
                child: Text('+',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blueAccent,
                        fontFamily: "Amiri",
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    countPreviousWork < 5
                        ? countPreviousWork++
                        : countPreviousWork = countPreviousWork;
                    countPreviousWork > 1
                        ? minusButtonVisible = true
                        : minusButtonVisible = false;
                  });
                },
              ),
              SizedBox(width: 10),
              Visibility(
                visible: minusButtonVisible,
                child: OutlineButton(
                  shape: CircleBorder(side: BorderSide()),
                  child: new Text('-',
                      style: new TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueAccent,
                          fontFamily: "Amiri",
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    setState(() {
                      countPreviousWork > 1
                          ? countPreviousWork--
                          : countPreviousWork = countPreviousWork;
                      countPreviousWork == 1
                          ? minusButtonVisible = false
                          : minusButtonVisible = true;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  searchWorkWidget() {
    return Container(
      height: 130,
      padding: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            children: [
              Text(
                "أبحث عن عمل :",
                style: TextStyle(fontSize: fontSize),
              ),
              Radio(
                value: "ضمن اختصاصي",
                groupValue: _radioSpecializationValue,
                onChanged: _handleRadioSpecializationValueChange,
              ),
              Text(
                'ضمن اختصاصي',
                style: new TextStyle(fontSize: fontSize),
              ),
              Radio(
                value: "اخرى",
                groupValue: _radioSpecializationValue,
                onChanged: _handleRadioSpecializationValueChange,
              ),
              Text(
                'اخرى',
                style: new TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: searchWorkController,
            enabled: isEnableOtherSpecialization,
            decoration: InputDecoration(
                labelText: "اخرى",
                hintText: "ادخل اختصاصك هنا",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          )
        ],
      ),
    );
  }

  workTypeWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "نوع العمل :",
              style: TextStyle(fontSize: fontSize),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedWorkTypeItem,
                  items: _dropdownWorkTypeMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedWorkTypeItem = value;
                    });
                  }),
            ),
          ],
        ));
  }

  canWorkToWidget() {
    return TextFormField(
      controller: timeStayWorkController,
      validator: (value) {
        if (value.isEmpty) {
          return 'مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "يمكنني البقاء في العمل لغاية الساعة",
          hintText: "ادخل الوقت هنا",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  microsoftOfficeKnownWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "معرفتي ببرامج مايكروسوفت\n اوفس (ورد , اكسل) :",
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedNumberOfficeItem,
                  items: _dropdownNumberMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedNumberOfficeItem = value;
                    });
                  }),
            ),
          ],
        ));
  }

  designProgramKnownWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "معرفتي ببرامج التصميم :     ",
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedNumberDesignItem,
                  items: _dropdownNumberMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedNumberDesignItem = value;
                    });
                  }),
            ),
          ],
        ));
  }

  englishKnownWidget() {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: [
            Text(
              "معرفتي باللغة الانكليزية :     ",
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<DropDownMenu>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: _selectedNumberEnglishItem,
                  items: _dropdownNumberMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedNumberEnglishItem = value;
                    });
                  }),
            ),
          ],
        ));
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

  profilePictureWidget() {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 8, left: 8, top: 20),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 70,
            backgroundImage: isSelectProfileImage
                ? FileImage(imageFile)
                : AssetImage("assets/images/profile.png"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: InkWell(
              child: Text("تحديد صورة شخصية",
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
    jopSearcherReference.document(id).setData({
      "id": id,
      "name": nameController.text,
      "gender": _radioGenderValue,
      "birthday": "${selectedDate.toLocal()}".split(' ')[0],
      "nationality": _radioNationalityValue=="اخرى"? nationalityController.text : _radioNationalityValue ,
      "marriageStatus": _selectedMarriageStatusItem.name,
      "phoneNumber": phoneNumberController.text,
      "governorate":_selectedGovernorateItem.name,
      "address": addressController.text,
      "email": emailController.text,
      "academicAchievement": _selectedAcademicAchievementItem.name,
      "university": universityController.text,
      "college": collegeController.text,
      "specialization": specializationController.text,
      "graduationYear": graduationYearController.text,
      "previousWork1": previousWorkController1.text,
      "previousWorkLength1": previousWorkLengthController1.text,
      "previousWork2": previousWorkController2.text,
      "previousWorkLength2": previousWorkLengthController2.text,
      "previousWork3": previousWorkController3.text,
      "previousWorkLength3": previousWorkLengthController3.text,
      "previousWork4": previousWorkController4.text,
      "previousWorkLength4": previousWorkLengthController4.text,
      "previousWork5": previousWorkController5.text,
      "previousWorkLength5": previousWorkLengthController5.text,
      "searchWork": _radioSpecializationValue=="اخرى"? searchWorkController.text :_radioSpecializationValue,
      "workType": _selectedWorkTypeItem.name,
      "canWorkTo": timeStayWorkController.text,
      "officeKnown": _selectedNumberOfficeItem.name,
      "designKnown": _selectedNumberDesignItem.name,
      "englishKnown": _selectedNumberEnglishItem.name,
      "moreInfo": moreInfoController.text,
      "imgUrl": imgUrl,
      "rating": "لا يوجد تقيم حاليا"
    }).then((value) => {
          pr.hide().whenComplete(() => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessSendDataWidget("شكرا لتسجيل معلوماتك سنتواصل معك في اقرب وقت ممكن")))
              })
        });
  }

}
