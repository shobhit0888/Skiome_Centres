// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/objectsScreens/objects_ui_design_widget.dart';
import 'package:skiome_centres/objectsScreens/upload_objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:velocity_x/velocity_x.dart';

import '../mainScreens/home_screen_for_centre.dart';
import '../widgets/text_delegate_header_widget.dart';

class ObjectsScreen extends StatefulWidget {
  // Categories? model;
  Objects? model;
  Categories? categoryModel;
  ObjectsScreen({
    this.categoryModel,
  });
  @override
  State<ObjectsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ObjectsScreen> {
  saveObjectCategoryInfo() {
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .collection("ObjectCategories")
        .doc(widget.categoryModel!.categoryId)
        .set({
      "subject": widget.categoryModel!.subject,
      "categoryId": widget.categoryModel!.categoryId.toString(),
      "centreUID": sharedPreferences!.getString("uid"),
      "categoryInfo": widget.categoryModel!.categoryInfo.toString(),
      "categoryName": widget.categoryModel!.categoryName.toString(),
      "publishDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": widget.categoryModel!.thumbnailUrl.toString(),
    });
    // setState(() {
    //   uploading = false;
    //   categoryUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    // });
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => HomeScreenForCentre())));
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
        title: "Skiome Centres".text.bold.xl3.make(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                saveObjectCategoryInfo();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => UploadObjectsScreens(
                //               model: widget.model,
                //             ))));
              },
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: widget.categoryModel!.categoryName.toString() + " Objects",
          )),

          //1. query
          //2. model
          //3. ui design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                // .collection("Centres")
                // .doc(sharedPreferences!.getString("uid"))
                .collection("ObjectCategories")
                .doc(widget.categoryModel!.categoryId)
                .collection("Objects")
                .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Objects objectsModel = Objects.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return ObjectsUiDesignWidget(
                      model: objectsModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                //if category does not exist
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Objects exists"),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
