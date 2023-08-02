import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.url});

  // final String url;

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bit News',
          style: TextStyle(color: const Color.fromARGB(255, 73, 22, 3)),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
        ),
      ),
    );
  }
}

// class InAppWebViewPage extends StatelessWidget {
//   final String webpageLink;

//   InAppWebViewPage(this.webpageLink);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Bit News',
//           style: TextStyle(color: const Color.fromARGB(255, 73, 22, 3)),
//         ),
//         centerTitle: true,
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: Uri.parse(webpageLink)),
//       ),
//     );
//   }
// }
