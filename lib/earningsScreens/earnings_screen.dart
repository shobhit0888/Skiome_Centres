import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String totaCentreEarnings = "";
  readTotalEarnings() async {
    FirebaseFirestore.instance
        .collection("Centres")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      setState(() {
        totaCentreEarnings = snap.data()!["earnings"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTotalEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rs." + totaCentreEarnings,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                "Total Earnings",
                style: TextStyle(
                    fontSize: 20, letterSpacing: 3, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Card(
                color: Colors.white54,
                margin:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => MySplashScreen()));
                  },
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Go Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
