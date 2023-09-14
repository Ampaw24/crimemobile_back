// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../core/text.dart';

class ViewReport extends StatelessWidget {
  final username, crimelocation, discription;
  final String medicalassistance;

  const ViewReport(
      {super.key,
      required this.username,
      required this.crimelocation,
      required this.medicalassistance,
      required this.discription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "View Report",
                style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: AppColors.btnBlue),
              ),
              const SizedBox(
                width: 120,
              ),
            ],
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              subtitle: Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(
                    width: 5,
                  ),
                  Text(crimelocation)
                ],
              ),
              leading: Material(
                borderRadius: BorderRadius.circular(25),
                elevation: 3,
                child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(
                    FontAwesomeIcons.circleExclamation,
                    color: AppColors.dashboardRed,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              title: Text(username,
                  style: GoogleFonts.poppins(textStyle: headerboldblue2)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    discription,
                    style: TextStyle(
                      height: 2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
