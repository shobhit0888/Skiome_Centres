// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/ordersScreens/order_card.dart';

import '../global/global.dart';

// import 'package:velocity_x/velocity_x.dart';

class ShiftedParcelsScreen extends StatefulWidget {
  @override
  State<ShiftedParcelsScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<ShiftedParcelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        title: Text(
          "Shifted Parcels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where("status", isEqualTo: "shifted")
            .where("centreUID", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            //display

            return ListView.builder(
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Objects")
                      .where("objectId",
                          whereIn: cartMethods.separateOrderObjectIDs(
                              (dataSnapshot.data.docs[index].data()
                                  as Map<String, dynamic>)["productIds"]))
                      .where("centreUID",
                          whereIn: (dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // Orders model = Orders.fromJson(
                      //     snapshot.data.docs[index].data()
                      //         as Map<String, dynamic>);

                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapshot.data.docs[index].id,
                        separateQuantitiesList:
                            cartMethods.separateOrderObjectQuantities(
                                (dataSnapshot.data.docs[index].data()
                                    as Map<String, dynamic>)["productIds"]),
                      );
                    } else {
                      return const Center(
                        child: Text("No data exists"),
                      );
                    }
                  },
                );
              },
              itemCount: dataSnapshot.data.docs.length,
            );
          } else {
            return const Center(
              child: Text("No data exists"),
            );
          }
        },
      ),
    );
  }
}
