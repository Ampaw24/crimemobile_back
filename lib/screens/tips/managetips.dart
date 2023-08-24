// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/module/newsmodules.dart';
import 'package:crimeappbackend/module/tipsmodule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../core/text.dart';

class ManageTips extends StatefulWidget {
  const ManageTips({super.key});

  @override
  State<ManageTips> createState() => _ManageTipsState();
}

class _ManageTipsState extends State<ManageTips> {
  List<TipsModule> tips = [
    TipsModule(
        title: "Ensure Growth",
        discription: "Proper lorem textures on jbasvchysugf"),
    TipsModule(
        title: "Ensure Growth",
        discription: "Proper lorem textures on jbasvchysugf"),
    TipsModule(
        title: "Ensure Growth",
        discription: "Proper lorem textures on jbasvchysugf"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Tips",
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
      body: SingleChildScrollView(
        child: Expanded(
          child: ListView.builder(
              itemCount: tips.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                    trailing: GestureDetector(
                      child: Icon(
                        FontAwesomeIcons.trashCan,
                        size: 18,
                        color: AppColors.btnBlue,
                        weight: 3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    leading: Container(
                      height: 100,
                      width: 70,
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w800,
                              fontSize: 27,
                              color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.dashboardYellow,
                      ),
                    ),
                    title: Text(
                      tips[index].title,
                      style: GoogleFonts.poppins(textStyle: headerboldblue2),
                    ),
                    subtitle: Text(
                      maxLines: 2,
                      tips[index].discription,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          textStyle: TextStyle()),
                    ),
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.btnBlue,
          onPressed: () {},
          child: Icon(
            FontAwesomeIcons.add,
            color: Colors.white,
            weight: 3,
          )),
    );
  }
}
