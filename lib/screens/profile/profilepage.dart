// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, dead_code

import 'package:crimeappbackend/core/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../widget/appbtn.dart';
import '../dashboard/dashboard.dart';
import '../forgotpassword.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String _userName = "Kevin Mitnic";
    bool _enableField = false;
    final _formKey = GlobalKey<FormState>();
    bool _obsecureText = false;

    void _TextVisibility() {
      setState(() {
        _obsecureText = !_obsecureText;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage Profile",
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
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(60),
                  elevation: 10,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/profile.jpg"),
                            fit: BoxFit.cover),
                        color: AppColors.btnBlue,
                        borderRadius: BorderRadius.circular(60)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Positioned(
                child: Center(
                  child: Text(
                    _userName,
                    style: GoogleFonts.poppins(
                      textStyle: usertext,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        TextFormField(
                          enabled: false,
                          cursorColor: AppColors.btnBlue,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors
                                        .btnBlue), // Change the color here
                              ),
                              hintText:_userName,
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.black12, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Password",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        TextFormField(
                          enabled: _enableField,
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: _TextVisibility,
                                  child: Icon(_obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors
                                        .btnBlue), // Change the color here
                              ),
                              hintText: "  Enter Password",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.black12, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          enabled: _enableField,
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: _TextVisibility,
                                  child: Icon(_obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors
                                        .btnBlue), // Change the color here
                              ),
                              hintText: "  Enter Password",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.black12, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        if (_enableField)
                          CustomBtn(
                            btnClick: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            },
                            btnText: "Update",
                          )
                        else
                          Container()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 80,
            left: 210,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: AppColors.btnBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Icon(
                  weight: 17,
                  color: Colors.white,
                  FontAwesomeIcons.penToSquare,
                  size: 17,
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Enable Fields for Update",
          splashColor: AppColors.dashboardYellow,
          backgroundColor: AppColors.btnBlue,
          child: Icon(
            FontAwesomeIcons.penToSquare,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _enableField = !_enableField;
            });
          }),
    );
  }
}
