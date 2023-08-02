import 'package:bitnews/helper/data.dart';
import 'package:bitnews/helper/news.dart';
import 'package:bitnews/model/ArticleModel.dart';
import 'package:bitnews/model/category.dart';
import 'package:bitnews/widgets/Box.dart';
import 'package:bitnews/pages/LoginPage.dart';
import 'package:bitnews/widgets/blogTile.dart';
import 'package:bitnews/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePageTitle = "BitNews";

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // After successful sign-out, navigate to the login page or any other page
      // You can use Navigator.pushAndRemoveUntil to replace the current route
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) =>
                LoginScreen()), // Replace LoginPage with your desired page
        (route) => false, // This will remove all the routes from the stack
      );
    } catch (e) {
      print("Error signing out: $e");
      // Show an error message to the user if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign out failed. Please try again."),
        ),
      );
    }
  }

  List<CategoryModel>? categories;
  List<ArticleModel>? articles;

  bool _loading = true;

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
          title: Text(activePageTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _signOut(context),
            ),
          ],
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
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories!.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                  imageUrl: categories?[index].imageUrl,
                                  CategoryName:
                                      categories?[index].categoryName);
                            }),
                      ),

                      //Blogs
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
                      // Expanded(child: BoxList()),
                    ],
                  ),
                ),
              ));
  }
}
