import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiome_centres/global/global.dart';
import 'package:skiome_centres/splashScreen/my_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const Skiome_Centres());
}

class Skiome_Centres extends StatelessWidget {
  const Skiome_Centres({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Centres App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MySplashScreen());
  }
}
