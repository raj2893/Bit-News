import 'package:bitnews/firebase_options.dart';
import 'package:bitnews/pages/CategoryPage.dart';
import 'package:bitnews/pages/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';

late Size mq;

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'BitNews',
      home: Center(child: LoginForm()),
    );
  }
}

// _initializeFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }
