// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skiome_centres/bannerScreens/banners_registration.dart';
import 'package:skiome_centres/bannerScreens/banners_ui_design_widget.dart';
import 'package:skiome_centres/eventsScreens/events_ui_design_widget.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/models/banners.dart';
import 'package:skiome_centres/models/events.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:skiome_centres/objectsScreens/objects_ui_design_widget.dart';
import 'package:skiome_centres/objectsScreens/upload_objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:skiome_centres/schoolsScreens/registration_tab_page.dart';
import 'package:skiome_centres/schoolsScreens/school_ui_design_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:skiome_centres/eventsScreens/events_registration.dart';
import '../widgets/text_delegate_header_widget.dart';

class BannersScreen extends StatefulWidget {
  @override
  State<BannersScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<BannersScreen> {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => BannerRegistrationPage()));
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
            title: "Banner Images",
          )),

          //1. query
          //2. model
          //3. ui design widget
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Centres")
                .doc(sharedPreferences!.getString("uid"))
                .collection("Banners")
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if categoies exist
              {
                //show categories
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Banners bannersModel = Banners.fromJson(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );
                    return BannersUiDesignWidget(
                      model: bannersModel,
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
