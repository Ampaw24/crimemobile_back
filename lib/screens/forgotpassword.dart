// ignore_for_file: prefer_const_constructors

import 'package:crimeappbackend/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/text.dart';
import '../widget/appbtn.dart';

class FogotPassword extends StatefulWidget {
  const FogotPassword({super.key});

  @override
  State<FogotPassword> createState() => _FogotPasswordState();
}

class _FogotPasswordState extends State<FogotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = false;

  void _TextVisibility() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Crime Reporter",
                    style: GoogleFonts.justAnotherHand(
                      textStyle: fansyTitle,
                    ),
                  ),
                ],
              ),
              Text(
                "Reset Password",
                style: GoogleFonts.roboto(
                  textStyle: usertext,
                ),
              ),
              SizedBox(
                height: 10,
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
                          "Enter new Password",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        TextFormField(
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
                          height: 10,
                        ),
                        Text(
                          "Confirm Password",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        TextFormField(
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
                        Container(
                          margin: const EdgeInsets.only(left: 170, top: 10),
                          child: GestureDetector(
                            child: Text(
                              "Forgot Password..",
                              style: GoogleFonts.roboto(
                                  color: AppColors.btnBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomBtn(
                          btnClick: () {
                          
                          },
                          btnText: "Reset",
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
