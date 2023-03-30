// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_centres/clubs_Screens/clubs_ui_design_widget.dart';
import 'package:skiome_centres/clubs_Screens/upload_club_screen.dart';
import 'package:skiome_centres/models/clubs.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:velocity_x/velocity_x.dart';

import '../functions/functions.dart';
import '../models/categories.dart';
import '../widgets/text_delegate_header_widget.dart';

class ClubsScreen extends StatefulWidget {
  Schools? model;
  ClubsScreen({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<ClubsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ClubsScreen> {
  // getCentreEarningsFromDatabase() {
  //   FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .get()
  //       .then((dataSnapshot) {
  //     previousEarnings = dataSnapshot.data()!["earnings"].toString();
  //   }).whenComplete(() {
  //     restrictBlockedCentresFromUsingCentresApp();
  //   });
  // }

  // restrictBlockedCentresFromUsingCentresApp() async {
  //   await FirebaseFirestore.instance
  //       .collection("Centres")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .get()
  //       .then((snapshot) {
  //     if (snapshot.data()!["status"] != "approved") {
  //       showReusableSnackBar(context, "you are blocked by admin.");
  //       showReusableSnackBar(context, "contact admin:  admin2@ishop.com");
  //       FirebaseAuth.instance.signOut();
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
  //   pushNotificationsSystem.whenNotificationReceived(context);
  //   pushNotificationsSystem.generateDeviceRecognitionToken();
  //   getCentreEarningsFromDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            UploadClubScreens(model: widget.model))));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: "Clubs",
          )),

          //write   query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UsersSchools")
                .doc(widget.model!.schoolUID)
                .collection("Clubs")
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
                    Clubs clubsModel = Clubs.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return ClubsUiDesignWidget(
                      schoolUID: widget.model!.schoolUID,
                      model: clubsModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                //if category does not exist
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Categories exists"),
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
