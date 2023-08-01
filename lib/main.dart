import 'package:bitnews/auth_service.dart';
import 'package:bitnews/pages/LoginPage.dart';
import 'package:bitnews/pincode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:ui';

late Size mq;

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 201, 201, 201),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // _initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _authService.authStateChanges,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return MaterialApp(
                theme: theme,
                debugShowCheckedModeBanner: false,
                title: 'Bit News',
                home: Center(child: LoginScreen()),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Bit News',
                theme: theme,
                home: PinCodeScreen(),
              );
            }
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bit News',
              theme: theme,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}

// _initializeFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }

// MaterialApp(
//       theme: theme,
//       debugShowCheckedModeBanner: false,
//       title: 'BitNews',
//       home: Center(child: LoginScreen()),
//     );
