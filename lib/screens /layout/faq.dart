import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQHelpScreen extends StatelessWidget {
  final List<Map<String, String>> faqItems = [
    {
      'question': 'How does the anonymization work?',
      'answer': 'All feedback is submitted without any user identifiers. The system does not track IP addresses, device information, or account details when processing your feedback. This ensures complete anonymity for all submissions.'
    },
    {
      'question': 'Who can see my feedback?',
      'answer': 'Only authorized administrators with proper access privileges can view the submitted feedback. They will only see the feedback content and category, without any information that could identify you.'
    },
    {
      'question': 'Can I edit my feedback after submission?',
      'answer': 'No, once feedback is submitted, it cannot be edited. This helps maintain the integrity of the feedback system. If you need to provide additional information, you can submit a new feedback.'
    },
    {
      'question': 'How long is feedback stored?',
      'answer': 'Feedback is typically stored for a period of 12 months, after which it may be archived or anonymized further for analytical purposes only.'
    },
    {
      'question': 'How do I know my feedback was received?',
      'answer': 'After submitting feedback, you will see a confirmation screen indicating successful submission. You can also view your submission history in the app without compromising your anonymity.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & FAQ'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How to Use the Feedback System',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '1. Select the type of feedback you want to provide (Complaint, Compliment, or General).',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '2. Choose the appropriate category for your feedback.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3. Write your feedback in the provided text area. Be as specific as possible.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '4. Submit your feedback. You will receive a confirmation when it has been successfully submitted.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...faqItems.map((item) => _buildFAQItem(item['question']!, item['answer']!)).toList(),
          SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need More Help?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'If you have additional questions or need support, please contact our support team.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: Icon(Icons.email),
                    label: Text('Contact Support'),
                    onPressed: () {
                      // Contact support action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}