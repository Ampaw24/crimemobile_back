// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, unused_field
import 'dart:convert';
import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/screens/dashboard/dashboard.dart';
import 'package:crimeappbackend/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/firebase/firebaseAuth.dart';

import '../widget/appbtn.dart';
import 'forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = false;
  bool _isloading = false;
  final _auth = FirebaseAuth.instance;
  final _staffIdController = TextEditingController();
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
                            controller: _staffIdController,
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
                            controller: _passwordController,
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
                            margin: const EdgeInsets.only(left: 200, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: Text(
                                "  Register..",
                                style: GoogleFonts.roboto(
                                    color: AppColors.btnBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomBtn(
                            btnClick: () async {
                              try {
                                setState(() {
                                  _isloading = true; // Start showing the loader
                                });

                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: _staffIdController.text,
                                        password: _passwordController.text);

                                if (user != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard(userName: _staffIdController.text,)));
                                }
                              } catch (e) {
                                print(e);
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
               if (_isLoading)
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
