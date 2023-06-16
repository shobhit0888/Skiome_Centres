// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skiome_centres/mainScreens/home_screen_for_centre.dart';
import 'package:skiome_centres/models/schools.dart';

import '../functions/functions.dart';
import '../global/global.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/progress_bar.dart';

class UploadAchievementScreens extends StatefulWidget {
  Schools? model;
  UploadAchievementScreens({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<UploadAchievementScreens> createState() =>
      _UploadCategoryScreensState();
}

class _UploadCategoryScreensState extends State<UploadAchievementScreens> {
  XFile? imgXFile;
  // String selctFile = '';
  String? category;
  // Uint8List? selectedImageInBytes;
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController competitionNameTextEditingController =
      TextEditingController();
  TextEditingController awardedByTextEditingController =
      TextEditingController();
  TextEditingController achievementNameTextEditingController =
      TextEditingController();
  TextEditingController authorizedByTextEditingController =
      TextEditingController();
  // TextEditingController objectiveTextEditingController =
  //     TextEditingController();
  bool uploading = false;
  String downloadUrlImage = "";
  String achievementUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  saveClubInfo() {
    FirebaseFirestore.instance
        .collection("UsersSchools")
        .doc(widget.model!.schoolUID)
        .collection("Achievements")
        .doc(achievementUniqueId)
        .set({
      "achievementsUID": achievementUniqueId,
      "achievementName": achievementNameTextEditingController.text.trim(),
      "centreUID": sharedPreferences!.getString("uid"),
      "competitionName": competitionNameTextEditingController.text.trim(),
      "awardedBy": awardedByTextEditingController.text.trim(),
      "authorisedBy": authorizedByTextEditingController.text.trim(),

      // "schoolUID": widget.model!.schoolUID,
      // "clubName": clubNameTextEditingController.text.trim(),
      // "clubInfo": clubInfoTextEditingController.text.trim(),
      // "tagline": taglineTextEditingController.text.trim(),
      // "objective": objectiveTextEditingController.text.trim(),
      "publishDate": DateTime.now(),
      // "status": "available",
      "photoUrl": downloadUrlImage,
      // "category": category,
      // "categoryUID": category,
    });

    setState(() {
      uploading = false;
      achievementUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    });
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => HomeScreenForCentre())));
  }

  //  final ImagePicker imagePicker = ImagePicker();
  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  validateUploadForm() async {
    if (imgXFile != null) {
      if (competitionNameTextEditingController.text.isNotEmpty &&
          awardedByTextEditingController.text.isNotEmpty &&
          authorizedByTextEditingController.text.isNotEmpty &&
          achievementNameTextEditingController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialogWidget(
                meassage: "Registering your Account",
              );
            });
        setState(() {
          uploading = true;
        });
        //upload image - get download url
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
            .ref()
            .child("achievementsImages")
            .child(fileName);
        fstorage.UploadTask uploadImageTask =
            storageRef.putFile(File(imgXFile!.path));
        fstorage.TaskSnapshot taskSnapshot =
            await uploadImageTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((urlImage) {
          downloadUrlImage = urlImage;
        });
        saveClubInfo();
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Please complete the form.Do not leave anything empty");
      }
    } else {
      Fluttertoast.showToast(msg: "Please select an image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text(
          "New Achievement Registration",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                //get-capture image
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: imgXFile == null
                        ? null
                        : FileImage(File(
                            imgXFile!.path,
                          )),
                    radius: MediaQuery.of(context).size.width * 0.20,
                    child: imgXFile == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            color: Colors.grey,
                            size: MediaQuery.of(context).size.width * 0.20,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //inputs field

                Form(
                    child: Column(
                  children: [
                    CustomTextField(
                      textEditingController:
                          achievementNameTextEditingController,
                      iconData: Icons.person,
                      hintText: "Achievement Name",
                      isObscure: false,
                      enabled: true,
                    ),
                    //name
                    CustomTextField(
                      textEditingController:
                          competitionNameTextEditingController,
                      iconData: Icons.person,
                      hintText: "Competition/Event Name",
                      isObscure: false,
                      enabled: true,
                    ),
                    //email
                    CustomTextField(
                      textEditingController: awardedByTextEditingController,
                      iconData: Icons.email,
                      hintText: "Awarded By",
                      isObscure: false,
                      enabled: true,
                    ),
                    CustomTextField(
                      textEditingController: authorizedByTextEditingController,
                      iconData: Icons.email,
                      hintText: "Authorized By",
                      isObscure: false,
                      enabled: true,
                    ),
                    //School Address
                    // CustomTextField(
                    //   textEditingController: clubInfoTextEditingController,
                    //   iconData: Icons.location_city,
                    //   hintText: "School Address",
                    //   isObscure: false,
                    //   enabled: true,
                    // ),
                    //clubCategory
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.all(Radius.circular(10))),
                    //   width: MediaQuery.of(context).size.width * .85,
                    //   height: MediaQuery.of(context).size.width * .15,
                    //   // color: Colors.white,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       children: [
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Icon(Icons.group),
                    //         SizedBox(
                    //           width: 12,
                    //         ),
                    //         DropdownButtonHideUnderline(
                    //           child: DropdownButton<String>(
                    //             focusColor: Colors.purpleAccent,
                    //             value: category,
                    //             //elevation: 5,
                    //             style: TextStyle(color: Colors.grey),
                    //             iconEnabledColor: Colors.black,
                    //             items: <String>[
                    //               'Science and Innovation',
                    //               'Coding',
                    //               'Robotics',
                    //               'Photography',
                    //               'Designing',
                    //               'Finance',
                    //               'Administration and Management',
                    //             ].map<DropdownMenuItem<String>>((String value) {
                    //               return DropdownMenuItem<String>(
                    //                 value: value,
                    //                 child: Text(
                    //                   value,
                    //                   style: TextStyle(
                    //                       color: Colors.grey[600],
                    //                       fontSize: 15.5),
                    //                 ),
                    //               );
                    //             }).toList(),

                    //             // icon: Icon(Icons.group),
                    //             hint: Text(
                    //               "Board",
                    //               style: TextStyle(
                    //                   color: Colors.grey,
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //             onChanged: (String? value) {
                    //               setState(() {
                    //                 category = value;
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12)),
                    onPressed: (() {
                      validateUploadForm();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => MySplashScreen())));
                    }),
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
