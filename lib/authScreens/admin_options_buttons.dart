// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:skiome_centres/authScreens/registration_tab_page.dart';
// import 'package:skiome_centres/category_Screens/home_screen.dart';
// import 'package:velocity_x/velocity_x.dart';

// class AdminOptionsButtons extends StatefulWidget {
//   const AdminOptionsButtons({super.key});

//   @override
//   State<AdminOptionsButtons> createState() => _AdminOptionsButtonsState();
// }

// class _AdminOptionsButtonsState extends State<AdminOptionsButtons> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                 colors: [
//                   Colors.pinkAccent,
//                   Colors.purpleAccent,
//                 ],
//                 begin: FractionalOffset(0.0, 0.0),
//                 end: FractionalOffset(1.0, 0.0),
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp,
//               )),
//             ),
//             title: "Skiome".text.bold.xl3.make(),
//             centerTitle: true,
//             bottom: const TabBar(
//                 indicatorColor: Colors.white,
//                 indicatorWeight: 4,
//                 tabs: [
//                   Tab(
//                     text: "Global Categories",
//                     icon: Icon(
//                       Icons.lock,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Tab(
//                     text: "Centre Registration",
//                     icon: Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     ),
//                   )
//                 ]),
//           ),
//           body: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//               colors: [
//                 Colors.pinkAccent,
//                 Colors.purpleAccent,
//               ],
//               begin: FractionalOffset(0.0, 0.0),
//               end: FractionalOffset(1.0, 0.0),
//               stops: [0.0, 1.0],
//               tileMode: TileMode.clamp,
//             )),
//             child: TabBarView(children: [
//               HomeScreen(),
//               RegistrationTabPage(),
//             ]),
//           ),
//         ));
//   }
// }
