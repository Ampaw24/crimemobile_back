// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'dart:convert';

import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/firebase/firebaseAuth.dart';
import '../config/firebase/firebaseProfile.dart';
import '../config/sharePreference.dart';
import '../widget/appbtn.dart';
import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = false;
  FireAuth _fireAuth = FireAuth();
  FireProfile _fireProfile = FireProfile();

  final _adminmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;


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
                  "Administrator Login",
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
                            "Admin Id",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          TextFormField(
                            controller: _adminmailController,
                            cursorColor: AppColors.btnBlue,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors
                                          .btnBlue), // Change the color here
                                ),
                                hintText: "  Enter Admin Id",
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
                            controller:  _passwordController,
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
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FogotPassword()));
                              },
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
                            btnClick:() async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      String result = await _fireAuth.signIn(
                        email: "${_adminmailController.text.trim()}@crsatu.com",
                        password: _passwordController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });
                      if (result == "success") {
                        Map<dynamic, dynamic>? meta = await _fireProfile
                            .getAccountDetails(_adminmailController.text);
                        await saveBoolShare(key: "auth", data: true);
                        await saveStringShare(
                          key: "userDetails",
                          data: jsonEncode(meta),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      } else {
                        print("$result");
                      }
                    },
                            btnText: "Login",
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
      ),
    );
  }
}
