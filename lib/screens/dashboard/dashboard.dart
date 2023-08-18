// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module/dashboardcardmodule.dart';
import '../../widget/dashboardcards.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

List<DashboardCard> cardcontent = [
  DashboardCard(
      title: "Reports",
      cardIcon: FontAwesomeIcons.fileText,
      cardColor: AppColors.dashboardGreen),
  DashboardCard(
      title: "Manage\nNews",
      cardIcon: FontAwesomeIcons.solidNewspaper,
      cardColor: AppColors.dashboardYellow),
  DashboardCard(
      title: "Manage\nTips",
      cardIcon: FontAwesomeIcons.lightbulb,
      cardColor: AppColors.dashboardRed),
  DashboardCard(
      title: "Users",
      cardIcon: FontAwesomeIcons.users,
      cardColor: AppColors.dashboardBrown),
  DashboardCard(
      title: "Feeds",
      cardIcon: FontAwesomeIcons.videoCamera,
      cardColor: AppColors.btnBlue),
  DashboardCard(
      title: "Profile",
      cardIcon: FontAwesomeIcons.user,
      cardColor: AppColors.btnBlue)
];

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Hello,",
                style: GoogleFonts.montserrat(fontSize: 23),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Kevin",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.btnBlue),
              ),
              SizedBox(
                width: 110,
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
            leading: Icon(Icons.menu_outlined),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              "Dashboard",
              style: GoogleFonts.montserrat(
                textStyle: headerbold1,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 10.0, // Spacing between columns
              ),
              itemCount:
                  cardcontent.length, // Total number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                    child: DashboarddCards(
                  cardColor: cardcontent[index].cardColor,
                  cardIcon: cardcontent[index].cardIcon,
                  counter: cardcontent[index].counter,
                  title: cardcontent[index].title,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
