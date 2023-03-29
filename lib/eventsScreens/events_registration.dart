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

class EventRegistrationPage extends StatefulWidget {
  const EventRegistrationPage({super.key});

  @override
  State<EventRegistrationPage> createState() => _EventsRegistrationPageState();
}

class _EventsRegistrationPageState extends State<EventRegistrationPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController venueTextEditingController = TextEditingController();
  TextEditingController organiserTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController registrationTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController openForTextEditingController = TextEditingController();
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
      if (nameTextEditingController.text.isNotEmpty &&
          timeTextEditingController.text.isNotEmpty &&
          venueTextEditingController.text.isNotEmpty &&
          openForTextEditingController.text.isNotEmpty &&
          organiserTextEditingController.text.isNotEmpty &&
          descriptionTextEditingController.text.isNotEmpty &&
          registrationTextEditingController.text.isNotEmpty &&
          emailTextEditingController.text.isNotEmpty &&
          phoneNumberTextEditingController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialogWidget(
                meassage: "Registering new Event",
              );
            });
        //UPLOAD IMAGE TO STORAGE
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
            .ref()
            .child("eventsImages")
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
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Please complete the form.Do not leave anything empty");
      }
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
        .collection("Events")
        .doc(eventUniqueUID)
        .set({
      "eventUID": eventUniqueUID,
      "eventName": nameTextEditingController.text.trim(),
      "time": timeTextEditingController.text.trim(),
      "venue": venueTextEditingController.text.trim(),
      "openFor": openForTextEditingController.text.trim(),
      "description": descriptionTextEditingController.text.trim(),
      "registration": registrationTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phoneNumber": phoneNumberTextEditingController.text.trim(),
      "photoUrl": dowmloadUrlImage,
      "centreUID": sharedPreferences!.getString("uid"),
      // "ciyCode": cityCodeTextEditingController.text.trim(),
      // "schoolAddress": schoolAddressTextEditingController.text.trim(),
      // "status": "approved",
      // "userCart": ["initialValue"],
    }).then((value) {
      FirebaseFirestore.instance.collection("Events").doc(eventUniqueUID).set({
        "eventUID": eventUniqueUID,
        "eventName": nameTextEditingController.text.trim(),
        "time": timeTextEditingController.text.trim(),
        "venue": venueTextEditingController.text.trim(),
        "openFor": openForTextEditingController.text.trim(),
        "description": descriptionTextEditingController.text.trim(),
        "registration": registrationTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phoneNumber": phoneNumberTextEditingController.text.trim(),
        "photoUrl": dowmloadUrlImage,
        "centreUID": sharedPreferences!.getString("uid"),
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
                      textEditingController: timeTextEditingController,
                      iconData: Icons.time_to_leave_outlined,
                      hintText: "Time",
                      isObscure: false,
                      enabled: true,
                    ),
                    CustomTextField(
                      textEditingController: venueTextEditingController,
                      iconData: Icons.location_city,
                      hintText: "Venue",
                      isObscure: false,
                      enabled: true,
                    ),
                    //School Address
                    CustomTextField(
                      textEditingController: openForTextEditingController,
                      iconData: Icons.open_with_outlined,
                      hintText: "Open For",
                      isObscure: false,
                      enabled: true,
                    ),
                    //Organiser
                    CustomTextField(
                      textEditingController: organiserTextEditingController,
                      iconData: Icons.crop_original_outlined,
                      hintText: "Organiser",
                      isObscure: false,
                      enabled: true,
                    ),
                    //Description
                    CustomTextField(
                      textEditingController: descriptionTextEditingController,
                      iconData: Icons.description,
                      hintText: "Description",
                      isObscure: false,
                      enabled: true,
                    ),
                    //Registration
                    CustomTextField(
                      textEditingController: registrationTextEditingController,
                      iconData: Icons.app_registration_outlined,
                      hintText: "Registration",
                      isObscure: false,
                      enabled: true,
                    ),
                    //contact email
                    CustomTextField(
                      textEditingController: emailTextEditingController,
                      iconData: Icons.email,
                      hintText: "Email",
                      isObscure: false,
                      enabled: true,
                    ),
                    //phoneNumber
                    CustomTextField(
                      textEditingController: phoneNumberTextEditingController,
                      iconData: Icons.phone,
                      hintText: "Phone Number",
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
