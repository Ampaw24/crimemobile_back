import 'package:flutter/material.dart';

class DashboardCard {
  final String title;
  final IconData cardIcon;
  final int counter;
  final Color cardColor;
  final Widget navigate;

  DashboardCard(
      {
        required this.navigate,
        required this.title,
      required this.cardIcon,
      this.counter = 0,
      required this.cardColor});
}
