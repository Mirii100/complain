import 'package:flutter/cupertino.dart';

import 'feedbackitem.dart';

class FeedbackProvider extends ChangeNotifier {
  List<FeedbackItem> _feedbackItems = [];
  List<String> _categories = ['Service', 'Product', 'Employee', 'Facility', 'Other'];
  List<String> _types = ['Complaint', 'Compliment', 'General'];

  List<FeedbackItem> get feedbackItems => _feedbackItems;
  List<String> get categories => _categories;
  List<String> get types => _types;

  Future<void> submitFeedback(String type, String category, String message) async {
    final newFeedback = FeedbackItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      category: category,
      message: message,
      createdAt: DateTime.now(),
    );

    _feedbackItems.add(newFeedback);
    // Save to local storage or send to API
    notifyListeners();
  }


  List<FeedbackItem> filterFeedback({String? type, String? category, DateTime? startDate, DateTime? endDate}) {
    return _feedbackItems.where((item) {
      bool matchesType = type == null || item.type == type;
      bool matchesCategory = category == null || item.category == category;
      bool matchesDate = true;

      if (startDate != null && endDate != null) {
        matchesDate = item.createdAt.isAfter(startDate) &&
            item.createdAt.isBefore(endDate.add(Duration(days: 1)));
      }

      return matchesType && matchesCategory && matchesDate;
    }).toList();
  }
}



