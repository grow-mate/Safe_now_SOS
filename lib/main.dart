import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(SOSApp(prefs: prefs));
}

class SOSApp extends StatelessWidget {
  final SharedPreferences prefs;

  const SOSApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS Emergency',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: HomeScreen(prefs: prefs),
    );
  }
}