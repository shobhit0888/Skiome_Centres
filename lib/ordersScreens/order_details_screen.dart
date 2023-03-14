// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:skiome_centres/ordersScreens/address_design_widget.dart';
import 'package:skiome_centres/ordersScreens/status_banner_widget.dart';

import '../global/global.dart';
import '../models/address.dart';

class OrderDetailsScreen extends StatefulWidget {
  String? orderId;
  OrderDetailsScreen({
    this.orderId,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Orders")
              .doc(widget.orderId)
              .get(),
          builder: (c, AsyncSnapshot dataSnapshot) {
            Map? orderDataMap;
            if (dataSnapshot.hasData) {
              orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
              orderStatus = orderDataMap["status"].toString();
              return Column(
                children: [
                  StatusBanner(
                    status: orderDataMap["isSuccess"],
                    orderStatus: orderStatus,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Rs." + orderDataMap["totalAmount"].toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "OrderId: " + orderDataMap["orderId"].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order At: " +
                            DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(orderDataMap["orderTime"]))),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1, color: Colors.pinkAccent),
                  orderStatus == "ended"
                      ? Image.asset("images/delivered.jpg")
                      : Image.asset("images/packing.jpg"),
                  const Divider(thickness: 1, color: Colors.pinkAccent),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("UsersSchools")
                        .doc(orderDataMap["orderBy"])
                        .collection("SchoolAddress")
                        .doc(orderDataMap["addressId"])
                        .get(),
                    builder: (c, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return AddressDesign(
                          model: Address.fromJson(
                              snapshot.data.data() as Map<String, dynamic>),
                          orderSatus: orderStatus,
                          orderId: widget.orderId,
                          centreId: orderDataMap!["centreUID"],
                          orderByUser: orderDataMap["orderBy"],
                          totalAmount: orderDataMap["totalAmount"].toString(),
                        );
                      } else {
                        return Center(
                          child: Text("No data exists"),
                        );
                      }
                    },
                  )
                ],
              );
            } else {
              return Center(
                child: Text(
                  "No data exists",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
