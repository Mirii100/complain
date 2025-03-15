import 'package:complement_complain/screens%20/layout/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin.dart';
import '../models/feedback_provider.dart';
import 'analytic.dart';
import 'filter.dart';


class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final feedbacks = feedbackProvider.feedbackItems;

    // Count by type
    final complaintCount = feedbacks.where((f) => f?.type == 'Complaint').length;
    final complimentCount = feedbacks.where((f) => f?.type == 'Compliment').length;
    final generalCount = feedbacks.where((f) => f?.type == 'General').length;

    // Count unread
    final unreadCount = feedbacks.where((f) => f?.isRead == false).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminUserManagementScreen()),
              );
            },
          ),
        ],
      ),
      body: feedbacks.isEmpty
          ? Center(
        child: Text('No feedback received yet'),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', feedbacks.length, Colors.blue),
                _buildStatCard('Unread', unreadCount, Colors.red),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Complaints', complaintCount, Colors.orange),
                _buildStatCard('Compliments', complimentCount, Colors.green),
                _buildStatCard('General', generalCount, Colors.purple),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.filter_list),
                    label: Text('Filter'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterSearchScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.analytics),
                    label: Text('Analytics'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnalyticsScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = feedbacks[index];
                if (feedback == null) return SizedBox.shrink();
                return ListTile(
                  leading: _getFeedbackIcon(feedback.type ?? ''),
                  title: Text(feedback.title ?? 'No title'),
                  subtitle: Text(feedback.message ?? 'No message'),
                  trailing: feedback.isRead ?? false
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.mark_email_unread, color: Colors.red),
                  onTap: () {
                    // Handle tapping on feedback item
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getFeedbackIcon(String type) {
    switch (type) {
      case 'Complaint':
        return Icon(Icons.warning, color: Colors.orange);
      case 'Compliment':
        return Icon(Icons.thumb_up, color: Colors.green);
      case 'General':
        return Icon(Icons.info, color: Colors.blue);
      default:
        return Icon(Icons.feedback, color: Colors.grey);
    }
  }
}
