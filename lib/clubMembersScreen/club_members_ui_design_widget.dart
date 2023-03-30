// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/clubMembersScreen/club_members_screen.dart';
import 'package:skiome_centres/clubs_Screens/clubs_screen.dart';
import 'package:skiome_centres/models/clubMembers.dart';
import 'package:skiome_centres/models/clubs.dart';

import '../functions/functions.dart';
import '../global/global.dart';
import '../models/categories.dart';
import '../objectsScreens/objects_screen.dart';

class ClubsMembersUiDesignWidget extends StatefulWidget {
  ClubMembers? model;
  String? schoolUID;
  BuildContext? context;
  ClubsMembersUiDesignWidget({
    this.schoolUID,
    this.model,
    this.context,
  });

  @override
  State<ClubsMembersUiDesignWidget> createState() =>
      _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<ClubsMembersUiDesignWidget> {
  // deleteCategory(String categoryId) {
  //   FirebaseFirestore.instance
  //       .collection("UsersSchools")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("Clubs")
  //       .doc(categoryId)
  //       .delete();
  //   showReusableSnackBar(context, "Category Deleted.");

  //   Navigator.push(context, MaterialPageRoute(builder: (c) => ClubsScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (c) => ClubsDetailsScreen(
        //               model: widget.model,
        //               schoolUID: widget.schoolUID,
        //             )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.network(
                  widget.model!.photoUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.name.toString(),
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    // IconButton(
                    //     onPressed: (() {
                    //       deleteCategory(widget.model!.clubUID.toString());
                    //     }),
                    //     icon: Icon(
                    //       Icons.delete_sweep,
                    //       color: Colors.pinkAccent,
                    //     ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
