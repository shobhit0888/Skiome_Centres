// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_centres/category_Screens/categories_ui_design_widget.dart';
import 'package:skiome_centres/category_Screens/upload_category_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:skiome_centres/pushNotifications/push_notifications_system.dart';
import 'package:skiome_centres/widgets/text_delegate_header_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../functions/functions.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getCentreEarningsFromDatabase() {
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((dataSnapshot) {
      previousEarnings = dataSnapshot.data()!["earnings"].toString();
    }).whenComplete(() {
      restrictBlockedCentresFromUsingCentresApp();
    });
  }

  restrictBlockedCentresFromUsingCentresApp() async {
    await FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] != "approved") {
        showReusableSnackBar(context, "you are blocked by admin.");
        showReusableSnackBar(context, "contact admin:  admin2@ishop.com");
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
    pushNotificationsSystem.whenNotificationReceived(context);
    pushNotificationsSystem.generateDeviceRecognitionToken();
    getCentreEarningsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
                        builder: ((context) => UploadCategoryScreens())));
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
            title: "Categories",
          )),
          //write   query
          //model
          //design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .doc(sharedPreferences!.getString("uid"))
                .collection("ObjectCategories")
                .orderBy("publishDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Categories categoriesModel = Categories.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return CategoriesUiDesignWidget(
                      model: categoriesModel,
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
