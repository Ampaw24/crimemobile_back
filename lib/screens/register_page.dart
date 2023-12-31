// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_required_param

import 'package:crimeappbackend/screens/dashboard/dashboard.dart';
import 'package:crimeappbackend/screens/loginpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Specs/colors.dart';
import '../../../Specs/password_field.dart';
import '../../../Specs/text_field.dart';
import '../config/firebase/firebaseAuth.dart';
import '../core/text.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FireAuth _fireAuth = FireAuth();

  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('Admindetails');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
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
                    "Register Admin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: textFormField(
                        controller: _nameController,
                        hintText: "Full name",
                        borderWidth: 2,
                        borderRadius: 10,
                        validateMsg: "Field required",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                        keyboardType: TextInputType.multiline,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ]),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: textFormField(
                        controller: _studentIdController,
                        hintText: "Staff Username",
                        borderWidth: 2,
                        borderRadius: 10,
                        validateMsg: "Field required",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                        keyboardType: TextInputType.multiline,
                        inputFormatters: <TextInputFormatter>[]),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.all(10),
                    child: PasswordField(
                      controller: _passwordController,
                      hintText: "Password",
                      borderWidth: 2,
                      borderRadius: 10,
                      removeBorder: true,
                      validateMsg: "Field required",
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.all(10),
                    child: PasswordField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      borderWidth: 2,
                      borderRadius: 10,
                      removeBorder: true,
                      validateMsg: "Field required",
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, String> admindetails = {
                        'name': _nameController.text,
                        'mail':
                            "${_studentIdController.text.trim().toLowerCase()}@crsatu.com",
                      };

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        Get.showSnackbar(GetSnackBar(
                          title: "Password Error",
                          message: "Password match error!!",
                        ));
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      String result = await _fireAuth.signUp(
                        email: "${_studentIdController.text.trim()}@crsatu.com",
                        password: _passwordController.text,
                      );
                      ref.push().set(admindetails).then((_) {
                        Get.snackbar("Admin Added!",
                            "Administrator details added Successfully \n Your user mail is ${_studentIdController.text.trim().toLowerCase()}@crsatu.com}",
                            snackPosition: SnackPosition.TOP,
                             duration: Duration(seconds: 30)  
                          );
                        setState(() {
                          _isLoading = false;
                        });
                        _studentIdController.text = " ";
                        _confirmPasswordController.text = " ";
                        _passwordController.text = " ";
                        _nameController.text = "";

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }).catchError((e) => print(e));
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        color: DARKBLUE,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Register",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            fontSize: 24,
                            color: WHITE,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("Login"))
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
