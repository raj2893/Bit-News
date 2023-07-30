import 'package:bitnews/pages/Box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  String activePageTitle = "BitNews";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: BoxList(),
    );
  }
}
