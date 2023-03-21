import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_centres/mainScreens/events_card_widget.dart';
import 'package:skiome_centres/mainScreens/global_pool_card_widget.dart';
import 'package:skiome_centres/mainScreens/school_card_widget.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'package:velocity_x/velocity_x.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../functions/functions.dart';
import '../global/global.dart';
import '../pushNotifications/push_notifications_system.dart';
import '../schoolsScreens/registration_tab_page.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/my_drawer.dart';

class HomeScreenForCentre extends StatefulWidget {
  const HomeScreenForCentre({super.key});

  @override
  State<HomeScreenForCentre> createState() => _HomeScreenForCentreState();
}

class _HomeScreenForCentreState extends State<HomeScreenForCentre> {
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: ((context) => SchoolsRegistrationTabPage())));
        //       },
        //       icon: Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ))
        // ],
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     //write   query
      //     //model
      //     //design widget
      //     StreamBuilder(
      //       stream: FirebaseFirestore.instance
      //           .collection("Centres")
      //           .doc(sharedPreferences!.getString("uid"))
      //           .collection("UsersSchools")
      //           .snapshots(),
      //       builder: (context, AsyncSnapshot dataSnapshot) {
      //         if (dataSnapshot.hasData) //if categoies exist
      //         {
      //           //show categories
      //           return SliverStaggeredGrid.countBuilder(
      //             crossAxisCount: 1,
      //             staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
      //             itemBuilder: (context, index) {
      //               Schools schoolsModel = Schools.fromJson(
      //                 dataSnapshot.data.docs[index].data()
      //                     as Map<String, dynamic>,
      //               );
      //               return CategoriesUiDesignWidget(
      //                 model: schoolsModel,
      //                 context: context,
      //               );
      //             },
      //             itemCount: dataSnapshot.data.docs.length,
      //           );
      //         } else {
      //           //if category does not exist
      //           return const SliverToBoxAdapter(
      //             child: Center(
      //               child: Text("No Categories exists"),
      //             ),
      //           );
      //         }
      //       },
      //     )
      //   ],
      // ),
      body: GridView.custom(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        childrenDelegate: SliverChildListDelegate(
          [
            SchoolCardWidget(),
            GlobalPoolCardWidget(),
            EventsCardWidget(),
            FlutterLogo(),
          ],
        ),
      ),
    );
  }
}
