// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:crimeappbackend/module/newsmodules.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';
import '../../core/text.dart';

class ManageNews extends StatefulWidget {
  const ManageNews({super.key});

  @override
  State<ManageNews> createState() => _ManageNewsState();
}

class _ManageNewsState extends State<ManageNews> {
  List<NewsModule> news = [
    NewsModule(
        title: "Hakks",
        discription: "hdfhagfygdfhsgdfchsufhscjiashcuwehfuischsufhy \n hydydy",
        image_url: "assets/loading.gif",
        author: "Figaro",
        date: DateTime.now()),
    NewsModule(
        title: "Hakks",
        discription: "hdfhagfygdfhsgdfchsufhscjiashcuwehfuischsufhy \n hydydy",
        image_url: "assets/loading.gif",
        author: "Figaro",
        date: DateTime.now()),
    NewsModule(
        title: "Hakks",
        discription: "hdfhagfygdfhsgdfchsufhscjiashcuwehfuischsufhy \n hydydy",
        image_url: "assets/loading.gif",
        author: "Figaro",
        date: DateTime.now()),
    NewsModule(
        title: "Hakks",
        discription: "hdfhagfygdfhsgdfchsufhscjiashcuwehfuischsufhy \n hydydy",
        image_url: "assets/loading.gif",
        author: "Figaro",
        date: DateTime.now()),
    NewsModule(
        title: "Hakks",
        discription: "hdfhagfygdfhsgdfchsufhscjiashcuwehfuischsufhy \n hydydy",
        image_url: "assets/loading.gif",
        author: "Figaro",
        date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage News",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.btnBlue),
              ),
              const SizedBox(
                width: 50,
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
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
          ),
          preferredSize: const Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Expanded(
          child: ListView.builder(
              itemCount: news.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                    trailing: GestureDetector(
                      child: Icon(
                        FontAwesomeIcons.trashCan,
                        size: 18,
                        color: AppColors.btnBlue,
                        weight: 3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    leading: Image.asset(news[index].image_url),
                    title: Text(
                      news[index].title,
                      style: GoogleFonts.poppins(textStyle: headerboldblue2),
                    ),
                    subtitle: Text(
                      maxLines: 2,
                      news[index].discription,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          textStyle: TextStyle()),
                    ),
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.btnBlue,
          onPressed: () {},
          child: Icon(
            FontAwesomeIcons.add,
            color: Colors.white,
            weight: 3,
          )),
    );
  }
}
