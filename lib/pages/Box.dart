import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'shaded_box.dart';
import 'category.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'data_trait.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart'
    as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

// class BoxList extends StatefulWidget {
//   @override
//   _BoxListState createState() => _BoxListState();
// }

// class _BoxListState extends State<BoxList> {
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

//           return ListView.builder(
//             itemCount: newsDocs.length,
//             itemBuilder: (BuildContext context, int index) {
//               final news = newsDocs[index].data() as Map<String, dynamic>?;

//               final String? webpageLink = news?['webpage'] as String?;

//               return GestureDetector(
//                 onTap: () {
//                   if (webpageLink != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => InAppWebViewPage(webpageLink),
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   child: Center(
//                     child: Text('Title',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class BoxList extends StatefulWidget {
  @override
  _BoxListState createState() => _BoxListState();
}

class _BoxListState extends State<BoxList> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _showDateRangePicker,
          ),
        ],
      ),
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

          // Filter the news documents based on the selected date range
          List<QueryDocumentSnapshot> filteredNewsDocs =
              _filterNewsDocsByDate(newsDocs);

          return filteredNewsDocs.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredNewsDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final news =
                        filteredNewsDocs[index].data() as Map<String, dynamic>?;

                    final String? webpageLink = news?['webpage'] as String?;

                    return GestureDetector(
                      onTap: () {
                        if (webpageLink != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InAppWebViewPage(webpageLink),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text('Title',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  },
                )
              : _buildNoDataAvailableWidget();
        },
      ),
    );
  }

  Widget _buildNoDataAvailableWidget() {
    return Center(
      child: Text('No data available.'),
    );
  }

  List<QueryDocumentSnapshot> _filterNewsDocsByDate(
      List<QueryDocumentSnapshot>? newsDocs) {
    if (newsDocs == null || _startDate == null || _endDate == null) {
      return [];
    }

    // Filter the news documents based on the selected date range
    return newsDocs.where((doc) {
      var datestamp = doc['datestamp'];

      if (datestamp is String) {
        DateTime date = DateTime.parse(datestamp);
        return date.isAfter(_startDate!) &&
            date.isBefore(_endDate!.add(Duration(days: 1)));
      } else if (datestamp is Timestamp) {
        DateTime date = datestamp.toDate();
        return date.isAfter(_startDate!) &&
            date.isBefore(_endDate!.add(Duration(days: 1)));
      }

      return false;
    }).toList();
  }

  void _showDateRangePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime:
                _startDate ?? DateTime.now().subtract(Duration(days: 7)),
            minimumDate: DateTime(DateTime.now().year - 1),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                if (_startDate == null) {
                  _startDate = newDate;
                } else if (_endDate == null || newDate.isAfter(_endDate!)) {
                  _endDate = newDate;
                } else {
                  _startDate = newDate;
                }
              });
            },
          ),
        );
      },
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

// class InAppWebViewPage extends StatelessWidget {
//   final String webpageLink;

//   InAppWebViewPage(this.webpageLink);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Webpage'),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: Uri.parse(webpageLink)),
//       ),
//     );
//   }
// }

// Function to convert date strings to Firestore Timestamps
Future<void> convertDatesToTimestamps() async {
  // Get a reference to the collection
  CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('newsData-2');

  // Fetch the documents that contain the date fields in string format
  QuerySnapshot querySnapshot = await newsCollection.get();

  // Loop through each document and update the date fields to Timestamps
  for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
    // Get the date field value as a string
    String dateString = docSnapshot.get('datestamp');

    // Parse the date string to a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Convert the DateTime object to a Firestore Timestamp
    Timestamp timestamp = Timestamp.fromDate(date);

    // Update the document with the new Timestamp
    await docSnapshot.reference.update({'datestamp': timestamp});
  }
}
