import 'package:flutter/material.dart';

class DashboardCard {
  final String title;
  final IconData cardIcon;
  final int counter;
  final Color cardColor;
 

  DashboardCard(
  
      {required this.title,
      required this.cardIcon,
      this.counter = 0,
      required this.cardColor});


      
}
