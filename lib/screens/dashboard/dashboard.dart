// ignore_for_file: sort_child_properties_last, prefer_const_constructors, deprecated_member_use
import 'dart:async';
import 'package:crimeappbackend/core/colors.dart';
import 'package:crimeappbackend/core/text.dart';
import 'package:crimeappbackend/screens/loginpage.dart';
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
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  final String userName;
  const Dashboard({super.key, required this.userName});

  @override
  State<Dashboard> createState() => _DashboardState();
}

List<DashboardCard> cardcontent = [
  DashboardCard(
      navigate: ReportPage(),
      title: "Reports",
      cardIcon: FontAwesomeIcons.fileText,
      cardColor: AppColors.dashboardGreen,
      islong: false),
  DashboardCard(
      navigate: ManageNews(),
      title: "Manage\nNews",
      cardIcon: FontAwesomeIcons.solidNewspaper,
      cardColor: AppColors.dashboardYellow,
      islong: false),
  DashboardCard(
      navigate: ManageTips(),
      title: "Manage\nTips",
      cardIcon: FontAwesomeIcons.lightbulb,
      cardColor: AppColors.dashboardRed,
      islong: false),
  DashboardCard(
      navigate: ManageUsers(),
      title: "Users",
      cardIcon: FontAwesomeIcons.users,
      cardColor: AppColors.dashboardBrown,
      islong: false),
  DashboardCard(
      navigate: ProfilePage(),
      title: "Profile",
      cardIcon: FontAwesomeIcons.user,
      cardColor: Colors.blue,
      islong: true)
];

class _DashboardState extends State<Dashboard> {
  String? _userName;
  bool isLoading = false;
  @override
  void initState() {
    loadAmindetails(widget.userName);
    // fetchNameByEmail(widget.userName);
    super.initState();
  }

  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure You want to Logout this section?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await FirebaseAuth.instance.signOut();

                setState(() {
                  isLoading = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            leading: Container(),
            actions: [
              Container(
                margin: const EdgeInsets.only(
                  right: 80,
                ),
                child: Text(
                  " Hello, ${_userName.toString()}",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.btnBlue),
                ),
              ),
              GestureDetector(
                onTap: () => _showMyDialog(),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(right: 15),
                      width: 110,
                      height: 35,
                      decoration: BoxDecoration(
                          color: AppColors.btnBlue.withOpacity(.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        margin: const EdgeInsets.only(right: 60),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/profile.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 45,
                      right: 10,
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.lato(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )
            ],
            // leading: Icon(Icons.menu_outlined),
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
                  title: cardcontent[index].title,
                  isTile: cardcontent[index].islong,
                ));
              },
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
