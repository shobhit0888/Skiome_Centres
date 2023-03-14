import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/ordersScreens/order_details_screen.dart';

import '../models/objects.dart';

class OrderCard extends StatefulWidget {
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? orderId;
  List<String>? separateQuantitiesList;
  OrderCard({
    this.itemCount,
    this.data,
    this.orderId,
    this.separateQuantitiesList,
  });
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => OrderDetailsScreen(
              orderId: widget.orderId,
            )));
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.white54,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount! * 125, //5*125
          child: ListView.builder(
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              Objects model = Objects.fromJson(
                  widget.data![index].data() as Map<String, dynamic>);
              return placedOrderObjectsDesignWidget(
                  model, context, widget.separateQuantitiesList![index]);
            },
          ),
        ),
      ),
    );
  }
}

Widget placedOrderObjectsDesignWidget(
    Objects objects, BuildContext context, objectQuantity) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.transparent,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            objects.thumbnailUrl.toString(),
            width: 120,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //name and price
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        objects.objectName.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Rs.",
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 16),
                    ),
                    Text(
                      objects.objectPrice.toString(),
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //* with quantity number
                Row(
                  children: [
                    Text(
                      "*",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      objectQuantity,
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
