import 'package:bitnews/pages/Box.dart';
import 'package:bitnews/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  String activePageTitle = "BitNews";

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // After successful sign-out, navigate to the login page or any other page
      // You can use Navigator.pushAndRemoveUntil to replace the current route
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) =>
                LoginScreen()), // Replace LoginPage with your desired page
        (route) => false, // This will remove all the routes from the stack
      );
    } catch (e) {
      print("Error signing out: $e");
      // Show an error message to the user if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign out failed. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: BoxList(),
    );
  }
}
