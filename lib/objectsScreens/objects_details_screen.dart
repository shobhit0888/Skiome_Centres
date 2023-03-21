// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_centres/category_Screens/home_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

class ObjectsDetailsScreen extends StatefulWidget {
  Objects? model;
  ObjectsDetailsScreen({
    this.model,
  });

  @override
  State<ObjectsDetailsScreen> createState() => _ObjectsDetailsScreenState();
}

class _ObjectsDetailsScreenState extends State<ObjectsDetailsScreen> {
  deleteObject() {
    FirebaseFirestore.instance
        // .collection("Centres")
        // .doc(sharedPreferences!.getString("uid"))
        .collection("ObjectCategories")
        .doc(widget.model!.categoryId)
        .collection("Objects")
        .doc(widget.model!.objectId)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Objects")
          .doc(widget.model!.objectId)
          .delete();
      Fluttertoast.showToast(msg: "Object Deleted Successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    });
  }

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
        title: Text(widget.model!.objectName.toString()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          deleteObject();
        }),
        label: const Text("Delete this Object"),
        icon: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.thumbnailUrl.toString()),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                widget.model!.objectName.toString(),
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
                widget.model!.longDescription.toString(),
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
                widget.model!.objectPrice.toString() + " Rs.",
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
      ),
    );
  }
}
