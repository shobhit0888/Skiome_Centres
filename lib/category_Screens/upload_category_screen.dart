// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skiome_centres/category_Screens/home_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/mainScreens/home_screen_for_centre.dart';
import 'package:skiome_centres/widgets/progress_bar.dart';

import '../models/categories.dart';

class UploadCategoryScreens extends StatefulWidget {
  Categories? model;
  UploadCategoryScreens({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<UploadCategoryScreens> createState() => _UploadCategoryScreensState();
}

class _UploadCategoryScreensState extends State<UploadCategoryScreens> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController categoryInfoTextEditingController =
      TextEditingController();
  TextEditingController categoryNameTextEditingController =
      TextEditingController();
  bool uploading = false;
  String downloadUrlImage = "";
  String categoryUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  saveObjectCategoryInfo() {
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .collection("ObjectCategories")
        .doc(categoryUniqueId)
        .set({
      "categoryId": categoryUniqueId,
      // "centreUID": sharedPreferences!.getString("uid"),
      "categoryInfo": categoryInfoTextEditingController.text.trim(),
      "categoryName": categoryNameTextEditingController.text.trim(),
      "publishDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrlImage,
    });
    setState(() {
      uploading = false;
      categoryUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    });
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => HomeScreenForCentre())));
  }

  validateUploadForm() async {
    if (imgXFile != null) {
      if (categoryInfoTextEditingController.text.isNotEmpty &&
          categoryNameTextEditingController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        //upload image - get download url
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
            .ref()
            .child("objectsCategoryImage")
            .child(fileName);
        fstorage.UploadTask uploadImageTask =
            storageRef.putFile(File(imgXFile!.path));
        fstorage.TaskSnapshot taskSnapshot =
            await uploadImageTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((urlImage) {
          downloadUrlImage = urlImage;
        });
//save centre info to firestore database
        saveObjectCategoryInfo();
      } else {
        Fluttertoast.showToast(msg: "Please write brand info and brand name");
      }
    } else {
      Fluttertoast.showToast(msg: "Please choose image");
    }
  }

  uploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => HomeScreenForCentre())));
            }),
            icon: Icon(Icons.arrow_back_rounded)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: (() {
//validate the upload form
                  uploading == true ? null : validateUploadForm();
                }),
                icon: Icon(Icons.cloud_upload)),
          )
        ],
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
        title: const Text("Upload new Categories"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgressBar() : Container(),
          //image
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(imgXFile!.path)))),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),
          //centre info
          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: SizedBox(
              width: 230,
              child: TextField(
                controller: categoryInfoTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Category Info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          ),
          //centre name or code
          ListTile(
            leading: Icon(Icons.title_rounded),
            title: SizedBox(
              width: 230,
              child: TextField(
                controller: categoryNameTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Category Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imgXFile == null ? defaultScreen() : uploadFormScreen();
  }

  defaultScreen() {
    return Scaffold(
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
        title: const Text("Add new Categories"),
      ),
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.white,
                size: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    obtainImageDialogBox();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text("Add new Categories"))
            ],
          ),
        ),
      ),
    );
  }

  obtainImageDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Brand Image",
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureImageWithPhoneCamera();
                },
                child: Text(
                  "Capture with Camera",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  getImageFromGallery();
                },
                child: Text(
                  "Select from the Gallery",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  getImageFromGallery() async {
    Navigator.pop(context);
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  captureImageWithPhoneCamera() async {
    Navigator.pop(context);
    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgXFile;
    });
  }
}
