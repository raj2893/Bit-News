import 'package:bitnews/main.dart';
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

class BoxList extends StatefulWidget {
  @override
  _BoxListState createState() => _BoxListState();
}

class _BoxListState extends State<BoxList> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
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

                    final String? pincode = news?['pincode'] as String?;

                    final String? webpageLink = news?['webpage'] as String?;
                    final String? datestamp = news?['datestamp'] as String?;
                    DateTime date = DateTime.parse(datestamp!);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(date);

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
                      child: Column(
                        children: [
                          // Background image
                          Container(
                            width: double.infinity,
                            height: mq.height * 0.03,
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/news.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Content on top of the image
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.black.withOpacity(0.7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'News',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Location: ${pincode ?? 'Not Found'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No data available for selected date range.'),
                );
        },
      ),
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
        DateTime startDate =
            _startDate ?? DateTime.now().subtract(Duration(days: 7));
        DateTime endDate = _endDate ?? DateTime.now();

        return Container(
          height: 300.0,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: startDate,
                  minimumDate: DateTime(DateTime.now().year - 1),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      startDate = newDate;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: endDate,
                  minimumDate: DateTime(DateTime.now().year - 1),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      endDate = newDate;
                    });
                  },
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);

                  // Check if start date is before end date
                  if (startDate.isBefore(endDate) ||
                      startDate.isAtSameMomentAs(endDate)) {
                    setState(() {
                      _startDate = startDate;
                      _endDate = endDate;
                    });
                  } else {
                    // Show a snackbar or dialog to indicate invalid date range
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Invalid date range. Please select a proper date range.'),
                    ));
                  }
                },
                child: Text('Done'),
              ),
            ],
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
        backgroundColor: Colors.white,
        title: Text(
          'Bit News',
          style: TextStyle(color: const Color.fromARGB(255, 73, 22, 3)),
        ),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(webpageLink)),
      ),
    );
  }
}
