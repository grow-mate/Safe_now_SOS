import 'package:flutter/material.dart';
import '../services/sos_service.dart';

class ContactsScreen extends StatefulWidget {
  final SOSService sosService;

  const ContactsScreen({Key? key, required this.sosService}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Contact Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addContact,
                    child: const Text('Add Contact'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, String>>>(
              stream: Stream.periodic(
                const Duration(seconds: 1),
                (_) => widget.sosService.getContacts(),
              ),
              builder: (context, snapshot) {
                final contacts = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact['name']!),
                      subtitle: Text(contact['number']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteContact(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addContact() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.sosService.saveContact(
        _nameController.text,
        _phoneController.text,
      );
      _nameController.clear();
      _phoneController.clear();
    }
  }

  void _deleteContact(int index) {
    setState(() {
      widget.sosService.deleteContact(index);
    });
  }
}
