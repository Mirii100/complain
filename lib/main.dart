import 'package:complement_complain/screens%20/layout/admin.dart';
import 'package:complement_complain/screens%20/layout/analytic.dart';
import 'package:complement_complain/screens%20/layout/faq.dart';
import 'package:complement_complain/screens%20/layout/filter.dart';
import 'package:complement_complain/screens%20/layout/settings.dart';
import 'package:complement_complain/screens%20/models/admin.dart';
import 'package:complement_complain/screens%20/models/feedback_provider.dart';
import 'package:complement_complain/screens%20/models/feedback_selection.dart';
import 'package:complement_complain/screens%20/models/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(FeedbackApp());
}


class FeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anonymous Feedback System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FeedbackTypeSelectionScreen(),
        routes: {
          '/history': (context) => HistoryScreen(),
          '/admin': (context) => AdminDashboardScreen(),
          '/settings': (context) => SettingsScreen(),
          '/help': (context) => FAQHelpScreen(),
          '/analytics': (context) => AnalyticsScreen(),
          '/users': (context) => AdminUserManagementScreen(),
          '/filter': (context) => FilterSearchScreen(),
        },
      ),
    );
  }
}

