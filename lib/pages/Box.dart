import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoxList extends StatefulWidget {
  @override
  _BoxListState createState() => _BoxListState();
}

class _BoxListState extends State<BoxList> {
  DateTime? _startDate;
  DateTime? _endDate;
  String userPinCode = '';

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

          List<QueryDocumentSnapshot> filteredNewsDocs =
              _filterNewsDocsByDateAndPincode(newsDocs);

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
                          child: Text(
                            news?['title'] ?? 'Title',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                      'No data available for selected date range and pincode.'),
                );
        },
      ),
    );
  }

  List<QueryDocumentSnapshot> _filterNewsDocsByDateAndPincode(
      List<QueryDocumentSnapshot>? newsDocs) {
    if (newsDocs == null ||
        _startDate == null ||
        _endDate == null ||
        userPinCode.isEmpty) {
      return [];
    }

    return newsDocs.where((doc) {
      var datestamp = doc['datestamp'];

      if (datestamp is String) {
        DateTime date = DateTime.parse(datestamp);
        return date.isAfter(_startDate!) &&
            date.isBefore(_endDate!.add(Duration(days: 1))) &&
            doc['pincode'] != null &&
            doc['pincode'].startsWith(userPinCode);
      } else if (datestamp is Timestamp) {
        DateTime date = datestamp.toDate();
        return date.isAfter(_startDate!) &&
            date.isBefore(_endDate!.add(Duration(days: 1))) &&
            doc['pincode'] != null &&
            doc['pincode'].startsWith(userPinCode);
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

                  if (startDate.isBefore(endDate) ||
                      startDate.isAtSameMomentAs(endDate)) {
                    setState(() {
                      _startDate = startDate;
                      _endDate = endDate;
                    });
                  } else {
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
