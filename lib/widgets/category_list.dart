import 'package:bitnews/helper/news.dart';
import 'package:bitnews/model/ArticleModel.dart';
import 'package:bitnews/widgets/blogTile.dart';
import 'package:flutter/material.dart';

class category_news extends StatefulWidget {
  final String category;
  const category_news({super.key, required this.category});

  @override
  State<category_news> createState() => _category_newsState();
}

class _category_newsState extends State<category_news> {
  List<ArticleModel>? articles;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;

    print(articles);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BitNews"),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (articles != null) {
                              return BlogTile(
                                imageUrl: articles![index].urlToImage,
                                title: articles![index].title,
                                desc: articles![index].description,
                                url: articles![index].url,
                              );
                            } else {
                              return Center(
                                child: Container(
                                  child: Text("No items found!"),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
