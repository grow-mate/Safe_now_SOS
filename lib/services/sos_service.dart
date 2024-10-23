import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'dart:async';

class SOSService {
  final Telephony telephony = Telephony.instance;
  final SharedPreferences prefs;

  SOSService(this.prefs);

  // Requesting necessary permissions
  Future<bool> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.location,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  // Getting the current location
  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          return null;
        }
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  // Sending an SOS message to all contacts
  Future<bool> sendSOSMessage(List<String> contacts) async {
    try {
      String message = 'EMERGENCY! I need help!';

      for (String contact in contacts) {
        if (contact.isNotEmpty) {
          await telephony.sendSms(
            to: contact,
            message: message,
          );
        }
      }

      return true;
    } catch (e) {
      print('Error sending SOS: $e');
      return false;
    }
  }

  // Saving a contact in SharedPreferences
  Future<void> saveContact(String name, String number) async {
    List<String>? contacts = prefs.getStringList('emergency_contacts') ?? [];
    contacts.add('$name:$number');
    await prefs.setStringList('emergency_contacts', contacts);
  }

  // Getting all emergency contacts from SharedPreferences
  List<Map<String, String>> getContacts() {
    List<String>? contacts = prefs.getStringList('emergency_contacts') ?? [];
    return contacts.map((contact) {
      var details = contact.split(':');
      return {'name': details[0], 'number': details[1]};
    }).toList();
  }

  // Deleting a contact by index
  Future<void> deleteContact(int index) async {
    List<String>? contacts = prefs.getStringList('emergency_contacts') ?? [];
    contacts.removeAt(index);
    await prefs.setStringList('emergency_contacts', contacts);
  }
}
