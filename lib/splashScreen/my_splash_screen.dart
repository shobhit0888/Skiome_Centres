import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authScreens/auth_screen.dart';
import '../category_Screens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  splashScreenTimer() {
    Timer(const Duration(seconds: 2), () {
      //user is already logged in
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      //user is not logged in
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset("images/splash.png"),
              ),
              Text(
                "Skiome Centres App",
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
