// import 'package:flutter/material.dart';
// import 'package:bitnews/pages/CategoryPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final _passKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   void _loginWithEmailAndPassword(
//       BuildContext context, String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // Login successful, navigate to next page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => SelectionOptionsPage()),
//       );
//     } catch (e) {
//       // Handle login errors, you can display a snackbar or show an error message
//       print("Error logging in: $e");
//     }
//   }

//   void _loginWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//         UserCredential userCredential =
//             await _auth.signInWithCredential(credential);
//         // Login successful, navigate to next page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SelectionOptionsPage()),
//         );
//       } else {
//         // Handle Google login error
//         print("Error logging in with Google");
//       }
//     } catch (e) {
//       // Handle login errors, you can display a snackbar or show an error message
//       print("Error logging in with Google: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               //created a form with email and password fields with the validator set on the email
//               //field to check if the email is valid

//               //Text displaying BitNews

//               Center(
//                 child: Text(
//                   "Bit News",
//                   style: GoogleFonts.kaushanScript(
//                       fontSize: 40, fontWeight: FontWeight.w900),
//                 ),
//               ),

//               SizedBox(
//                 height: 20,
//               ),
//               //email field
//               FractionallySizedBox(
//                 widthFactor: 0.7,
//                 child: Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       hintText: "Email",
//                       hintStyle:
//                           TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter your email";
//                       } else if (!value.contains("@")) {
//                         return "Please enter a valid email";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               //password field
//               FractionallySizedBox(
//                 widthFactor: 0.7,
//                 child: Form(
//                   key: _passKey,
//                   child: TextFormField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       hintStyle:
//                           TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter your password";
//                       } else if (value.length < 6) {
//                         return "Password must be at least 6 characters";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               //login button
//               FractionallySizedBox(
//                 widthFactor: 0.7,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate() &&
//                         _passKey.currentState!.validate()) {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SelectionOptionsPage()));
//                     }
//                   },
//                   child: Text("Login"),
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       backgroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 15)),
//                 ),
//               ),

//               FractionallySizedBox(
//                 widthFactor: 0.7,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _loginWithGoogle(context);
//                   },
//                   child: Text("Login with Google"),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     backgroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:bitnews/helper/dialogs.dart';
import 'package:bitnews/pages/HomePage.dart';
import 'package:bitnews/helper/dialogs.dart';
import 'package:bitnews/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleButtonClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
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

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;

    return Scaffold(
      //App Bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome to Chat UP",
        ),
      ),
      body: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          top: mq.height * .15,
          width: mq.width * .5,
          right: _isAnimate ? mq.width * .25 : -mq.width * .5,
          child: Image.asset('assets/chat.png'),
        ),
        Positioned(
          bottom: mq.height * .15,
          width: mq.width * .9,
          left: mq.width * .05,
          height: mq.height * 0.07,
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 241, 252, 139),
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                _handleGoogleButtonClick();
              },
              icon: Image.asset(
                'assets/google.png',
                height: mq.height * 0.05,
              ),
              label: RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    children: [
                      TextSpan(text: 'Login in with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.w900)),
                    ]),
              )),
        ),
      ]),

      //Floating Action Button
    );
  }
}
