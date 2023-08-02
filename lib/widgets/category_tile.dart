import 'package:bitnews/helper/news.dart';
import 'package:bitnews/widgets/category_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({this.imageUrl, this.CategoryName});

  final imageUrl, CategoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    category_news(category: CategoryName.toLowerCase())));
      },
      child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black26),
                child: Text(
                  CategoryName,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
