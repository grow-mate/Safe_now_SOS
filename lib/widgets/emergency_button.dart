import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../services/sos_service.dart';

class SOSButton extends StatelessWidget {
  final SOSService sosService;

  const SOSButton({Key? key, required this.sosService}) : super(key: key);

  Future<void> _sendEmergencySMS() async {
    try {
      List<Map<String, String>> contacts = sosService.getContacts();
      if (contacts.isEmpty) {
        throw Exception('No emergency contacts found');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String message = 'Emergency! I need help. My location is: '
          'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

      for (var contact in contacts) {
        await sendSMS(message: message, recipients: [contact['number']!]);
      }
    } catch (e) {
      print('Error sending emergency SMS: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _sendEmergencySMS,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const Text(
        'SOS',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
