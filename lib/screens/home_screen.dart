import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/blog_service.dart';
import '../services/sos_service.dart';
import '../widgets/emergency_button.dart';
import 'blog_screen.dart';
import 'contact_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const HomeScreen({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sosService = SOSService(prefs);
    final blogService = BlogService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeNow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(sosService: sosService),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 8),
                    Text(
                      'Status: Monitoring',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'All systems operational.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SOSButton(sosService: sosService),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Press the button in case of emergency.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactsScreen(sosService: sosService),
              ),
            ),
            label: const Text('Emergency Contacts'),
            icon: const Icon(Icons.contacts),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogScreen(blogService: blogService),
              ),
            ),
            label: const Text('Read Blogs'),
            icon: const Icon(Icons.book),
          ),
        ],
      ),
    );
  }
}
