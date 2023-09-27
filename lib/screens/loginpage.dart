// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, unused_field
import 'dart:convert';
import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/screens/dashboard/dashboard.dart';
import 'package:crimeappbackend/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/firebase/firebaseAuth.dart';
import 'package:get/get.dart';
import '../widget/appbtn.dart';
import 'forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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

  bool isErr = false;

  void _signInwithMail() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      _isloading = true;
    });

    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _staffIdController.text, password: _passwordController.text);
      if (user == null ||
          _staffIdController.text == " " ||
          _passwordController.text == "") {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar("No User Found",
            "No entries made for login Add right credentials!!",
            isDismissible: true, snackPosition: SnackPosition.BOTTOM);
      }
      if (user != null) {
        Future.delayed(
            Duration(
              seconds: 10,
            ),
            () => Get.to(() => Dashboard(
                  userName: _staffIdController.text,
                )));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == "account-exists-with-different-credential" ||
          e.code == "The-password-is-invalid") {
        setState(() {
          _isloading = false;
          _staffIdController.text = "";
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
    }
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
                          _isloading
                              ? SpinKitDoubleBounce(
                                  size: 30,
                                  color: Color(0xffDEA81D),
                                )
                              : Container(),
                          Text(
                            "Admin Mail",
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
                                hintText:
                                    " Enter Admin Id, e.g username@crsatu.com",
                                hintStyle: GoogleFonts.roboto(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black12,
                                    fontSize: 12),
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
                            btnClick: _signInwithMail,
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
