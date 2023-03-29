import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skiome_centres/category_Screens/home_screen.dart';
import 'package:skiome_centres/earningsScreens/earnings_screen.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/historyScreens/history_Screen.dart';
import 'package:skiome_centres/mainScreens/home_screen_for_centre.dart';
import 'package:skiome_centres/ordersScreens/orders_screen.dart';
import 'package:skiome_centres/shiftedParcelsScreens/shifted_parcels_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../splashScreen/my_splash_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // body
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //home
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  title: "Home".text.color(Colors.grey).make(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => HomeScreenForCentre()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //earnings
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.grey,
                  ),
                  title: "Earnings".text.color(Colors.grey).make(),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //my orders
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.grey,
                  ),
                  title: "New Orders".text.color(Colors.grey).make(),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => OrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //not yet received orders
                ListTile(
                  leading: const Icon(
                    Icons.picture_in_picture_rounded,
                    color: Colors.grey,
                  ),
                  title: "Shifted Orders".text.color(Colors.grey).make(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ShiftedParcelsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //history
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  title: "History".text.color(Colors.grey).make(),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //logout
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ),
                  title: "Logout".text.color(Colors.grey).make(),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => MySplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
