// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/module/reportsmodule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    List<ReportModule> reports = [
      ReportModule(
          crime_discription: "Lorem Ipsum",
          location: "Hatso Clinicals",
          medicalAssistance: false,
          occurenceTime: DateTime.now(),
          user_name: "Mariana Crunch"),
      ReportModule(
          crime_discription: "Lorem Ipsum",
          location: "Hatso Clinicals",
          medicalAssistance: true,
          occurenceTime: DateTime.now(),
          user_name: "Mariana Crunch"),
      ReportModule(
          crime_discription: "Lorem Ipsum",
          location: "Hatso Clinicals",
          medicalAssistance: false,
          occurenceTime: DateTime.now(),
          user_name: "Mariana Crunch"),
      ReportModule(
          crime_discription: "Lorem Ipsum",
          location: "Hatso Clinicals",
          medicalAssistance: true,
          occurenceTime: DateTime.now(),
          user_name: "Mariana Crunch"),
    ];
    int results = reports.length;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Reports",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
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
                style: GoogleFonts.roboto(textStyle: headerboldblue1),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) => ListTile(
                        trailing: GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.dotCircle,
                            color: AppColors.btnBlue,
                          ),
                        ),
                        onTap: () {},
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
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                        title: Text(
                          reports[index].user_name,
                          style:
                              GoogleFonts.poppins(textStyle: headerboldblue2),
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
                            Text(reports[index].location)
                          ],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
