class FeedbackItem {
  final String id;
  final String type; // complaint, compliment, general
  final String category;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  FeedbackItem({
    required this.id,
    required this.type,
    required this.category,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  get title => null;
}