// ignore_for_file: sort_child_properties_last, prefer_const_constructors, deprecated_member_use
import 'dart:async';
import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/screens/manage_news/managenews.dart';
import 'package:crimeappbackend/screens/users/manageusers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/admindetal.dart';
import '../../module/dashboardcardmodule.dart';
import '../../widget/dashboardcards.dart';
import '../feeds/feeds.dart';
import '../profile/profilepage.dart';
import '../report/reportpage.dart';
import '../tips/managetips.dart';

class Dashboard extends StatefulWidget {
  final String userName;
  const Dashboard({super.key, required this.userName});

  @override
  State<Dashboard> createState() => _DashboardState();
}

// void fetchNameByEmail(String email) async {
//   // Reference to your "users" node (assuming your data is structured this way)
//   DatabaseReference usersRef = databaseReference.child("Admindetails");

//   // Query to find the user with the specified email
//   DataSnapshot snapshot = (await usersRef
//       .orderByChild("mail")
//       .equalTo(email)
//       .once()) as DataSnapshot;

//   if (snapshot.value != null) {
//     Map<dynamic, dynamic>? usersData = snapshot.value as Map?;

//     // Iterate through the users and find the one with the matching email
//     String? userName;
//     usersData?.forEach((key, value) {
//       if (value["email"] == email) {
//         userName = value["name"];
//         return;
//       }
//     });

//     if (userName != null) {
//       // User with the specified email found
//       print("User's Name: $userName");
//     } else {
//       // User with the specified email not found
//       print("User not found");
//     }
//   } else {
//     // User with the specified email not found
//     print("User not found");
//   }
// }

List<DashboardCard> cardcontent = [
  DashboardCard(
      navigate: ReportPage(),
      title: "Reports",
      cardIcon: FontAwesomeIcons.fileText,
      cardColor: AppColors.dashboardGreen),
  DashboardCard(
      navigate: ManageNews(),
      title: "Manage\nNews",
      cardIcon: FontAwesomeIcons.solidNewspaper,
      cardColor: AppColors.dashboardYellow),
  DashboardCard(
      navigate: ManageTips(),
      title: "Manage\nTips",
      cardIcon: FontAwesomeIcons.lightbulb,
      cardColor: AppColors.dashboardRed),
  DashboardCard(
      navigate: ManageUsers(),
      title: "Users",
      cardIcon: FontAwesomeIcons.users,
      cardColor: AppColors.dashboardBrown),
  DashboardCard(
      navigate: FeedsPage(),
      title: "Feeds",
      cardIcon: FontAwesomeIcons.videoCamera,
      cardColor: AppColors.btnBlue),
  DashboardCard(
      navigate: ProfilePage(),
      title: "Profile",
      cardIcon: FontAwesomeIcons.user,
      cardColor: Colors.blue)
];

class _DashboardState extends State<Dashboard> {
  String ? _userName;
  @override
  void initState() {
    loadAmindetails(widget.userName);
    // fetchNameByEmail(widget.userName);
    super.initState();
  }

  void loadAmindetails(var email) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child("Admindetails");
    reference.onValue.listen((DatabaseEvent snapshot) {
      print("${snapshot.snapshot.value}");

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData = snapshot.snapshot.value as Map?;
        usersData?.forEach((key, value) {
          if (value["mail"] == email) {
            _userName = value["name"];
            print(_userName);
          }
        });
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                _userName.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.btnBlue),
              ),
              SizedBox(
                width: 110,
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
            leading: Icon(Icons.menu_outlined),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              "Dashboard",
              style: GoogleFonts.montserrat(
                textStyle: headerbold1,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 10.0, // Spacing between columns
              ),
              itemCount:
                  cardcontent.length, // Total number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                    child: DashboarddCards(
                  navigatePage: cardcontent[index].navigate,
                  cardColor: cardcontent[index].cardColor,
                  cardIcon: cardcontent[index].cardIcon,
                  counter: cardcontent[index].counter,
                  title: cardcontent[index].title,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
