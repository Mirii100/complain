import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/feedback_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final feedbacks = feedbackProvider.feedbackItems;

    // Prepare data for charts
    final Map<String, int> typeDistribution = {
      'Complaint': 0,
      'Compliment': 0,
      'General': 0,
    };

    final Map<String, int> categoryDistribution = {};

    for (var feedback in feedbacks) {
      typeDistribution[feedback.type] = (typeDistribution[feedback.type] ?? 0) + 1;
      categoryDistribution[feedback.category] = (categoryDistribution[feedback.category] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Analytics'),
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
                    Text(
                      'Feedback Type Distribution',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: feedbacks.isEmpty
                          ? Center(child: Text('No data available'))
                          : PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              title: 'Complaints',
                              value: typeDistribution['Complaint']!.toDouble(),
                              color: Colors.orange,
                            ),
                            PieChartSectionData(
                              title: 'Compliments',
                              value: typeDistribution['Compliment']!.toDouble(),
                              color: Colors.green,
                            ),
                            PieChartSectionData(
                              title: 'General',
                              value: typeDistribution['General']!.toDouble(),
                              color: Colors.blue,
                            ),
                          ],
                          centerSpaceRadius: 40,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback by Category',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: feedbacks.isEmpty
                          ? Center(child: Text('No data available'))
                          : BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: categoryDistribution.values.isEmpty
                              ? 1
                              : categoryDistribution.values.reduce((a, b) => a > b ? a : b).toDouble() * 1.2,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value < 0 || value >= categoryDistribution.keys.length) {
                                    return const Text('');
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      categoryDistribution.keys.elementAt(value.toInt()),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: categoryDistribution.entries.map((entry) {
                            return BarChartGroupData(
                              x: categoryDistribution.keys.toList().indexOf(entry.key),
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value.toDouble(),
                                  color: Colors.purple,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.download),
              label: Text('Export Analytics Report'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Report exported successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
