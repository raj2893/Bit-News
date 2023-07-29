import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'shaded_box.dart';
import 'category.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'data_trait.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class BoxList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 100, // Set the number of boxes
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//               width: double.infinity, height: 300, child: ImageWithColumns());
//         },
//       ),
//     );
//   }
// }

// class BoxList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('newsData-2').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           final newsDocs = snapshot.data?.docs;
//           if (newsDocs == null || newsDocs.isEmpty) {
//             return Center(
//               child: Text('No data available.'),
//             );
//           }

//           return Column(children: [
//             Expanded(
//               child: ListView.separated(
//                 separatorBuilder: (context, index) => Divider(),
//                 cacheExtent: 100,
//                 itemCount: newsDocs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final news = newsDocs[index].data() as Map<String, dynamic>?;

//                   final String? title = news?['title'] as String?;
//                   final String? webpageLink = news?['webpage'] as String?;

//                   return GestureDetector(
//                     onTap: () {
//                       if (webpageLink != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => InAppWebViewPage(webpageLink),
//                           ),
//                         );
//                       }
//                     },
//                     // child: Container(
//                     //   width: double.infinity,
//                     //   height: 300,
//                     //   child: ImageWithColumns(),
//                     // ),
//                   );
//                 },
//               ),
//             ),
//           ]);
//         },
//       ),
//     );
//   }
// }
// class BoxList extends StatelessWidget {

//   Future<Uint8List?> captureWebViewScreenshot(String url) async {
//     final controller = InAppWebViewController();
//     await controller.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
//     await Future.delayed(Duration(seconds: 2)); // Wait for the webpage to load (adjust as needed)
//     return await controller.takeScreenshot();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('newsData-2').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           final newsDocs = snapshot.data?.docs;
//           if (newsDocs == null || newsDocs.isEmpty) {
//             return Center(
//               child: Text('No data available.'),
//             );
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: newsDocs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final news =
//                         newsDocs[index].data() as Map<String, dynamic>?;

//                     // final String? title = news?['title'] as String?;
//                     final String? webpageLink = news?['webpage'] as String?;
//                     final Uint8List? screenshot = await captureWebViewScreenshot(webpageLink!);

//                     return GestureDetector(
//                       onTap: () {
//                         if (webpageLink != null) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   InAppWebViewPage(webpageLink),
//                             ),
//                           );
//                         }
//                         // if (webpageLink == null || webpageLink.isEmpty) {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) =>
//                         //           InAppWebViewPage('https://www.google.com'),
//                         //     ),
//                         //   );
//                         // }
//                       },
//                       child: Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       if (screenshot != null) Image.memory(screenshot, fit: BoxFit.cover),
//                       SizedBox(height: 8),

//                     ],
//                   ),
//                 ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class BoxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('newsData-2').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final newsDocs = snapshot.data?.docs;
          if (newsDocs == null || newsDocs.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          }

          return ListView.builder(
            itemCount: newsDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final news = newsDocs[index].data() as Map<String, dynamic>?;

              final String? webpageLink = news?['webpage'] as String?;

              return GestureDetector(
                onTap: () {
                  if (webpageLink != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InAppWebViewPage(webpageLink),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200, // Adjust the height as needed
                        child: InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(webpageLink!)),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class InAppWebViewPage extends StatelessWidget {
  final String webpageLink;

  InAppWebViewPage(this.webpageLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webpage'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(webpageLink)),
      ),
    );
  }
}
