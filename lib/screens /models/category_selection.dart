import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../layout/feedback_composition.dart';
import 'feedback_provider.dart';

class CategorySelectionScreen extends StatelessWidget {
  final String feedbackType;

  CategorySelectionScreen({required this.feedbackType});

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What is your $feedbackType about?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ...feedbackProvider.categories.map((category) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackCompositionScreen(
                            feedbackType: feedbackType,
                            category: category,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}