import 'dart:io';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PinCodeScreen(),
    );
  }
}

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
                onPressed: () {
                  // Implement your logic here to handle the entered PIN code.
                  if (pinCode.length == 6) {
                    print('You entered the PIN code: $pinCode');
                  } else {
                    print('Invalid input! Please enter a valid 6-digit PIN code.');
                  }
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
