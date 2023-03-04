import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skiome_centres/global/global.dart';
import '../category_Screens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({super.key});

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      //allow user to login
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Please provide email and password");
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialogWidget(
            meassage: "Checking Credentials",
          );
        });

    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured: \n $errorMessage");
    });

    if (currentUser != null) {
      checkCentresRecordExist(currentUser!);
    }
  }

  checkCentresRecordExist(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("Centres")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) //record exist
      {
        if (record.data()!["status"] == "approved") {
          await sharedPreferences!.setString("uid", record.data()!["uid"]);
          await sharedPreferences!.setString("email", record.data()!["email"]);
          await sharedPreferences!.setString("name", record.data()!["name"]);
          await sharedPreferences!
              .setString("photoUrl", record.data()!["photoUrl"]);

          //send the user to homeScreen
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => HomeScreen()));
        } else //status is not approved
        {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  "You have been BLOCED by Admin. \n contact Admin : techlead@skiome.in");
        }
      } else //record not exist
      {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record does not exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/centres_login.png",
              height: MediaQuery.of(context).size.height * 0.30,
            ),
          ),
          Form(
            child: Column(
              children: [
                //email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: "Email",
                  isObscure: false,
                  enabled: true,
                ),
                //password
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: "Password",
                  isObscure: false,
                  enabled: true,
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
              onPressed: (() {
                validateForm();
              }),
              child: const Text(
                "LogIn",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
