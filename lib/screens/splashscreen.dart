// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:crimeappbackend/core/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashLoad();
    super.initState();
  }

  Future<Timer> splashLoad() async {
    return Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 250,
                height: 96,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/newestatulogo.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 7),
                child: Text(
                  "Crime Reporter System",
                  style: GoogleFonts.justAnotherHand(
                    textStyle: fansyTitle,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  "Admin View",
                  style: GoogleFonts.montserrat(
                    textStyle: usertext,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 94,
                height: 96,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/loading.gif'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
