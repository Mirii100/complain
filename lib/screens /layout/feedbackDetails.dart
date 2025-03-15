import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/feedbackitem.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final FeedbackItem feedback;

  FeedbackDetailScreen({required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _getFeedbackIcon(feedback.type),
                        SizedBox(width: 8),
                        Text(
                          feedback.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Chip(
                          label: Text(feedback.category),
                          backgroundColor: Colors.grey[200],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      feedback.message,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          DateFormat('MMM dd, yyyy - HH:mm').format(feedback.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Admin Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add private notes here...',
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.archive),
                  label: Text('Archive'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.mark_email_read),
                  label: Text('Mark as Resolved'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFeedbackIcon(String type) {
    switch (type) {
      case 'Complaint':
        return Icon(Icons.warning, color: Colors.red);
      case 'Compliment':
        return Icon(Icons.thumb_up, color: Colors.green);
      case 'General':
        return Icon(Icons.info, color: Colors.blue);
      default:
        return Icon(Icons.feedback, color: Colors.grey);
    }
  }
}
