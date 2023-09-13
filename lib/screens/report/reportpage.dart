// ignore_for_file: sort_child_properties_last, prefer_const_constructors, list_remove_unrelated_type

import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/module/reportsmodule.dart';
import 'package:crimeappbackend/screens/report/viewreport.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Reports",
                style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
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
                "Available Reports ${results.toString()}",
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
                      List _newsItems = [];
                      _newsCollections.forEach((index, data) =>
                          _newsItems.add({"key": index, ...data}));
                      return ListView.builder(
                          itemCount: _newsItems.length,
                          itemBuilder: (context, index) => Slidable(
                                child: ListTile(
                                  trailing: GestureDetector(
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.btnBlue,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewReport(
                                                  discription: _newsItems[index]
                                                      ['description'],
                                                  crimelocation:
                                                      _newsItems[index]
                                                          ['location'],
                                                  medicalassistance:
                                                      reports[index]
                                                          .medicalAssistance,
                                                  username:
                                                      reports[index].user_name,
                                                )));
                                  },
                                  leading: Material(
                                    borderRadius: BorderRadius.circular(25),
                                    elevation: 5,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: reports[index].medicalAssistance
                                          ? Icon(
                                              FontAwesomeIcons.firstAid,
                                              color: AppColors.dashboardRed,
                                            )
                                          : Icon(
                                              FontAwesomeIcons.warning,
                                              color: AppColors.dashboardYellow,
                                            ),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                  ),
                                  title: Text(
                                    reports[index].user_name,
                                    style: GoogleFonts.poppins(
                                        textStyle: headerboldblue2),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.mapLocationDot,
                                        size: 14,
                                        color: AppColors.btnBlue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _newsItems[index]['location'],
                                      )
                                    ],
                                  ),
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // Use the AlertDialog widget to create a confirmation dialog
                                            return AlertDialog(
                                              title: Text('Confirm Delete'),
                                              content: Text(
                                                  'Are you sure you want to delete this item?'),
                                              actions: <Widget>[
                                                // Button to cancel the deletion
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                ),
                                                // Button to confirm and delete
                                                TextButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    // Remove the item from the list

                                                    // Update the UI by rebuilding the widget
                                                    setState(() {
                                                      reports.removeAt(index);
                                                    });

                                                    // Close the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.trashCan,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                              ));
                    }
                    return Container();
                  }),

              // child: ListView.builder(
              //     itemCount: reports.length,
              //     itemBuilder: (context, index) => Slidable(
              //           child: ListTile(
              //             trailing: GestureDetector(
              //               child: Icon(
              //                 Icons.delete,
              //                 color: AppColors.btnBlue,
              //               ),
              //             ),
              //             onTap: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => ViewReport(
              //                             discription:
              //                                 reports[index].crime_discription,
              //                             crimelocation:
              //                                 reports[index].location,
              //                             medicalassistance:
              //                                 reports[index].medicalAssistance,
              //                             username: reports[index].user_name,
              //                           )));
              //             },
              //             leading: Material(
              //               borderRadius: BorderRadius.circular(25),
              //               elevation: 5,
              //               child: Container(
              //                 height: 50,
              //                 width: 50,
              //                 child: reports[index].medicalAssistance
              //                     ? Icon(
              //                         FontAwesomeIcons.firstAid,
              //                         color: AppColors.dashboardRed,
              //                       )
              //                     : Icon(
              //                         FontAwesomeIcons.warning,
              //                         color: AppColors.dashboardYellow,
              //                       ),
              //                 decoration: BoxDecoration(
              //                     color: Color.fromARGB(255, 255, 255, 255),
              //                     borderRadius: BorderRadius.circular(25)),
              //               ),
              //             ),
              //             title: Text(
              //               reports[index].user_name,
              //               style:
              //                   GoogleFonts.poppins(textStyle: headerboldblue2),
              //             ),
              //             subtitle: Row(
              //               children: [
              //                 Icon(
              //                   FontAwesomeIcons.mapLocationDot,
              //                   size: 14,
              //                   color: AppColors.btnBlue,
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text(reports[index].location)
              //               ],
              //             ),
              //           ),
              //           endActionPane: ActionPane(

              //             motion: const ScrollMotion(),

              //             children: [
              //               SlidableAction(
              //                 onPressed: (BuildContext context) {
              //                   showDialog(
              //                     context: context,
              //                     builder: (BuildContext context) {
              //                       // Use the AlertDialog widget to create a confirmation dialog
              //                       return AlertDialog(
              //                         title: Text('Confirm Delete'),
              //                         content: Text(
              //                             'Are you sure you want to delete this item?'),
              //                         actions: <Widget>[
              //                           // Button to cancel the deletion
              //                           TextButton(
              //                             child: Text('Cancel'),
              //                             onPressed: () {
              //                               Navigator.of(context)
              //                                   .pop(); // Close the dialog
              //                             },
              //                           ),
              //                           // Button to confirm and delete
              //                           TextButton(
              //                             child: Text('Delete'),
              //                             onPressed: () {
              //                               // Remove the item from the list

              //                               // Update the UI by rebuilding the widget
              //                               setState(() {
              //                                 reports.removeAt(index);
              //                               });

              //                               // Close the dialog
              //                               Navigator.of(context).pop();
              //                             },
              //                           ),
              //                         ],
              //                       );
              //                     },
              //                   );
              //                 },
              //                 backgroundColor: Color(0xFFFE4A49),
              //                 foregroundColor: Colors.white,
              //                 icon: FontAwesomeIcons.trashCan,
              //                 label: 'Delete',
              //               ),
              //             ],
              //           ),
              //         )),
            )
          ],
        ),
      ),
    );
  }
}
