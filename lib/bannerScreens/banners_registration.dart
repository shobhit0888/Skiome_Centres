import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

import '../category_Screens/home_screen.dart';
import '../global/global.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';

class BannerRegistrationPage extends StatefulWidget {
  const BannerRegistrationPage({super.key});

  @override
  State<BannerRegistrationPage> createState() => _EventsRegistrationPageState();
}

class _EventsRegistrationPageState extends State<BannerRegistrationPage> {
  TextEditingController titleTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String dowmloadUrlImage = "";
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  formvalidation() async {
    if (imgXFile == null) {
      Fluttertoast.showToast(msg: "Please select an image");
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialogWidget(
              meassage: "Creating new Banner",
            );
          });
      //UPLOAD IMAGE TO STORAGE
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
          .ref()
          .child("bannersImages")
          .child(fileName);
      fstorage.UploadTask uploadImageTask =
          storageRef.putFile(File(imgXFile!.path));
      fstorage.TaskSnapshot taskSnapshot =
          await uploadImageTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((urlImage) {
        dowmloadUrlImage = urlImage;
      });
      //save user info to firestore database
      saveInfoToFirestoreAndLocally();
    }
  }

//   saveInformationToDatabase() async {
// //authenticate the user
//     User? currentUser;

//     if (currentUser != null) {
//       //save info to database and save locally
//       saveInfoToFirestoreAndLocally(currentUser);
//     }
//   }

  saveInfoToFirestoreAndLocally() async {
    String eventUniqueUID = DateTime.now().millisecondsSinceEpoch.toString();
    //save to firestore
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .collection("Banners")
        .doc(eventUniqueUID)
        .set({
      "title": titleTextEditingController.text.trim(),
      "photoUrl": dowmloadUrlImage,
    });
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
          "New Banner Registration",
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
                Container(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                //inputs field
                Form(
                    child: Column(
                  children: [
                    //name
                    CustomTextField(
                      textEditingController: titleTextEditingController,
                      iconData: Icons.person,
                      hintText: "Name",
                      isObscure: false,
                      enabled: true,
                    ),

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
                      formvalidation();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => MySplashScreen())));
                    }),
                    child: const Text(
                      "Create",
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
