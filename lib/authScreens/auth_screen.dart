import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skiome_centres/authScreens/registration_tab_page.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_tab_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
            title: "iShop".text.bold.xl3.make(),
            centerTitle: true,
            bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                tabs: [
                  Tab(
                    text: "login",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  Tab(
                    text: "Resistration",
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ]),
          ),
          body: Container(
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
            child: TabBarView(children: [
              LoginTabPage(),
              RegistrationTabPage(),
            ]),
          ),
        ));
  }
}
