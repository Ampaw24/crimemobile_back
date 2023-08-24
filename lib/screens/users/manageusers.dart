// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/module/newsmodules.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../core/text.dart';
import '../../module/usermodule.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List<UserModule> user = [
    UserModule(
        currentLevel: "L 200",
        department: "Computer Science",
        hostelStatus: false,
        profile_url: "assets/profile.jpg",
        userId: "01203769D",
        userName: "Ampaw Juriels"),
    UserModule(
        currentLevel: "L 200",
        department: "Computer Science",
        hostelStatus: false,
        profile_url: "assets/profile.jpg",
        userId: "01203769D",
        userName: "Ampaw Juriels"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Users",
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "   Users ${user.length.toString()}",
              style: GoogleFonts.roboto(textStyle: headerboldblue1),
            ),
            ListView.builder(
                itemCount: user.length,
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
                          vertical: 20, horizontal: 20),
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  user[index].profile_url,
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      title: Text(
                        user[index].userName,
                        style: GoogleFonts.poppins(textStyle: headerboldblue2),
                      ),
                      subtitle: Text(
                        maxLines: 2,
                        " ${user[index].department} \n ${user[index].userId} - ${user[index].currentLevel}",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            textStyle: TextStyle()),
                      ),
                    )),
          ]),
        ),
      ),
    );
  }
}
