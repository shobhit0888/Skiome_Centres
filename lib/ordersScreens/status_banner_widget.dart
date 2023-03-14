// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../category_Screens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;
  StatusBanner({
    this.status,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;
    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successfull" : message = "UnSuccessfull";
    return Container(
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
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => HomeScreen()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            // const SizedBox(
            //   width: 25,
            // ),

            Text(
                orderStatus == "ended"
                    ? "Parcel Delivered $message"
                    : orderStatus == "shifted"
                        ? "Parcel Shifted $message"
                        : orderStatus == "normal"
                            ? "Order Placed $message"
                            : "",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            // const SizedBox(
            //   width: 6,
            // ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey,
              child: Center(
                  child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              )),
            )
          ],
        ),
      ),
    );
  }
}
