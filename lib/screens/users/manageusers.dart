// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/module/newsmodules.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../core/text.dart';
import '../../module/usermodule.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final _usersCollections = FirebaseDatabase.instance.ref('Users');

  DatabaseReference? dbRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            title: Text(
              "Users",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.btnBlue),
            ),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "   Users",
            style: GoogleFonts.roboto(textStyle: headerboldblue1),
          ),
          StreamBuilder(
              stream: _usersCollections.onValue,
              builder: (context, snapShot) {
                if (snapShot.hasData &&
                    !snapShot.hasError &&
                    snapShot.data?.snapshot.value != null) {
                  Map _newsCollections = snapShot.data?.snapshot.value as Map;
                  List _userItems = [];
                  _newsCollections.forEach(
                      (index, data) => _userItems.add({"key": index, ...data}));
                  return ListView.builder(
                      itemCount: _userItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                            trailing: GestureDetector(
                              child: GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Center(
                                              child: Text(
                                            'Details',
                                            style: GoogleFonts.poppins(),
                                          )),
                                          content: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                // Rounded user image
                                                // ClipRRect(
                                                //   borderRadius:
                                                //       BorderRadius.circular(
                                                //           45.0), // Make it a circle
                                                //   child: Image.asset(
                                                //     user[index].profile_url,
                                                //     width: 90.0,
                                                //     height: 90.0,
                                                //     fit: BoxFit.cover,
                                                //   ),
                                                // ),
                                                SizedBox(height: 12.0),
                                                // User details
                                                Text(
                                                  _userItems[index]['name'],
                                                  style: TextStyle(
                                                    color: AppColors.btnBlue,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                    "User Id: ${_userItems[index]['name']}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    " ${_userItems[index]['name']}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                    "Level: ${_userItems[index]['name']}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                child: Icon(
                                  FontAwesomeIcons.circleInfo,
                                  size: 22,
                                  color: AppColors.btnBlue,
                                  weight: 3,
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/profile.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            title: Text(
                              _userItems[index]['name'],
                              style: GoogleFonts.poppins(
                                  textStyle: headerboldblue2),
                            ),
                            subtitle: Text(
                              maxLines: 2,
                              " ${_userItems[index]['email']} \n ${_userItems[index]['studentId']}",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  textStyle: TextStyle()),
                            ),
                          ));
                }
                return Container();
              }),
        ]),
      ),
    );
  }
}
