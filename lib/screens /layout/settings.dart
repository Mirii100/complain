import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _defaultView = 'All';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
      _defaultView = prefs.getString('default_view') ?? 'All';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
    await prefs.setString('default_view', _defaultView);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Notifications'),
            subtitle: Text('Receive alerts for new feedback'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Enable dark theme'),
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Default View'),
            subtitle: Text('Select default dashboard view'),
            trailing: DropdownButton<String>(
              value: _defaultView,
              onChanged: (value) {
                setState(() {
                  _defaultView = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Unread', child: Text('Unread')),
                DropdownMenuItem(value: 'Complaints', child: Text('Complaints')),
                DropdownMenuItem(value: 'Compliments', child: Text('Compliments')),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Data Storage'),
            subtitle: Text('Manage how feedback data is stored'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to data storage settings
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Settings'),
            subtitle: Text('Manage privacy and anonymization'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}