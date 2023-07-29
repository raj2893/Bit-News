import 'package:flutter/material.dart';

class BoxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100, // Set the number of boxes
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10),
            height: 300, // Set the height of each box
            color:
                Color.fromARGB(255, 237, 233, 233), // Set the color of each box
            child: Center(
              child: Text('Box $index',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}
