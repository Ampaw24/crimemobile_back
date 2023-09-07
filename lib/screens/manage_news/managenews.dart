// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';

import 'package:crimeappbackend/module/newsmodules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../core/text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

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
  ];

  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescriptionController =
      TextEditingController();
  TextEditingController file = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();

  String selectedFileName = "Attach File";
  String? filename;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  Future<void> _pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowCompression: true,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        filename = result.files.first.name;
        pickedFile = result.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        print("Print file: ${filename}");
      } else {}
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  late DatabaseReference dbRef;

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
      body: Scrollbar(
        isAlwaysShown: true,
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
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Add News",
                                style: GoogleFonts.montserrat(
                                  textStyle: headerboldblue1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'News Headline',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: newsTitleController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter title',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'News Detail',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextFormField(
                                      controller:
                                          newsDescriptionController,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        hintText: 'Enter description',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Add widgets for file upload here
                                    // You can use a package like file_picker to handle file uploads
                                    SizedBox(height: 16),
                                    Container(
                                      height: 30,
                                      width: 300,
                                      child: Center(
                                        child: filename.toString() == "null"
                                            ? Text("No file selected")
                                            : Text(filename.toString()),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _pickFile,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.attach_file,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Choose File",
                                                style: GoogleFonts.montserrat(
                                                    textStyle:
                                                        subheaderBoldbtnwhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                        height: 50,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: AppColors.mainBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        Map<String, String> assignment = {
                                          'title':
                                             newsTitleController.text,
                                          'description':
                                              newsDescriptionController
                                                  .text,
                                        };
                                        final selctedFile = storageRef
                                            .child(pickedFile.toString());

                                        dbRef.push().set(news).then((_) {
                                          print("Data Pushed succefulluy");
                                          Flushbar(
                                            title: "Assignment Sent",
                                            message:
                                                "Assignment ${newsTitleController.text} posted",
                                            duration: Duration(seconds: 4),
                                            icon: Icon(
                                                Icons.done_outline_rounded,
                                                color: Colors.white),
                                            backgroundColor: Color.fromARGB(
                                                    255, 22, 149, 195)
                                                .withOpacity(0.6),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            animationDuration:
                                                Duration(milliseconds: 500),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            margin: EdgeInsets.all(8.0),
                                            onTap: (flushbar) {
                                              flushbar.dismiss();
                                            },
                                          ).show(context);

                                          newsTitleController.text = "";
                                          newsDescriptionController.text =
                                              "";
                                        }).catchError((_) {
                                          Flushbar(
                                            title: "Assignment Post Error",
                                            message:
                                                "Assignment ${newsTitleController.text} Error",
                                            duration: Duration(seconds: 4),
                                            icon: Icon(
                                                Icons.done_outline_rounded,
                                                color: Colors.white),
                                            backgroundColor:
                                                Color.fromARGB(255, 237, 51, 51)
                                                    .withOpacity(0.6),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            animationDuration:
                                                Duration(milliseconds: 300),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            margin: EdgeInsets.all(8.0),
                                            onTap: (flushbar) {
                                              flushbar.dismiss();
                                            },
                                          ).show(context);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Text(
                                            "Upload",
                                            style: GoogleFonts.montserrat(
                                                textStyle:
                                                    subheaderBoldbtnwhite),
                                          ),
                                        ),
                                        height: 50,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: AppColors.mainBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
            });
          },
          child: Icon(
            FontAwesomeIcons.add,
            color: Colors.white,
            weight: 3,
          )),
    );
  }
}
