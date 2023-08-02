import 'package:bitnews/widgets/article_view.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  const BlogTile({this.imageUrl, this.title, this.desc, this.url});

  final String? imageUrl, title, desc, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(url: url!)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child:
                    imageUrl != null ? Image.network(imageUrl!) : Container()),
            SizedBox(
              height: 8,
            ),
            title != null
                ? Text(
                    title!,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  )
                : Container(),
            SizedBox(
              height: 8,
            ),
            desc != null
                ? Text(
                    desc!,
                    style: TextStyle(color: Colors.black54),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
