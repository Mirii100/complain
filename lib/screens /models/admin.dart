import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminUserManagementScreen extends StatefulWidget {
  @override
  _AdminUserManagementScreenState createState() => _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'Admin User',
      'email': 'admin@example.com',
      'role': 'Administrator',
      'isActive': true,
    },
    {
      'id': '2',
      'name': 'Support Manager',
      'email': 'manager@example.com',
      'role': 'Manager',
      'isActive': true,
    },
    {
      'id': '3',
      'name': 'Customer Support',
      'email': 'support@example.com',
      'role': 'Viewer',
      'isActive': true,
    },
    {
      'id': '4',
      'name': 'Past Employee',
      'email': 'past@example.com',
      'role': 'Viewer',
      'isActive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('User Management'),
    ),
    body: ListView(
    padding: EdgeInsets.all(16.0),
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'System Users',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ElevatedButton.icon(
    icon: Icon(Icons.add),
    label: Text('Add User'),
    onPressed: () {
    _showAddUserDialog(context);
    },
    ),
    ],
    ),
    SizedBox(height: 16),
    Card(
    elevation: 4,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    Row(
    children: [
    Expanded(
    flex: 3,
    child: Text(
    'Name/Email',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    Expanded(
    flex: 2,
    child: Text(
    'Role',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    Expanded(
    flex: 2,
    child: Text(
    'Status',
    style: TextStyle(fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    ),
    Expanded(
    flex: 1,
    child: Text(
    'Actions',
    style: TextStyle(fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    ),
    ],
    ),
    Divider(),
    ..._users.map((user) => _buildUserRow(user)).toList(),
    ],
    ),
    ),
    ),
    SizedBox(height: 24),
    Card(
    elevation: 4,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Role Permissions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text('Administrator'),
          subtitle: Text('Full access to all features, can manage users and system settings'),
          leading: Icon(Icons.admin_panel_settings, color: Colors.red),
        ),
        ListTile(
          title: Text('Manager'),
          subtitle: Text('Can view all feedback and analytics, but cannot manage users or system settings'),
          leading: Icon(Icons.manage_accounts, color: Colors.orange),
        ),
        ListTile(
          title: Text('Viewer'),
          subtitle: Text('Can only view and respond to feedback, limited access to analytics'),
          leading: Icon(Icons.visibility, color: Colors.blue),
        ),
      ],
    ),
    ),
    ),
    ],
    ),
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  user['email'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(user['role']),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Chip(
                label: Text(
                  user['isActive'] ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: user['isActive'] ? Colors.green : Colors.grey,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Edit user action
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Administrator', 'Manager', 'Viewer'].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User added successfully')),
                );
              },
              child: Text('Add User'),
            ),
          ],
        );
      },
    );
  }
}