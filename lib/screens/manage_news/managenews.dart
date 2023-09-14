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
import 'package:fluttertoast/fluttertoast.dart';

class ManageNews extends StatefulWidget {
  const ManageNews({super.key});

  @override
  State<ManageNews> createState() => _ManageNewsState();
}

class _ManageNewsState extends State<ManageNews> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescriptionController = TextEditingController();
  TextEditingController file = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedFileName = "Attach File";
  String? filename;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  //News data fetch
  Map? _newsVals;
  String? newsTitle;
  String? newsDescription;

  final _newsCollection = FirebaseDatabase.instance.ref('News');

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

  deleteMessage(key) {
    _newsCollection.child(key).remove();
  }

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('News');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Text(
                "Manage News",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
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
      body: SafeArea(
        child: Scrollbar(
          child: Expanded(
              child: StreamBuilder(
                  stream: _newsCollection.onValue,
                  builder: (context, snapShot) {
                    if (snapShot.hasData &&
                        !snapShot.hasError &&
                        snapShot.data?.snapshot.value != null) {
                      Map _newsCollections =
                          snapShot.data?.snapshot.value as Map;
                      List _newsItems = [];
                      _newsCollections.forEach((index, data) =>
                          _newsItems.add({"key": index, ...data}));

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _newsItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: GestureDetector(
                              onTap: () async {
                                await deleteMessage(_newsItems[index]['key']);

                                Fluttertoast.showToast(
                                    msg: "News Deleted!!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 15.0);
                              },
                              child: Icon(
                                FontAwesomeIcons.trashCan,
                                size: 18,
                                color: AppColors.btnBlue,
                                weight: 3,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            title: Text(_newsItems[index]['title'],
                                style: GoogleFonts.poppins(
                                    textStyle: headerboldblue2)),
                            subtitle: Text(_newsItems[index]['description'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                    textStyle: TextStyle())),
                          );
                        },
                      );
                    }
                    return Container();
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.btnBlue,
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                        child: Wrap(children: [
                          SafeArea(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.60,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Add News",
                                      style: GoogleFonts.lato(
                                        textStyle: headerboldblue1,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                child:
                                                    Text(filename.toString()),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: _pickFile,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                margin: const EdgeInsets.only(
                                                    top: 20),
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
                                                      Center(
                                                        child: Text(
                                                          "Choose Image",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      subheaderBoldbtnwhite),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                height: 50,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    color: AppColors.mainBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                Map<String, String> news = {
                                                  'title':
                                                      newsTitleController.text,
                                                  'description':
                                                      newsDescriptionController
                                                          .text,
                                                };
                                                // final selctedFile = storageRef
                                                //     .child(pickedFile.toString());

                                                dbRef
                                                    ?.push()
                                                    .set(news)
                                                    .then((_) {
                                                  Flushbar(
                                                    title: "News Posted",
                                                    message:
                                                        "News ${newsTitleController.text} posted",
                                                    duration:
                                                        Duration(seconds: 4),
                                                    icon: Icon(
                                                        Icons
                                                            .done_outline_rounded,
                                                        color: Colors.white),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                                255, 43, 51, 54)
                                                            .withOpacity(0.6),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    animationDuration: Duration(
                                                        milliseconds: 500),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    margin: EdgeInsets.all(8.0),
                                                    onTap: (flushbar) {
                                                      flushbar.dismiss();
                                                    },
                                                  ).show(context);

                                                  newsTitleController.text = "";
                                                  newsDescriptionController
                                                      .text = "";
                                                }).catchError((_) {
                                                  Flushbar(
                                                    title: "News Post Error",
                                                    message:
                                                        "News ${newsTitleController.text} Error",
                                                    duration:
                                                        Duration(seconds: 4),
                                                    icon: Icon(
                                                        Icons
                                                            .done_outline_rounded,
                                                        color: Colors.white),
                                                    backgroundColor:
                                                        Color.fromARGB(255, 237,
                                                                51, 51)
                                                            .withOpacity(0.6),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    animationDuration: Duration(
                                                        milliseconds: 300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    margin: EdgeInsets.all(8.0),
                                                    onTap: (flushbar) {
                                                      flushbar.dismiss();
                                                    },
                                                  ).show(context);
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                margin: const EdgeInsets.only(
                                                    top: 20),
                                                child: Center(
                                                  child: Text(
                                                    "Create News",
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
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
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
