import 'dart:io';
import 'package:bitnews/widgets/dialogs.dart';
import 'package:bitnews/main.dart';
import 'package:bitnews/pages/signupPage.dart';
import 'package:bitnews/pincode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      Dialogs.showProgressBar(context);
      // final String email = _emailController.text.trim();
      // final String password = _passwordController.text;

      // Use FirebaseAuth to sign in with email and password
      // final UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PinCodeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        Dialogs.showSnackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Dialogs.showSnackbar(context, 'Wrong password provided for that user.');
      } else {
        Dialogs.showSnackbar(context, 'Something Went Wrong.');
      }
    }
  }

  _handleGoogleButtonClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PinCodeScreen(),
        ),
      );
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      // Sign out the user from Firebase Auth
      await FirebaseAuth.instance.signOut();
      // Sign out the user from Google Sign-In (revoke OAuth token)
      await GoogleSignIn().signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      //App Bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome to Bit News",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: mq.height * 0.15,
              child: Image.asset('assets/newsFinal.png'),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              width: mq.width * .9,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),

            // Password TextField
            Container(
              width: mq.width * .9,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Login Button
            Container(
              width: mq.width * .85,
              height: mq.height * 0.1,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New to Bit News? '),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: mq.width * 0.3,
                    height: 1,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: mq.width * 0.3,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: mq.width * .85,
              height: mq.height * 0.07,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 37, 67),
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () async {
                    await _handleSignOut(context);
                    _handleGoogleButtonClick();
                  },
                  icon: Image.asset(
                    'assets/google.png',
                    height: mq.height * 0.05,
                  ),
                  label: RichText(
                    text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        children: [
                          TextSpan(text: 'Login with '),
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ]),
                  )),
            ),
          ]),
        ),
      ),

// Floating Action Button
    );
  }
}
