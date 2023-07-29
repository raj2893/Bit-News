import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  const Drawerr({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Text(
              'Drawer',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Sorting'),
            onTap: () {
              // Handle the option 1 tap
              // You can navigate to a different screen or update the state here.
            },
          ),
          ListTile(
            title: Text('News'),
            onTap: () {
              // Handle the option 2 tap
            },
          ),
        ],
      ),
    );
  }
}