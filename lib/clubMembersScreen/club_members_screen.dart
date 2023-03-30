// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_centres/category_Screens/home_screen.dart';
import 'package:skiome_centres/clubMembersScreen/club_members_ui_design_widget.dart';
import 'package:skiome_centres/clubMembersScreen/upload_club_members_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/clubMembers.dart';
import 'package:skiome_centres/models/clubs.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

class ClubsDetailsScreen extends StatefulWidget {
  Clubs? model;
  String? schoolUID;
  ClubsDetailsScreen({this.model, this.schoolUID});

  @override
  State<ClubsDetailsScreen> createState() => _ObjectsDetailsScreenState();
}

class _ObjectsDetailsScreenState extends State<ClubsDetailsScreen> {
  // saveObjectCategoryInfo() {
  //   FirebaseFirestore.instance
  //       .collection("UsersSchools")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("Clu")
  //       .doc(widget.model!.categoryId)
  //       .collection("Objects")
  //       .doc(widget.model!.objectId)
  //       .set({
  //     "objectId": widget.model!.objectId,
  //     "categoryId": widget.model!.categoryId.toString(),
  //     "centreUID": sharedPreferences!.getString("uid"),
  //     // "centreName": sharedPreferences!.getString("name"),
  //     "objectInfo": widget.model!.objectInfo.toString(),
  //     "objectName": widget.model!.objectName.toString(),
  //     "longDescription": widget.model!.longDescription.toString(),
  //     "objectPrice": widget.model!.objectPrice.toString(),
  //     "publishDate": widget.model!.publishDate.toString(),
  //     "status": "available",
  //     "thumbnailUrl": widget.model!.thumbnailUrl.toString(),
  //   });
  //   // .then((value) {
  //   //   FirebaseFirestore.instance.collection("Objects").doc(objectUniqueId).set({
  //   //     "objectId": objectUniqueId,
  //   //     "categoryId": widget.model!.categoryId.toString(),
  //   //     // "centreUID": sharedPreferences!.getString("uid"),
  //   //     // "centreName": sharedPreferences!.getString("name"),
  //   //     "objectInfo": objectInfoTextEditingController.text.trim(),
  //   //     "objectName": objectNameTextEditingController.text.trim(),
  //   //     "longDescription": objectDescriptionTextEditingController.text.trim(),
  //   //     "objectPrice": objectPriceTextEditingController.text.trim(),
  //   //     "publishDate": DateTime.now(),
  //   //     "status": "available",
  //   //     "thumbnailUrl": downloadUrlImage,
  //   //   });
  //   // }
  //   // );
  //   // setState(() {
  //   //   uploading = false;
  //   // });
  //   // Navigator.push(context,
  //   //     MaterialPageRoute(builder: ((context) => HomeScreenForCentre())));
  // }

  // deleteObject() {
  //   FirebaseFirestore.instance
  //       // .collection("Centres")
  //       // .doc(sharedPreferences!.getString("uid"))
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
        title: Text(widget.model!.clubName.toString()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            UploadClubMembersScreens(model: widget.model))));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.photoUrl.toString()),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Text(
                widget.model!.clubName.toString(),
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
                widget.model!.tagline.toString(),
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
                widget.model!.objective.toString() + " Rs.",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.pinkAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.category.toString() + " Rs.",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.pinkAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.publishDate.toString() + " Rs.",
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
            ),
            Container(
              height: MediaQuery.of(context).size.height * .75,
              child: CustomScrollView(
                slivers: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("UsersSchools")
                        .doc(widget.model!.schoolUID)
                        .collection("Clubs")
                        .doc(widget.model!.clubUID)
                        .collection("ClubMembers")
                        .orderBy("publishDate", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot dataSnapshot) {
                      if (dataSnapshot.hasData) //if categoies exist
                      {
                        //show categories
                        return SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 2,
                          staggeredTileBuilder: (c) =>
                              const StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            ClubMembers clubsMemberModel = ClubMembers.fromJson(
                              dataSnapshot.data.docs[index].data()
                                  as Map<String, dynamic>,
                            );
                            return ClubsMembersUiDesignWidget(
                              schoolUID: widget.model!.schoolUID,
                              model: clubsMemberModel,
                              context: context,
                            );
                          },
                          itemCount: dataSnapshot.data.docs.length,
                        );
                      } else {
                        //if category does not exist
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              "No Categories exists",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
