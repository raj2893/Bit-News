import 'package:bitnews/pages/HomePage.dart';
import 'package:bitnews/pages/LoginPage.dart';
import 'package:bitnews/pincode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (x) => PinCodeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (x) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      //App Bar
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     "Welcome to Chat UP",
      //   ),
      // ),
      body: Stack(children: [
        Positioned(
          top: mq.height * .15,
          width: mq.width * .5,
          right: mq.width * .25,
          child: Image.asset('assets/news.png'),
        ),
        Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: Text(
              "MADE IN INDIA WITH ❤️",
              style: TextStyle(
                  fontSize: 16, color: Colors.black87, letterSpacing: .5),
              textAlign: TextAlign.center,
            )),
      ]),

      //Floating Action Button
    );
  }
}
