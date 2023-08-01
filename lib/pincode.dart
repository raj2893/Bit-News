import 'package:bitnews/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String pinCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Code Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (value) {
                    setState(() {
                      pinCode = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter 6-digit PIN',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (pinCode.length == 6) {
                    print('You entered the PIN code: $pinCode');

                    final User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .set({'pincode': pinCode});
                        print('PIN code successfully stored in Firestore!');
                      } catch (e) {
                        print('Error storing PIN code: $e');
                      }
                    }
                  } else {
                    print(
                        'Invalid input! Please enter a valid 6-digit PIN code.');
                  }
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));

                  // String firstFourCharacters = pinCode.substring(0, 4);

                  // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  //     .collection('newsData-2')
                  //     .where('pincode',
                  //         isGreaterThanOrEqualTo: firstFourCharacters)
                  //     .where('pincode', isLessThan: firstFourCharacters + 'z')
                  //     .get();

                  // List<DocumentSnapshot> newsDocuments = querySnapshot.docs;
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
