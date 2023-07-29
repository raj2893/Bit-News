import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
            margin: const EdgeInsets.all(10),
            height: 300, 
            child: const Column(
                  children: [
                    Text(
                      "Category.title",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ItemTrait(
                          icon: Icons.schedule,
                          label: "Hello",
                        ),
                        SizedBox(width: 12),
                        ItemTrait(
                          icon: Icons.work,
                          label: "Hi",
                        ),
                      ],
                    ),
                  ],
                ),
          );
        },
      ),
    );
  }
}
