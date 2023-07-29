import 'package:bitnews/pages/Box.dart';
import 'package:bitnews/pages/drawerr.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
class HomePage extends StatelessWidget {
  String activePageTitle = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: BoxList(),
      drawer: Drawerr(),
      bottomNavigationBar: BottomNavigationBar(
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
