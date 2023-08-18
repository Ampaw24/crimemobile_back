// ignore_for_file: sort_child_properties_last

import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBtn extends StatelessWidget {
  final String btnText;
  final VoidCallback btnClick;
  const CustomBtn({super.key, required this.btnText, required this.btnClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnClick,
      child: Container(
        width: 350,
        height: 55,
        child: Center(
          child: Text(
            btnText,
            style: GoogleFonts.montserrat(
              textStyle: logintxtwhite,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.btnBlue,
        ),
      ),
    );
  }
}
