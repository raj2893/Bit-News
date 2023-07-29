import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'shaded_box.dart';
import 'category.dart';

import 'data_trait.dart';

class BoxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100, // Set the number of boxes
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 300,
            child: ImageWithColumns());
        },
      ),
    );
  }
}
