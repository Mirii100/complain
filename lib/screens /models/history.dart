import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'feedback_provider.dart';


class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final feedbacks = feedbackProvider.feedbackItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Feedback History'),
      ),
      body: feedbacks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No feedback history yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Your submitted feedback will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final feedback = feedbacks[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _getFeedbackIcon(feedback.type),
                      SizedBox(width: 8),
                      Text(
                        feedback.type,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(feedback.category),
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat('MMM dd, yyyy - HH:mm').format(feedback.createdAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    feedback.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                // View feedback details
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Feedback Details'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type: ${feedback.type}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Category: ${feedback.category}'),
                        SizedBox(height: 8),
                        Text(
                          'Date: ${DateFormat('MMM dd, yyyy - HH:mm').format(feedback.createdAt)}',
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Message:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(feedback.message),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getFeedbackIcon(String type) {
    switch (type) {
      case 'Complaint':
        return Icon(Icons.thumb_down, color: Colors.orange);
      case 'Compliment':
        return Icon(Icons.thumb_up, color: Colors.green);
      case 'General':
        return Icon(Icons.message, color: Colors.blue);
      default:
        return Icon(Icons.help_outline, color: Colors.grey);
    }
  }
}

// Main App
