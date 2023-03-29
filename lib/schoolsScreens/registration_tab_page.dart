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

class SchoolsRegistrationTabPage extends StatefulWidget {
  const SchoolsRegistrationTabPage({super.key});

  @override
  State<SchoolsRegistrationTabPage> createState() =>
      _SchoolsRegistrationTabPageState();
}

class _SchoolsRegistrationTabPageState
    extends State<SchoolsRegistrationTabPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController cityCodeTextEditingController = TextEditingController();
  TextEditingController schoolAddressTextEditingController =
      TextEditingController();
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
      if (passwordTextEditingController.text ==
          confirmPasswordTextEditingController.text) {
        if (nameTextEditingController.text.isNotEmpty &&
            emailTextEditingController.text.isNotEmpty &&
            passwordTextEditingController.text.isNotEmpty &&
            confirmPasswordTextEditingController.text.isNotEmpty &&
            cityCodeTextEditingController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialogWidget(
                  meassage: "Registering your Account",
                );
              });
          //UPLOAD IMAGE TO STORAGE
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
              .ref()
              .child("usersImage")
              .child(fileName);
          fstorage.UploadTask uploadImageTask =
              storageRef.putFile(File(imgXFile!.path));
          fstorage.TaskSnapshot taskSnapshot =
              await uploadImageTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((urlImage) {
            dowmloadUrlImage = urlImage;
          });
          //save user info to firestore database
          saveInformationToDatabase();
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Please complete the form.Do not leave anything empty");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Password and Confirm Password do not match");
      }
    }
  }

  saveInformationToDatabase() async {
//authenticate the user
    User? currentUser;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured: \n $errorMessage");
    });
    if (currentUser != null) {
      //save info to database and save locally
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async {
    //save to firestore
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .collection("UsersSchools")
        .doc(currentUser.uid)
        .set({
      "schoolUID": currentUser.uid,
      "schoolEmail": currentUser.email,
      "schoolName": nameTextEditingController.text.trim(),
      "photoUrl": dowmloadUrlImage,
      "centreUID": sharedPreferences!.getString("uid"),
      "ciyCode": cityCodeTextEditingController.text.trim(),
      "schoolAddress": schoolAddressTextEditingController.text.trim(),
      "status": "approved",
      "userCart": ["initialValue"],
    }).then((value) {
      FirebaseFirestore.instance
          .collection("UsersSchools")
          .doc(currentUser.uid)
          .set({
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameTextEditingController.text.trim(),
        "photoUrl": dowmloadUrlImage,
        "centreUID": sharedPreferences!.getString("uid"),
        "ciyCode": cityCodeTextEditingController.text.trim(),
        "schoolAddress": schoolAddressTextEditingController.text.trim(),
        "status": "approved",
        "userCart": ["initialValue"],
      });
    });

    //save Locally
    // sharedPreferences = await SharedPreferences.getInstance();
    // await sharedPreferences!.setString("uid", currentUser.uid);
    // await sharedPreferences!.setString("email", currentUser.email!);
    // await sharedPreferences!
    //     .setString("name", nameTextEditingController.text.trim());
    // await sharedPreferences!.setString("photoUrl", dowmloadUrlImage);
    // await sharedPreferences!.setStringList("userCart", ["initialValue"]);
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
          "New School Registration",
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
                    //name
                    CustomTextField(
                      textEditingController: nameTextEditingController,
                      iconData: Icons.person,
                      hintText: "Name",
                      isObscure: false,
                      enabled: true,
                    ),
                    //email
                    CustomTextField(
                      textEditingController: emailTextEditingController,
                      iconData: Icons.email,
                      hintText: "Email",
                      isObscure: false,
                      enabled: true,
                    ),
                    CustomTextField(
                      textEditingController: cityCodeTextEditingController,
                      iconData: Icons.email,
                      hintText: "City Code",
                      isObscure: false,
                      enabled: true,
                    ),
                    //School Address
                    CustomTextField(
                      textEditingController: schoolAddressTextEditingController,
                      iconData: Icons.location_city,
                      hintText: "School Address",
                      isObscure: false,
                      enabled: true,
                    ),
                    //password
                    CustomTextField(
                      textEditingController: passwordTextEditingController,
                      iconData: Icons.lock,
                      hintText: "Password",
                      isObscure: false,
                      enabled: true,
                    ),
                    //confirm password
                    CustomTextField(
                      textEditingController:
                          confirmPasswordTextEditingController,
                      iconData: Icons.lock,
                      hintText: "Confirm Password",
                      isObscure: true,
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
