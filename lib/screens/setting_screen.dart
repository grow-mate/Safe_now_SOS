import 'package:flutter/material.dart';
import '../services/sos_service.dart';

class SettingsScreen extends StatefulWidget {
  final SOSService sosService;

  const SettingsScreen({Key? key, required this.sosService}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _vibrationEnabled = true;
  bool _soundEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _darkMode = widget.sosService.prefs.getBool('dark_mode') ?? false;
      _vibrationEnabled = widget.sosService.prefs.getBool('vibration') ?? true;
      _soundEnabled = widget.sosService.prefs.getBool('sound') ?? true;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    await widget.sosService.prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              _saveSetting('dark_mode', value);
            },
          ),
          SwitchListTile(
            title: const Text('Vibration'),
            subtitle: const Text('Vibrate on SOS activation'),
            value: _vibrationEnabled,
            onChanged: (value) {
              setState(() => _vibrationEnabled = value);
              _saveSetting('vibration', value);
            },
          ),
          SwitchListTile(
            title: const Text('Sound'),
            subtitle: const Text('Play sound on SOS activation'),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() => _soundEnabled = value);
              _saveSetting('sound', value);
            },
          ),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('SOS Emergency App v1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'SOS Emergency',
                applicationVersion: '1.0.0',
                applicationLegalese: '©2024 SafeNow',
              );
            },
          ),
        ],
      ),
    );
  }
}