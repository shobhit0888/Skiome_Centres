// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_centres/achievementsScreens/achievements_screen.dart';
import 'package:skiome_centres/category_Screens/home_screen.dart';
import 'package:skiome_centres/clubs_Screens/clubs_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

class SchoolssDetailsScreen extends StatefulWidget {
  Schools? model;
  SchoolssDetailsScreen({
    this.model,
  });

  @override
  State<SchoolssDetailsScreen> createState() => _SchoolsDetailsScreenState();
}

class _SchoolsDetailsScreenState extends State<SchoolssDetailsScreen> {
  // deleteObject() {
  //   FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("ObjectCategories")
  //       .doc(widget.model!.categoryId)
  //       .collection("Objects")
  //       .doc(widget.model!.objectId)
  //       .delete()
  //       .then((value) {
  //     FirebaseFirestore.instance
  //         .collection("Objects")
  //         .doc(widget.model!.objectId)
  //         .delete();
  //     Fluttertoast.showToast(msg: "Object Deleted Successfully");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.model!.schoolName.toString()),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => AchievementsScreen(model: widget.model)));
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (c) => MySplashScreen()));
            },
            heroTag: "btn1",
            icon: Icon(Icons.celebration_rounded),
            label: const Text(
              "Achievements",
              style: TextStyle(fontSize: 16),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              // print("......" + widget.model!.centreUID.toString());
              // if (widget.token == 0) {

              // } else {
              //   addObjectsToSchoolCart();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ClubsScreen(model: widget.model)));
              // }
            },
            heroTag: "btn2",
            icon: Icon(Icons.group),
            label: const Text("   Clubs   ", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (() {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (c) => ClubsScreen(model: widget.model)));
      // }),
      //   label: const Text("Clubs"),
      //   icon: Icon(
      //     Icons.delete_sweep_outlined,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.pinkAccent,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.photoUrl.toString()),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              widget.model!.schoolName.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.pinkAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Text(
              widget.model!.schoolEmail.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.model!.schoolAddress.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.pinkAccent),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 300.0),
            child: Divider(
              height: 1,
              thickness: 2,
              color: Colors.pinkAccent,
            ),
          )
        ],
      ),
    );
  }
}
