// ignore_for_file: sort_child_properties_last, prefer_const_constructors, list_remove_unrelated_type

import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/module/reportsmodule.dart';
import 'package:crimeappbackend/screens/report/viewreport.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportCollection = FirebaseDatabase.instance.ref('Crime Report');

  DatabaseReference? dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Crime Report');
  }

  @override
  Widget build(BuildContext context) {
    List<ReportModule> reports = [];
    int results = reports.length;

    deleteMessage(key) {
      _reportCollection.child(key).remove();
    }

    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Reports",
                style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: AppColors.btnBlue),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/profile.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              left: 15,
              child: Text(
                "Available Reports",
                style: GoogleFonts.roboto(textStyle: headerboldblue2),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35),

              child: StreamBuilder(
                  stream: _reportCollection.onValue,
                  builder: (context, snapShot) {
                    if (snapShot.hasData &&
                        !snapShot.hasError &&
                        snapShot.data?.snapshot.value != null) {
                      Map _newsCollections =
                          snapShot.data?.snapshot.value as Map;
                      print(_newsCollections);

                      List _reportItems = [];

                      _newsCollections.forEach((index, data) =>
                          _reportItems.add({"key": index, ...data}));

                      return ListView.builder(
                          itemCount: _reportItems.length,
                          itemBuilder: (context, index) => ListTile(
                                trailing: GestureDetector(
                                  onTap: () async {
                                    await deleteMessage(
                                        _reportItems[index]['key']);
                                    Fluttertoast.showToast(
                                        msg: "Report Deleted!!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black45,
                                        textColor: Colors.white,
                                        fontSize: 15.0);
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.trashCan,
                                    size: 18,
                                    color: AppColors.btnBlue,
                                    weight: 3,
                                  ),
                                ),
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                    color: Colors.red,
                                    height: 400,

                                  ));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ViewReport(
                                  //               discription: _reportItems[index]
                                  //                   ['description'],
                                  //               crimelocation:
                                  //                   _reportItems[index]
                                  //                       ['location'],
                                  //               medicalassistance:
                                  //                   _reportItems[index]
                                  //                       ['medical'],
                                  //               username: _reportItems[index]
                                  //                   ['username'],
                                  //             ))

                                  //             );
                                },
                                leading: Material(
                                  borderRadius: BorderRadius.circular(25),
                                  elevation: 5,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      FontAwesomeIcons.circleExclamation,
                                      color: AppColors.cardRed,
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                ),
                                title: Text(
                                  _reportItems[index]['username'],
                                  style: GoogleFonts.poppins(
                                      textStyle: headerboldblue2),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: AppColors.btnBlue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _reportItems[index]['location'],
                                    )
                                  ],
                                ),
                              ));
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
