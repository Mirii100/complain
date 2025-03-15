import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/feedback_provider.dart';

class FilterSearchScreen extends StatefulWidget {
  @override
  _FilterSearchScreenState createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  String? selectedType;
  String? selectedCategory;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: selectedType,
                      hint: Text('Select feedback type'),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text('All Types'),
                        ),
                        ...feedbackProvider.types.map((type) =>
                            DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                        ).toList(),
                      ],
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Filter by Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: selectedCategory,
                      hint: Text('Select category'),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text('All Categories'),
                        ),
                        ...feedbackProvider.categories.map((category) =>
                            DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                        ).toList(),
                      ],
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Filter by Date Range',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  startDate = picked;
                                });
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              child: Text(
                                startDate == null
                                    ? 'Start Date'
                                    : DateFormat('MMM dd, yyyy').format(startDate!),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  endDate = picked;
                                });
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              child: Text(
                                endDate == null
                                    ? 'End Date'
                                    : DateFormat('MMM dd, yyyy').format(endDate!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final filteredFeedback = feedbackProvider.filterFeedback(
                  type: selectedType,
                  category: selectedCategory,
                  startDate: startDate,
                  endDate: endDate,
                );

                Navigator.pop(context, filteredFeedback);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Apply Filters'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedType = null;
                  selectedCategory = null;
                  startDate = null;
                  endDate = null;
                });
              },
              child: Text('Clear All Filters'),
            ),
          ],
        ),
      ),
    );
  }}